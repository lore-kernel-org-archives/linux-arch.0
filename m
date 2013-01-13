From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 8/9] parisc: Provide dma_mmap_coherent() and
 dma_get_sgtable()
Date: Sun, 13 Jan 2013 11:36:41 +0000
Message-ID: <1358077001.3065.14.camel@dabdike.int.hansenpartnership.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
	 <1358073890-3610-8-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46008 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754617Ab3AMLgp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Jan 2013 06:36:45 -0500
In-Reply-To: <1358073890-3610-8-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-parisc@vger.kernel.org

On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
> parisc/allmodconfig:
>=20
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_mmap=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit d=
eclaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_get_base_sgt=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit d=
eclaration of function =E2=80=98dma_get_sgtable=E2=80=99
>=20
> For architectures using dma_map_ops, dma_mmap_coherent() and
> dma_get_sgtable() are provided in <asm-generic/dma-mapping-common.h>.
>=20
> Parisc does not use dma_map_ops, hence it should implement them as in=
line
> stubs using dma_common_mmap() and dma_common_get_sgtable().
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: linux-parisc@vger.kernel.org
> ---
>  arch/parisc/include/asm/dma-mapping.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/incl=
ude/asm/dma-mapping.h
> index 467bbd5..1fac0bf 100644
> --- a/arch/parisc/include/asm/dma-mapping.h
> +++ b/arch/parisc/include/asm/dma-mapping.h
> @@ -238,4 +238,14 @@ void * sba_get_iommu(struct parisc_device *dev);
>  /* At the moment, we panic on error for IOMMU resource exaustion */
>  #define dma_mapping_error(dev, x)	0
> =20
> +/* drivers/base/dma-mapping.c */
> +extern int dma_common_mmap(struct device *dev, struct vm_area_struct=
 *vma,
> +			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
> +extern int dma_common_get_sgtable(struct device *dev, struct sg_tabl=
e *sgt,
> +				  void *cpu_addr, dma_addr_t dma_addr,
> +				  size_t size);
> +
> +#define dma_mmap_coherent(d, v, c, h, s) dma_common_mmap(d, v, c, h,=
 s)
> +#define dma_get_sgtable(d, t, v, h, s) dma_common_get_sgtable(d, t, =
v, h, s)

What is the documentation around these functions?  The name sounds
suspiciously like you want a mapping of a buffer coherent between kerne=
l
and user space, which doesn't seem possible for us given the API.  We'r=
e
a VIPT architecture, so the only way we can do this is to have the
actual vma user space address be congruent with cpu_addr.  How do we do
that if the vma and kernel addresses are already fixed?

In other words, either the interface is unusable by parisc, or the
common code definitely won't work for us.

James
