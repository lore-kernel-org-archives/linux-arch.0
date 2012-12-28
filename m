From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 0/4] Re: dma_mmap_coherent / ARCH_HAS_DMA_MMAP_COHERENT
Date: Fri, 28 Dec 2012 20:23:30 +0100
Message-ID: <1356722614-18224-1-git-send-email-geert@linux-m68k.org>
References: <CAMuHMdVPBUzN8fsNHFzrEqev9BsvVCVR2fWySCOecjVA-J1qjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVPBUzN8fsNHFzrEqev9BsvVCVR2fWySCOecjVA-J1qjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc: linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Dec 16, 2012 at 5:03 PM, Geert Uytterhoeven <geert@linux-m68k.o=
rg>
wrote:
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_mmap=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit d=
eclaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_get_base_sgt=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit d=
eclaration of function =E2=80=98dma_get_sgtable=E2=80=99
> make[6]: *** [drivers/media/v4l2-core/videobuf2-dma-contig.o] Error 1
> make[6]: Target `__build' not remade because of errors.
> make[5]: *** [drivers/media/v4l2-core] Error 2
>
> Both dma_mmap_coherent() and dma_get_sgtable() are defined in
> include/asm-generic/dma-mapping-common.h only, which is included by
> <asm/dma-mapping.h> on alpha, arm, arm64, hexagon, ia64, microblaze, =
mips,
> openrisc, powerpc, s390, sh, sparc, tile, unicore32, x86.
> Should the remaining architectures include this, too?
> Should it be moved to <linux/dma-mapping.h>?

I came up with an RFC-solution for this in [PATCH/RFC 3/4]
("avr32/bfin/c6x/cris/frv/m68k/mn10300/parisc/xtensa: Add dummy get_dma=
_ops()")
and [PATCH/RFC 4/4] ("common: dma-mapping: Move dma_common_*() to
<linux/dma-mapping.h>") of this series.

> Furthermore, there's ARCH_HAS_DMA_MMAP_COHERENT, which is defined
> by powerpc only:
> arch/powerpc/include/asm/dma-mapping.h:#define ARCH_HAS_DMA_MMAP_COHE=
RENT
>
> and handled in some fishy way in sound/core/pcm_native.c:
>
> #ifndef ARCH_HAS_DMA_MMAP_COHERENT
> /* This should be defined / handled globally! */
> #ifdef CONFIG_ARM
> #define ARCH_HAS_DMA_MMAP_COHERENT
> #endif
> #endif
>
> /*
>  * mmap the DMA buffer on RAM
>  */
> int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
>                              struct vm_area_struct *area)
> {
>         area->vm_flags |=3D VM_DONTEXPAND | VM_DONTDUMP;
> #ifdef ARCH_HAS_DMA_MMAP_COHERENT
>         if (!substream->ops->page &&
>             substream->dma_buffer.dev.type =3D=3D SNDRV_DMA_TYPE_DEV)
>                 return dma_mmap_coherent(substream->dma_buffer.dev.de=
v,
>                                          area,
>                                          substream->runtime->dma_area=
,
>                                          substream->runtime->dma_addr=
,
>                                          area->vm_end - area->vm_star=
t);
> #elif defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
>         if (substream->dma_buffer.dev.type =3D=3D SNDRV_DMA_TYPE_DEV =
&&
>             !plat_device_is_coherent(substream->dma_buffer.dev.dev))
>                 area->vm_page_prot =3D pgprot_noncached(area->vm_page=
_prot);
> #endif /* ARCH_HAS_DMA_MMAP_COHERENT */
>         /* mmap with fault handler */
>         area->vm_ops =3D &snd_pcm_vm_ops_data_fault;
>         return 0;
> }
> EXPORT_SYMBOL_GPL(snd_pcm_lib_default_mmap);
>
> What's up here?

Probably an easy solution here is to kill ARCH_HAS_DMA_MMAP_COHERENT an=
d
change the code to

    #if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
	    if (substream->dma_buffer.dev.type =3D=3D SNDRV_DMA_TYPE_DEV &&
		!plat_device_is_coherent(substream->dma_buffer.dev.dev))
		    area->vm_page_prot =3D pgprot_noncached(area->vm_page_prot);
    #else
	    if (!substream->ops->page &&
		substream->dma_buffer.dev.type =3D=3D SNDRV_DMA_TYPE_DEV)
		    return dma_mmap_coherent(substream->dma_buffer.dev.dev,
					     area,
					     substream->runtime->dma_area,
					     substream->runtime->dma_addr,
					     area->vm_end - area->vm_start);
    #endif

but obviously I don't like the test for CONFIG_MIPS in generic code...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
