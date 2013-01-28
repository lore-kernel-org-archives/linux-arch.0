From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [uclinux-dist-devel] [PATCH v2 2/9] blackfin: Provide
 dma_mmap_coherent() and dma_get_sgtable()
Date: Mon, 28 Jan 2013 17:08:37 +0800
Message-ID: <CAA_GA1dN1PGqaKVG5OkNAAd_Og3NqQQJT2TtdJTmdQwZ0zmSRQ@mail.gmail.com>
References: <1359282808-31398-1-git-send-email-geert@linux-m68k.org>
	<1359282808-31398-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:53512 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab3A1JIi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jan 2013 04:08:38 -0500
In-Reply-To: <1359282808-31398-3-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>

On Sun, Jan 27, 2013 at 6:33 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> blackfin/allmodconfig:
>
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_mmap=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit d=
eclaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_get_base_sgt=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit d=
eclaration of function =E2=80=98dma_get_sgtable=E2=80=99
>
> For architectures using dma_map_ops, dma_mmap_coherent() and
> dma_get_sgtable() are provided in <asm-generic/dma-mapping-common.h>.
>
> Blackfin does not use dma_map_ops, hence it should implement them as =
inline
> stubs using dma_common_mmap() and dma_common_get_sgtable().
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Acked-by: Scott Jiang <scott.jiang.linux@gmail.com>

Thanks,
Will be applied to my blackfin arch tree.

> ---
> v2: No changes
> ---
>  arch/blackfin/include/asm/dma-mapping.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/blackfin/include/asm/dma-mapping.h b/arch/blackfin/=
include/asm/dma-mapping.h
> index bbf4610..054d9ec 100644
> --- a/arch/blackfin/include/asm/dma-mapping.h
> +++ b/arch/blackfin/include/asm/dma-mapping.h
> @@ -154,4 +154,14 @@ dma_cache_sync(struct device *dev, void *vaddr, =
size_t size,
>         _dma_sync((dma_addr_t)vaddr, size, dir);
>  }
>
> +/* drivers/base/dma-mapping.c */
> +extern int dma_common_mmap(struct device *dev, struct vm_area_struct=
 *vma,
> +                          void *cpu_addr, dma_addr_t dma_addr, size_=
t size);
> +extern int dma_common_get_sgtable(struct device *dev, struct sg_tabl=
e *sgt,
> +                                 void *cpu_addr, dma_addr_t dma_addr=
,
> +                                 size_t size);
> +
> +#define dma_mmap_coherent(d, v, c, h, s) dma_common_mmap(d, v, c, h,=
 s)
> +#define dma_get_sgtable(d, t, v, h, s) dma_common_get_sgtable(d, t, =
v, h, s)
> +
>  #endif                         /* _BLACKFIN_DMA_MAPPING_H */
> --
> 1.7.0.4
>

--=20
Regards,
--Bob
