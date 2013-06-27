From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: m32r: include: asm: add ioread*_rep() and iowrite*_rep()
Date: Thu, 27 Jun 2013 12:42:09 +0800
Message-ID: <51CBC2A1.6070204@asianux.com>
References: <51CBA43F.9050000@asianux.com> <51CBAA1E.8000206@asianux.com> <51CBB1A9.5080203@asianux.com> <51CBC186.3080401@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:31874 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab3F0EnB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 00:43:01 -0400
In-Reply-To: <51CBC186.3080401@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hello Maintainers:

If the related 4 patches for io.h pass your checking, it seems OK to
merge them into one patch, the diff like below:

--------------------------------diff begin-----------------------------=
-

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 4010f1f..5506d86 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -67,6 +67,7 @@ static inline void __iomem *ioremap(unsigned long off=
set, unsigned long size)
=20
 extern void iounmap(volatile void __iomem *addr);
 #define ioremap_nocache(off,size) ioremap(off,size)
+#define ioremap_wc ioremap_nocache
=20
 /*
  * IO bus memory addresses are also 1:1 with the physical address
@@ -162,12 +163,30 @@ static inline void _writel(unsigned long l, unsig=
ned long addr)
 #define __raw_writew writew
 #define __raw_writel writel
=20
-#define ioread8 read
+#define ioread8 readb
 #define ioread16 readw
+#define ioread16be(addr)        __be16_to_cpu(__raw_readw(addr))
 #define ioread32 readl
+#define ioread32be(addr)        __be32_to_cpu(__raw_readl(addr))
 #define iowrite8 writeb
 #define iowrite16 writew
+#define iowrite16be(v, addr)    __raw_writew(__cpu_to_be16(v), addr)
 #define iowrite32 writel
+#define iowrite32be(v, addr)    __raw_writel(__cpu_to_be32(v), addr)
+
+#define ioread8_rep(p, dst, count) \
+	insb((unsigned long) (p), (dst), (count))
+#define ioread16_rep(p, dst, count) \
+	insw((unsigned long) (p), (dst), (count))
+#define ioread32_rep(p, dst, count) \
+	insl((unsigned long) (p), (dst), (count))
+
+#define iowrite8_rep(p, src, count) \
+	outsb((unsigned long) (p), (src), (count))
+#define iowrite16_rep(p, src, count) \
+	outsw((unsigned long) (p), (src), (count))
+#define iowrite32_rep(p, src, count) \
+	outsl((unsigned long) (p), (src), (count))
=20
 #define mmiowb()

--------------------------------diff end-------------------------------=
-

Thanks.

On 06/27/2013 12:37 PM, Chen Gang wrote:
> add generic ioread*_rep() and iowrite*_rep(), or compiling failed.
>=20
> The related error (with allmodconfig):
>=20
>     CC [M]  drivers/mtd/nand/nand_base.o
>   drivers/mtd/nand/nand_base.c: In function =91nand_write_buf=92:
>   drivers/mtd/nand/nand_base.c:216:2: error: implicit declaration of =
function =91iowrite8_rep=92 [-Werror=3Dimplicit-function-declaration]
>   drivers/mtd/nand/nand_base.c: In function =91nand_read_buf=92:
>   drivers/mtd/nand/nand_base.c:231:2: error: implicit declaration of =
function =91ioread8_rep=92 [-Werror=3Dimplicit-function-declaration]
>   drivers/mtd/nand/nand_base.c: In function =91nand_write_buf16=92:
>   drivers/mtd/nand/nand_base.c:247:2: error: implicit declaration of =
function =91iowrite16_rep=92 [-Werror=3Dimplicit-function-declaration]
>   drivers/mtd/nand/nand_base.c: In function =91nand_read_buf16=92:
>   drivers/mtd/nand/nand_base.c:263:2: error: implicit declaration of =
function =91ioread16_rep=92 [-Werror=3Dimplicit-function-declaration]
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/m32r/include/asm/io.h |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
> index 4010f1f..167d6ed 100644
> --- a/arch/m32r/include/asm/io.h
> +++ b/arch/m32r/include/asm/io.h
> @@ -169,6 +169,20 @@ static inline void _writel(unsigned long l, unsi=
gned long addr)
>  #define iowrite16 writew
>  #define iowrite32 writel
> =20
> +#define ioread8_rep(p, dst, count) \
> +	insb((unsigned long) (p), (dst), (count))
> +#define ioread16_rep(p, dst, count) \
> +	insw((unsigned long) (p), (dst), (count))
> +#define ioread32_rep(p, dst, count) \
> +	insl((unsigned long) (p), (dst), (count))
> +
> +#define iowrite8_rep(p, src, count) \
> +	outsb((unsigned long) (p), (src), (count))
> +#define iowrite16_rep(p, src, count) \
> +	outsw((unsigned long) (p), (src), (count))
> +#define iowrite32_rep(p, src, count) \
> +	outsl((unsigned long) (p), (src), (count))
> +
>  #define mmiowb()
> =20
>  #define flush_write_buffers() do { } while (0)  /* M32R_FIXME */
>=20


--=20
Chen Gang
