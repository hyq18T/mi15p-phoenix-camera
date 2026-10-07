"""zipalign-compatible APK alignment in pure Python.

Supports the subset used by the Phoenix build:
    zipalign16.py [-f] [-P <pagesize_kib>] <align> <infile.zip> <outfile.zip>

Every entry data offset is aligned to <align> bytes; uncompressed ".so" entries
are aligned to <pagesize_kib> KiB. Matches Android build-tools 35
`zipalign -P <pagesize>` behaviour (padding is stored in a 0xD935 extra field).

Entry sizes, CRCs and flags come from the central directory, because entries
written by java.util.zip.ZipOutputStream carry a data descriptor (general
purpose flag 0x08) whose local header holds zeroed sizes.
"""
from __future__ import annotations

import argparse
import struct
import zipfile

ALIGN_ID = 0xD935
LH = struct.Struct('<IHHHHHIIIHH')
CD = struct.Struct('<IHHHHHHIIIHHHHHII')
EOCD = struct.Struct('<IHHHHIIH')


def load(src):
    entries = []
    with zipfile.ZipFile(src) as zf, open(src, 'rb') as fh:
        for zi in zf.infolist():
            fh.seek(zi.header_offset)
            head = fh.read(LH.size)
            signature, _, _, _, _, _, _, _, _, nlen, elen = LH.unpack(head)
            if signature != 0x04034B50:
                raise ValueError(f'bad local header for {zi.filename}')
            name = fh.read(nlen)
            extra = fh.read(elen)
            entries.append({
                'zi': zi, 'name': name, 'extra': extra,
                'flags': zi.flag_bits, 'method': zi.compress_type,
                'mtime': zi.date_time, 'crc': zi.CRC,
                'csize': zi.compress_size, 'usize': zi.file_size,
                'data_off': zi.header_offset + LH.size + nlen + elen,
            })
    return entries


def _dos_time(zi):
    year, month, day, hour, minute, second = zi.date_time
    mdate = ((year - 1980) << 9) | (month << 5) | day
    mtime = (hour << 11) | (minute << 5) | (second // 2)
    return mtime, mdate


def run(src, dst, align, page_kib):
    entries = load(src)
    page = page_kib * 1024
    with open(src, 'rb') as fin, open(dst, 'wb') as fout:
        placed = []
        for e in entries:
            zi = e['zi']
            mtime, mdate = _dos_time(zi)
            pos = fout.tell()
            base = pos + LH.size + len(e['name'])
            stored = e['method'] == 0
            want = page if stored and e['name'].lower().endswith(b'.so') else align
            pad = (-base) % want
            if 0 < pad < 4:
                pad += want
            extra = b''
            if pad >= 4:
                extra = struct.pack('<HH', ALIGN_ID, pad - 4) + b'\0' * (pad - 4)
            fin.seek(e['data_off'])
            payload = fin.read(e['csize'])
            if len(payload) != e['csize']:
                raise ValueError(f'truncated entry {zi.filename}')
            flags = e['flags'] & ~0x08
            fout.write(LH.pack(0x04034B50, max(20, zi.extract_version), flags, e['method'],
                               mtime, mdate, e['crc'], e['csize'], e['usize'],
                               len(e['name']), len(extra)))
            fout.write(e['name'])
            fout.write(extra)
            data_start = fout.tell()
            if data_start % want:
                raise ValueError(f'{zi.filename} misaligned: {data_start} % {want}')
            fout.write(payload)
            placed.append((e, pos, extra, mtime, mdate))

        cd_offset = fout.tell()
        for e, pos, extra, mtime, mdate in placed:
            zi = e['zi']
            name = e['name']
            comment = zi.comment.encode('utf-8') if zi.comment else b''
            cd_extra = e['extra']
            fout.write(CD.pack(
                0x02014B50, zi.create_version, max(20, zi.extract_version),
                e['flags'] & ~0x08, e['method'], mtime, mdate, e['crc'],
                e['csize'], e['usize'], len(name), len(cd_extra), len(comment), 0,
                zi.internal_attr, zi.external_attr, pos))
            fout.write(name)
            fout.write(cd_extra)
            fout.write(comment)
        cd_size = fout.tell() - cd_offset
        count = len(placed)
        if count >= 0xFFFF or cd_offset >= 0xFFFFFFFF:
            raise ValueError('zip64 not supported')
        fout.write(EOCD.pack(0x06054B50, 0, 0, count, count, cd_size, cd_offset, 0))
    return count


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('-f', '--force', action='store_true')
    ap.add_argument('-P', '--pagesize', type=int, default=16)
    ap.add_argument('align', type=int)
    ap.add_argument('infile')
    ap.add_argument('outfile')
    args = ap.parse_args()
    count = run(args.infile, args.outfile, args.align, args.pagesize)
    print(f'aligned {count} entries (align={args.align}, pagesize={args.pagesize}K)')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())