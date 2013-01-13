From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 8/9] parisc: Provide dma_mmap_coherent() and dma_get_sgtable()
Date: Sun, 13 Jan 2013 14:12:24 +0100
Message-ID: <CAMuHMdVvRmNZS_L8-kYm4VGexD3h=nW4wC266cu7VAxJFx+-oA@mail.gmail.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
	<1358073890-3610-8-git-send-email-geert@linux-m68k.org>
	<1358077001.3065.14.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:60131 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab3AMNM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jan 2013 08:12:26 -0500
In-Reply-To: <1358077001.3065.14.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-parisc@vger.kernel.org

On Sun, Jan 13, 2013 at 12:36 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
>> parisc/allmodconfig:
>>
>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_mmap=E2=80=99:
>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit =
declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_get_base_sgt=E2=80=99:
>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit =
declaration of function =E2=80=98dma_get_sgtable=E2=80=99
>>
>> For architectures using dma_map_ops, dma_mmap_coherent() and
>> dma_get_sgtable() are provided in <asm-generic/dma-mapping-common.h>=
=2E
>>
>> Parisc does not use dma_map_ops, hence it should implement them as i=
nline
>> stubs using dma_common_mmap() and dma_common_get_sgtable().
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: linux-parisc@vger.kernel.org
>> ---
>>  arch/parisc/include/asm/dma-mapping.h |   10 ++++++++++
>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/inc=
lude/asm/dma-mapping.h
>> index 467bbd5..1fac0bf 100644
>> --- a/arch/parisc/include/asm/dma-mapping.h
>> +++ b/arch/parisc/include/asm/dma-mapping.h
>> @@ -238,4 +238,14 @@ void * sba_get_iommu(struct parisc_device *dev)=
;
>>  /* At the moment, we panic on error for IOMMU resource exaustion */
>>  #define dma_mapping_error(dev, x)    0
>>
>> +/* drivers/base/dma-mapping.c */
>> +extern int dma_common_mmap(struct device *dev, struct vm_area_struc=
t *vma,
>> +                        void *cpu_addr, dma_addr_t dma_addr, size_t=
 size);
>> +extern int dma_common_get_sgtable(struct device *dev, struct sg_tab=
le *sgt,
>> +                               void *cpu_addr, dma_addr_t dma_addr,
>> +                               size_t size);
>> +
>> +#define dma_mmap_coherent(d, v, c, h, s) dma_common_mmap(d, v, c, h=
, s)
>> +#define dma_get_sgtable(d, t, v, h, s) dma_common_get_sgtable(d, t,=
 v, h, s)
>
> What is the documentation around these functions?  The name sounds
> suspiciously like you want a mapping of a buffer coherent between ker=
nel
> and user space, which doesn't seem possible for us given the API.  We=
're
> a VIPT architecture, so the only way we can do this is to have the
> actual vma user space address be congruent with cpu_addr.  How do we =
do
> that if the vma and kernel addresses are already fixed?

I was already afraid of this when seeing the "coherent" in the naming..=
=2E

> In other words, either the interface is unusable by parisc, or the
> common code definitely won't work for us.

So you probably want a static inline function that returns -EINVAL for =
now?

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
