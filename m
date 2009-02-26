From: Thiago Galesi <thiagogalesi@gmail.com>
Subject: Re: [patch 3/7] make MTD headers use strict integer types
Date: Wed, 25 Feb 2009 21:32:50 -0300
Message-ID: <82ecf08e0902251632k550156e5k471fc2cab5e9a0fd@mail.gmail.com>
References: <20090225235138.062045835@arndb.de>
	 <20090225235515.357247809@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:43967 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZBZAcx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:32:53 -0500
In-Reply-To: <20090225235515.357247809@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

I don't know if the idea is to do all at once, but MTD has a lot of
things like u_char as well

--=20
-
Thiago Galesi


On Wed, Feb 25, 2009 at 8:51 PM,  <arnd@arndb.de> wrote:
> The MTD headers traditionally use stdint types rather than
> the kernel integer types. This converts them to do the
> same as all the others.
>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =A0include/linux/jffs2.h =A0 =A0| =A0 26 ++++++++--------
> =A0include/mtd/inftl-user.h | =A0 36 ++++++++++++------------
> =A0include/mtd/jffs2-user.h | =A0 =A04 +-
> =A0include/mtd/mtd-abi.h =A0 =A0| =A0 64 +++++++++++++++++++++-------=
--------------
> =A0include/mtd/nftl-user.h =A0| =A0 30 ++++++++++----------
> =A0include/mtd/ubi-user.h =A0 | =A0 70 +++++++++++++++++++++++-------=
----------------
> =A06 files changed, 115 insertions(+), 115 deletions(-)
>
> Index: linux-2.6/include/linux/jffs2.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/jffs2.h
> +++ linux-2.6/include/linux/jffs2.h
> @@ -12,6 +12,7 @@
> =A0#ifndef __LINUX_JFFS2_H__
> =A0#define __LINUX_JFFS2_H__
>
> +#include <linux/types.h>
> =A0#include <linux/magic.h>
>
> =A0/* You must include something which defines the C99 uintXX_t types=
=2E
> @@ -91,15 +92,15 @@
> =A0 =A0byteswapping */
>
> =A0typedef struct {
> - =A0 =A0 =A0 uint32_t v32;
> + =A0 =A0 =A0 __u32 v32;
> =A0} __attribute__((packed)) jint32_t;
>
> =A0typedef struct {
> - =A0 =A0 =A0 uint32_t m;
> + =A0 =A0 =A0 __u32 m;
> =A0} __attribute__((packed)) jmode_t;
>
> =A0typedef struct {
> - =A0 =A0 =A0 uint16_t v16;
> + =A0 =A0 =A0 __u16 v16;
> =A0} __attribute__((packed)) jint16_t;
>
> =A0struct jffs2_unknown_node
> @@ -121,12 +122,12 @@ struct jffs2_raw_dirent
> =A0 =A0 =A0 =A0jint32_t version;
> =A0 =A0 =A0 =A0jint32_t ino; /* =3D=3D zero for unlink */
> =A0 =A0 =A0 =A0jint32_t mctime;
> - =A0 =A0 =A0 uint8_t nsize;
> - =A0 =A0 =A0 uint8_t type;
> - =A0 =A0 =A0 uint8_t unused[2];
> + =A0 =A0 =A0 __u8 nsize;
> + =A0 =A0 =A0 __u8 type;
> + =A0 =A0 =A0 __u8 unused[2];
> =A0 =A0 =A0 =A0jint32_t node_crc;
> =A0 =A0 =A0 =A0jint32_t name_crc;
> - =A0 =A0 =A0 uint8_t name[0];
> + =A0 =A0 =A0 __u8 name[0];
> =A0};
>
> =A0/* The JFFS2 raw inode structure: Used for storage on physical med=
ia. =A0*/
> @@ -153,12 +154,12 @@ struct jffs2_raw_inode
> =A0 =A0 =A0 =A0jint32_t offset; =A0 =A0 /* Where to begin to write. =A0=
*/
> =A0 =A0 =A0 =A0jint32_t csize; =A0 =A0 =A0/* (Compressed) data size *=
/
> =A0 =A0 =A0 =A0jint32_t dsize; =A0 =A0 =A0/* Size of the node's data.=
 (after decompression) */
> - =A0 =A0 =A0 uint8_t compr; =A0 =A0 =A0 /* Compression algorithm use=
d */
> - =A0 =A0 =A0 uint8_t usercompr; =A0 /* Compression algorithm request=
ed by the user */
> + =A0 =A0 =A0 __u8 compr; =A0 =A0 =A0 /* Compression algorithm used *=
/
> + =A0 =A0 =A0 __u8 usercompr; =A0 /* Compression algorithm requested =
by the user */
> =A0 =A0 =A0 =A0jint16_t flags; =A0 =A0 =A0/* See JFFS2_INO_FLAG_* */
> =A0 =A0 =A0 =A0jint32_t data_crc; =A0 /* CRC for the (compressed) dat=
a. =A0*/
> =A0 =A0 =A0 =A0jint32_t node_crc; =A0 /* CRC for the raw inode (exclu=
ding data) =A0*/
> - =A0 =A0 =A0 uint8_t data[0];
> + =A0 =A0 =A0 __u8 data[0];
> =A0};
>
> =A0struct jffs2_raw_xattr {
> @@ -168,12 +169,12 @@ struct jffs2_raw_xattr {
> =A0 =A0 =A0 =A0jint32_t hdr_crc;
> =A0 =A0 =A0 =A0jint32_t xid; =A0 =A0 =A0 =A0 =A0 /* XATTR identifier =
number */
> =A0 =A0 =A0 =A0jint32_t version;
> - =A0 =A0 =A0 uint8_t xprefix;
> - =A0 =A0 =A0 uint8_t name_len;
> + =A0 =A0 =A0 __u8 xprefix;
> + =A0 =A0 =A0 __u8 name_len;
> =A0 =A0 =A0 =A0jint16_t value_len;
> =A0 =A0 =A0 =A0jint32_t data_crc;
> =A0 =A0 =A0 =A0jint32_t node_crc;
> - =A0 =A0 =A0 uint8_t data[0];
> + =A0 =A0 =A0 __u8 data[0];
> =A0} __attribute__((packed));
>
> =A0struct jffs2_raw_xref
> Index: linux-2.6/include/mtd/inftl-user.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/mtd/inftl-user.h
> +++ linux-2.6/include/mtd/inftl-user.h
> @@ -16,33 +16,33 @@
> =A0/* Block Control Information */
>
> =A0struct inftl_bci {
> - =A0 =A0 =A0 uint8_t ECCsig[6];
> - =A0 =A0 =A0 uint8_t Status;
> - =A0 =A0 =A0 uint8_t Status1;
> + =A0 =A0 =A0 __u8 ECCsig[6];
> + =A0 =A0 =A0 __u8 Status;
> + =A0 =A0 =A0 __u8 Status1;
> =A0} __attribute__((packed));
>
> =A0struct inftl_unithead1 {
> - =A0 =A0 =A0 uint16_t virtualUnitNo;
> - =A0 =A0 =A0 uint16_t prevUnitNo;
> - =A0 =A0 =A0 uint8_t ANAC;
> - =A0 =A0 =A0 uint8_t NACs;
> - =A0 =A0 =A0 uint8_t parityPerField;
> - =A0 =A0 =A0 uint8_t discarded;
> + =A0 =A0 =A0 __u16 virtualUnitNo;
> + =A0 =A0 =A0 __u16 prevUnitNo;
> + =A0 =A0 =A0 __u8 ANAC;
> + =A0 =A0 =A0 __u8 NACs;
> + =A0 =A0 =A0 __u8 parityPerField;
> + =A0 =A0 =A0 __u8 discarded;
> =A0} __attribute__((packed));
>
> =A0struct inftl_unithead2 {
> - =A0 =A0 =A0 uint8_t parityPerField;
> - =A0 =A0 =A0 uint8_t ANAC;
> - =A0 =A0 =A0 uint16_t prevUnitNo;
> - =A0 =A0 =A0 uint16_t virtualUnitNo;
> - =A0 =A0 =A0 uint8_t NACs;
> - =A0 =A0 =A0 uint8_t discarded;
> + =A0 =A0 =A0 __u8 parityPerField;
> + =A0 =A0 =A0 __u8 ANAC;
> + =A0 =A0 =A0 __u16 prevUnitNo;
> + =A0 =A0 =A0 __u16 virtualUnitNo;
> + =A0 =A0 =A0 __u8 NACs;
> + =A0 =A0 =A0 __u8 discarded;
> =A0} __attribute__((packed));
>
> =A0struct inftl_unittail {
> - =A0 =A0 =A0 uint8_t Reserved[4];
> - =A0 =A0 =A0 uint16_t EraseMark;
> - =A0 =A0 =A0 uint16_t EraseMark1;
> + =A0 =A0 =A0 __u8 Reserved[4];
> + =A0 =A0 =A0 __u16 EraseMark;
> + =A0 =A0 =A0 __u16 EraseMark1;
> =A0} __attribute__((packed));
>
> =A0union inftl_uci {
> Index: linux-2.6/include/mtd/jffs2-user.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/mtd/jffs2-user.h
> +++ linux-2.6/include/mtd/jffs2-user.h
> @@ -7,6 +7,7 @@
>
> =A0/* This file is blessed for inclusion by userspace */
> =A0#include <linux/jffs2.h>
> +#include <linux/types.h>
> =A0#include <endian.h>
> =A0#include <byteswap.h>
>
> @@ -19,8 +20,8 @@
>
> =A0extern int target_endian;
>
> -#define t16(x) ({ uint16_t __b =3D (x); (target_endian=3D=3D__BYTE_O=
RDER)?__b:bswap_16(__b); })
> -#define t32(x) ({ uint32_t __b =3D (x); (target_endian=3D=3D__BYTE_O=
RDER)?__b:bswap_32(__b); })
> +#define t16(x) ({ __u16 __b =3D (x); (target_endian=3D=3D__BYTE_ORDE=
R)?__b:bswap_16(__b); })
> +#define t32(x) ({ __u32 __b =3D (x); (target_endian=3D=3D__BYTE_ORDE=
R)?__b:bswap_32(__b); })
>
> =A0#define cpu_to_je16(x) ((jint16_t){t16(x)})
> =A0#define cpu_to_je32(x) ((jint32_t){t32(x)})
> Index: linux-2.6/include/mtd/mtd-abi.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/mtd/mtd-abi.h
> +++ linux-2.6/include/mtd/mtd-abi.h
> @@ -5,14 +5,16 @@
> =A0#ifndef __MTD_ABI_H__
> =A0#define __MTD_ABI_H__
>
> +#include <linux/types.h>
> +
> =A0struct erase_info_user {
> - =A0 =A0 =A0 uint32_t start;
> - =A0 =A0 =A0 uint32_t length;
> + =A0 =A0 =A0 __u32 start;
> + =A0 =A0 =A0 __u32 length;
> =A0};
>
> =A0struct mtd_oob_buf {
> - =A0 =A0 =A0 uint32_t start;
> - =A0 =A0 =A0 uint32_t length;
> + =A0 =A0 =A0 __u32 start;
> + =A0 =A0 =A0 __u32 length;
> =A0 =A0 =A0 =A0unsigned char __user *ptr;
> =A0};
>
> @@ -48,30 +50,30 @@ struct mtd_oob_buf {
> =A0#define MTD_OTP_USER =A0 =A0 =A0 =A0 =A0 2
>
> =A0struct mtd_info_user {
> - =A0 =A0 =A0 uint8_t type;
> - =A0 =A0 =A0 uint32_t flags;
> - =A0 =A0 =A0 uint32_t size; =A0 // Total size of the MTD
> - =A0 =A0 =A0 uint32_t erasesize;
> - =A0 =A0 =A0 uint32_t writesize;
> - =A0 =A0 =A0 uint32_t oobsize; =A0 // Amount of OOB data per block (=
e.g. 16)
> + =A0 =A0 =A0 __u8 type;
> + =A0 =A0 =A0 __u32 flags;
> + =A0 =A0 =A0 __u32 size; =A0 =A0 =A0// Total size of the MTD
> + =A0 =A0 =A0 __u32 erasesize;
> + =A0 =A0 =A0 __u32 writesize;
> + =A0 =A0 =A0 __u32 oobsize; =A0 // Amount of OOB data per block (e.g=
=2E 16)
> =A0 =A0 =A0 =A0/* The below two fields are obsolete and broken, do no=
t use them
> =A0 =A0 =A0 =A0 * (TODO: remove at some point) */
> - =A0 =A0 =A0 uint32_t ecctype;
> - =A0 =A0 =A0 uint32_t eccsize;
> + =A0 =A0 =A0 __u32 ecctype;
> + =A0 =A0 =A0 __u32 eccsize;
> =A0};
>
> =A0struct region_info_user {
> - =A0 =A0 =A0 uint32_t offset; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* At w=
hich this region starts,
> + =A0 =A0 =A0 __u32 offset; =A0 =A0 =A0 =A0 =A0 /* At which this regi=
on starts,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 * from the beginning of the MTD */
> - =A0 =A0 =A0 uint32_t erasesize; =A0 =A0 =A0 =A0 =A0 =A0 /* For this=
 region */
> - =A0 =A0 =A0 uint32_t numblocks; =A0 =A0 =A0 =A0 =A0 =A0 /* Number o=
f blocks in this region */
> - =A0 =A0 =A0 uint32_t regionindex;
> + =A0 =A0 =A0 __u32 erasesize; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* For =
this region */
> + =A0 =A0 =A0 __u32 numblocks; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Numb=
er of blocks in this region */
> + =A0 =A0 =A0 __u32 regionindex;
> =A0};
>
> =A0struct otp_info {
> - =A0 =A0 =A0 uint32_t start;
> - =A0 =A0 =A0 uint32_t length;
> - =A0 =A0 =A0 uint32_t locked;
> + =A0 =A0 =A0 __u32 start;
> + =A0 =A0 =A0 __u32 length;
> + =A0 =A0 =A0 __u32 locked;
> =A0};
>
> =A0#define MEMGETINFO =A0 =A0 =A0 =A0 =A0 =A0 _IOR('M', 1, struct mtd=
_info_user)
> @@ -99,15 +101,15 @@ struct otp_info {
> =A0* interfaces
> =A0*/
> =A0struct nand_oobinfo {
> - =A0 =A0 =A0 uint32_t useecc;
> - =A0 =A0 =A0 uint32_t eccbytes;
> - =A0 =A0 =A0 uint32_t oobfree[8][2];
> - =A0 =A0 =A0 uint32_t eccpos[32];
> + =A0 =A0 =A0 __u32 useecc;
> + =A0 =A0 =A0 __u32 eccbytes;
> + =A0 =A0 =A0 __u32 oobfree[8][2];
> + =A0 =A0 =A0 __u32 eccpos[32];
> =A0};
>
> =A0struct nand_oobfree {
> - =A0 =A0 =A0 uint32_t offset;
> - =A0 =A0 =A0 uint32_t length;
> + =A0 =A0 =A0 __u32 offset;
> + =A0 =A0 =A0 __u32 length;
> =A0};
>
> =A0#define MTD_MAX_OOBFREE_ENTRIES =A0 =A0 =A0 =A08
> @@ -116,9 +118,9 @@ struct nand_oobfree {
> =A0* diagnosis and to allow creation of raw images
> =A0*/
> =A0struct nand_ecclayout {
> - =A0 =A0 =A0 uint32_t eccbytes;
> - =A0 =A0 =A0 uint32_t eccpos[64];
> - =A0 =A0 =A0 uint32_t oobavail;
> + =A0 =A0 =A0 __u32 eccbytes;
> + =A0 =A0 =A0 __u32 eccpos[64];
> + =A0 =A0 =A0 __u32 oobavail;
> =A0 =A0 =A0 =A0struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES];
> =A0};
>
> @@ -131,10 +133,10 @@ struct nand_ecclayout {
> =A0* @bbtblocks: number of blocks reserved for bad block tables
> =A0*/
> =A0struct mtd_ecc_stats {
> - =A0 =A0 =A0 uint32_t corrected;
> - =A0 =A0 =A0 uint32_t failed;
> - =A0 =A0 =A0 uint32_t badblocks;
> - =A0 =A0 =A0 uint32_t bbtblocks;
> + =A0 =A0 =A0 __u32 corrected;
> + =A0 =A0 =A0 __u32 failed;
> + =A0 =A0 =A0 __u32 badblocks;
> + =A0 =A0 =A0 __u32 bbtblocks;
> =A0};
>
> =A0/*
> Index: linux-2.6/include/mtd/nftl-user.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/mtd/nftl-user.h
> +++ linux-2.6/include/mtd/nftl-user.h
> @@ -6,33 +6,35 @@
> =A0#ifndef __MTD_NFTL_USER_H__
> =A0#define __MTD_NFTL_USER_H__
>
> +#include <linux/types.h>
> +
> =A0/* Block Control Information */
>
> =A0struct nftl_bci {
> =A0 =A0 =A0 =A0unsigned char ECCSig[6];
> - =A0 =A0 =A0 uint8_t Status;
> - =A0 =A0 =A0 uint8_t Status1;
> + =A0 =A0 =A0 __u8 Status;
> + =A0 =A0 =A0 __u8 Status1;
> =A0}__attribute__((packed));
>
> =A0/* Unit Control Information */
>
> =A0struct nftl_uci0 {
> - =A0 =A0 =A0 uint16_t VirtUnitNum;
> - =A0 =A0 =A0 uint16_t ReplUnitNum;
> - =A0 =A0 =A0 uint16_t SpareVirtUnitNum;
> - =A0 =A0 =A0 uint16_t SpareReplUnitNum;
> + =A0 =A0 =A0 __u16 VirtUnitNum;
> + =A0 =A0 =A0 __u16 ReplUnitNum;
> + =A0 =A0 =A0 __u16 SpareVirtUnitNum;
> + =A0 =A0 =A0 __u16 SpareReplUnitNum;
> =A0} __attribute__((packed));
>
> =A0struct nftl_uci1 {
> - =A0 =A0 =A0 uint32_t WearInfo;
> - =A0 =A0 =A0 uint16_t EraseMark;
> - =A0 =A0 =A0 uint16_t EraseMark1;
> + =A0 =A0 =A0 __u32 WearInfo;
> + =A0 =A0 =A0 __u16 EraseMark;
> + =A0 =A0 =A0 __u16 EraseMark1;
> =A0} __attribute__((packed));
>
> =A0struct nftl_uci2 {
> - =A0 =A0 =A0 =A0uint16_t FoldMark;
> - =A0 =A0 =A0 =A0uint16_t FoldMark1;
> - =A0 =A0 =A0 uint32_t unused;
> + =A0 =A0 =A0 =A0__u16 FoldMark;
> + =A0 =A0 =A0 =A0__u16 FoldMark1;
> + =A0 =A0 =A0 __u32 unused;
> =A0} __attribute__((packed));
>
> =A0union nftl_uci {
> @@ -50,9 +52,9 @@ struct nftl_oob {
>
> =A0struct NFTLMediaHeader {
> =A0 =A0 =A0 =A0char DataOrgID[6];
> - =A0 =A0 =A0 uint16_t NumEraseUnits;
> - =A0 =A0 =A0 uint16_t FirstPhysicalEUN;
> - =A0 =A0 =A0 uint32_t FormattedSize;
> + =A0 =A0 =A0 __u16 NumEraseUnits;
> + =A0 =A0 =A0 __u16 FirstPhysicalEUN;
> + =A0 =A0 =A0 __u32 FormattedSize;
> =A0 =A0 =A0 =A0unsigned char UnitSizeFactor;
> =A0} __attribute__((packed));
>
> Index: linux-2.6/include/mtd/ubi-user.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/mtd/ubi-user.h
> +++ linux-2.6/include/mtd/ubi-user.h
> @@ -21,6 +21,8 @@
> =A0#ifndef __UBI_USER_H__
> =A0#define __UBI_USER_H__
>
> +#include <linux/types.h>
> +
> =A0/*
> =A0* UBI device creation (the same as MTD device attachment)
> =A0* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -152,7 +154,7 @@
> =A0/* Create an UBI volume */
> =A0#define UBI_IOCMKVOL _IOW(UBI_IOC_MAGIC, 0, struct ubi_mkvol_req)
> =A0/* Remove an UBI volume */
> -#define UBI_IOCRMVOL _IOW(UBI_IOC_MAGIC, 1, int32_t)
> +#define UBI_IOCRMVOL _IOW(UBI_IOC_MAGIC, 1, __s32)
> =A0/* Re-size an UBI volume */
> =A0#define UBI_IOCRSVOL _IOW(UBI_IOC_MAGIC, 2, struct ubi_rsvol_req)
> =A0/* Re-name volumes */
> @@ -165,24 +167,24 @@
> =A0/* Attach an MTD device */
> =A0#define UBI_IOCATT _IOW(UBI_CTRL_IOC_MAGIC, 64, struct ubi_attach_=
req)
> =A0/* Detach an MTD device */
> -#define UBI_IOCDET _IOW(UBI_CTRL_IOC_MAGIC, 65, int32_t)
> +#define UBI_IOCDET _IOW(UBI_CTRL_IOC_MAGIC, 65, __s32)
>
> =A0/* ioctl commands of UBI volume character devices */
>
> =A0#define UBI_VOL_IOC_MAGIC 'O'
>
> =A0/* Start UBI volume update */
> -#define UBI_IOCVOLUP _IOW(UBI_VOL_IOC_MAGIC, 0, int64_t)
> +#define UBI_IOCVOLUP _IOW(UBI_VOL_IOC_MAGIC, 0, __s64)
> =A0/* LEB erasure command, used for debugging, disabled by default */
> -#define UBI_IOCEBER _IOW(UBI_VOL_IOC_MAGIC, 1, int32_t)
> +#define UBI_IOCEBER _IOW(UBI_VOL_IOC_MAGIC, 1, __s32)
> =A0/* Atomic LEB change command */
> -#define UBI_IOCEBCH _IOW(UBI_VOL_IOC_MAGIC, 2, int32_t)
> +#define UBI_IOCEBCH _IOW(UBI_VOL_IOC_MAGIC, 2, __s32)
> =A0/* Map LEB command */
> =A0#define UBI_IOCEBMAP _IOW(UBI_VOL_IOC_MAGIC, 3, struct ubi_map_req=
)
> =A0/* Unmap LEB command */
> -#define UBI_IOCEBUNMAP _IOW(UBI_VOL_IOC_MAGIC, 4, int32_t)
> +#define UBI_IOCEBUNMAP _IOW(UBI_VOL_IOC_MAGIC, 4, __s32)
> =A0/* Check if LEB is mapped command */
> -#define UBI_IOCEBISMAP _IOR(UBI_VOL_IOC_MAGIC, 5, int32_t)
> +#define UBI_IOCEBISMAP _IOR(UBI_VOL_IOC_MAGIC, 5, __s32)
> =A0/* Set an UBI volume property */
> =A0#define UBI_IOCSETPROP _IOW(UBI_VOL_IOC_MAGIC, 6, struct ubi_set_p=
rop_req)
>
> @@ -260,10 +262,10 @@ enum {
> =A0* sub-page of the first page and add needed padding.
> =A0*/
> =A0struct ubi_attach_req {
> - =A0 =A0 =A0 int32_t ubi_num;
> - =A0 =A0 =A0 int32_t mtd_num;
> - =A0 =A0 =A0 int32_t vid_hdr_offset;
> - =A0 =A0 =A0 int8_t padding[12];
> + =A0 =A0 =A0 __s32 ubi_num;
> + =A0 =A0 =A0 __s32 mtd_num;
> + =A0 =A0 =A0 __s32 vid_hdr_offset;
> + =A0 =A0 =A0 __s8 padding[12];
> =A0};
>
> =A0/**
> @@ -298,13 +300,13 @@ struct ubi_attach_req {
> =A0* BLOBs, without caring about how to properly align them.
> =A0*/
> =A0struct ubi_mkvol_req {
> - =A0 =A0 =A0 int32_t vol_id;
> - =A0 =A0 =A0 int32_t alignment;
> - =A0 =A0 =A0 int64_t bytes;
> - =A0 =A0 =A0 int8_t vol_type;
> - =A0 =A0 =A0 int8_t padding1;
> - =A0 =A0 =A0 int16_t name_len;
> - =A0 =A0 =A0 int8_t padding2[4];
> + =A0 =A0 =A0 __s32 vol_id;
> + =A0 =A0 =A0 __s32 alignment;
> + =A0 =A0 =A0 __s64 bytes;
> + =A0 =A0 =A0 __s8 vol_type;
> + =A0 =A0 =A0 __s8 padding1;
> + =A0 =A0 =A0 __s16 name_len;
> + =A0 =A0 =A0 __s8 padding2[4];
> =A0 =A0 =A0 =A0char name[UBI_MAX_VOLUME_NAME + 1];
> =A0} __attribute__ ((packed));
>
> @@ -320,8 +322,8 @@ struct ubi_mkvol_req {
> =A0* zero number of bytes).
> =A0*/
> =A0struct ubi_rsvol_req {
> - =A0 =A0 =A0 int64_t bytes;
> - =A0 =A0 =A0 int32_t vol_id;
> + =A0 =A0 =A0 __s64 bytes;
> + =A0 =A0 =A0 __s32 vol_id;
> =A0} __attribute__ ((packed));
>
> =A0/**
> @@ -356,12 +358,12 @@ struct ubi_rsvol_req {
> =A0* re-name request.
> =A0*/
> =A0struct ubi_rnvol_req {
> - =A0 =A0 =A0 int32_t count;
> - =A0 =A0 =A0 int8_t padding1[12];
> + =A0 =A0 =A0 __s32 count;
> + =A0 =A0 =A0 __s8 padding1[12];
> =A0 =A0 =A0 =A0struct {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int32_t vol_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int16_t name_len;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int8_t =A0padding2[2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __s32 vol_id;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __s16 name_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __s8 =A0padding2[2];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char =A0 =A0name[UBI_MAX_VOLUME_NAME +=
 1];
> =A0 =A0 =A0 =A0} ents[UBI_MAX_RNVOL];
> =A0} __attribute__ ((packed));
> @@ -375,10 +377,10 @@ struct ubi_rnvol_req {
> =A0* @padding: reserved for future, not used, has to be zeroed
> =A0*/
> =A0struct ubi_leb_change_req {
> - =A0 =A0 =A0 int32_t lnum;
> - =A0 =A0 =A0 int32_t bytes;
> - =A0 =A0 =A0 int8_t =A0dtype;
> - =A0 =A0 =A0 int8_t =A0padding[7];
> + =A0 =A0 =A0 __s32 lnum;
> + =A0 =A0 =A0 __s32 bytes;
> + =A0 =A0 =A0 __s8 =A0dtype;
> + =A0 =A0 =A0 __s8 =A0padding[7];
> =A0} __attribute__ ((packed));
>
> =A0/**
> @@ -388,9 +390,9 @@ struct ubi_leb_change_req {
> =A0* @padding: reserved for future, not used, has to be zeroed
> =A0*/
> =A0struct ubi_map_req {
> - =A0 =A0 =A0 int32_t lnum;
> - =A0 =A0 =A0 int8_t =A0dtype;
> - =A0 =A0 =A0 int8_t =A0padding[3];
> + =A0 =A0 =A0 __s32 lnum;
> + =A0 =A0 =A0 __s8 =A0dtype;
> + =A0 =A0 =A0 __s8 =A0padding[3];
> =A0} __attribute__ ((packed));
>
>
> @@ -402,9 +404,9 @@ struct ubi_map_req {
> =A0* @value: value to set
> =A0*/
> =A0struct ubi_set_prop_req {
> - =A0 =A0 =A0 uint8_t =A0property;
> - =A0 =A0 =A0 uint8_t =A0padding[7];
> - =A0 =A0 =A0 uint64_t value;
> + =A0 =A0 =A0 __u8 =A0property;
> + =A0 =A0 =A0 __u8 =A0padding[7];
> + =A0 =A0 =A0 __u64 value;
> =A0} =A0__attribute__ ((packed));
>
> =A0#endif /* __UBI_USER_H__ */
>
> --
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
