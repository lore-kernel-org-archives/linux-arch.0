From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 4/4] common: dma-mapping: Move dma_common_*() to <linux/dma-mapping.h>
Date: Sun, 13 Jan 2013 11:40:12 +0100
Message-ID: <CAMuHMdVequkKT96i+7mhZnvogZrMPQDkd3d4EQxwZcvj5gSbWw@mail.gmail.com>
References: <CAMuHMdVPBUzN8fsNHFzrEqev9BsvVCVR2fWySCOecjVA-J1qjg@mail.gmail.com>
	<1356722614-18224-5-git-send-email-geert@linux-m68k.org>
	<50E442A7.3010002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <50E442A7.3010002@samsung.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Marek,

On Wed, Jan 2, 2013 at 3:22 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 12/28/2012 8:23 PM, Geert Uytterhoeven wrote:
>> dma_common_mmap() and dma_common_get_sgtable() are defined in
>> drivers/base/dma-mapping.c, and always compiled if CONFIG_HAS_DMA=3D=
y.
>>
>> However, their forward declarations and the inline functions defined=
 on
>> top
>> of them (dma_mmap_attrs(), dma_mmap_coherent(), dma_mmap_writecombin=
e(),
>> dma_get_sgtable_attrs()), dma_get_sgtable()) are in
>> <asm-generic/dma-mapping-common.h>, which is not included by all
>> architectures supporting CONFIG_HAS_DMA=3Dy.  There exist no alterna=
tive
>> implementations.
>>
>> Hence for e.g. m68k allmodconfig, I get:
>>
>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_mmap=E2=80=99:
>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit
>> declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function
>> =E2=80=98vb2_dc_get_base_sgt=E2=80=99:
>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit
>> declaration of function =E2=80=98dma_get_sgtable=E2=80=99
>>
>> To fix this
>>    - Move the forward declarations and inline definitions to
>>      <linux/dma-mapping.h>, so all CONFIG_HAS_DMA=3Dy architectures =
can use
>>      them,
>>    - Replace the hard "BUG_ON(!ops)" checks for dma_map_ops by soft
>> checks,
>>      so architectures can fall back to the common code by returning =
NULL
>>      from their get_dma_ops(). Note that there are no "BUG_ON(!ops)"
>> checks
>>      in other functions in <asm-generic/dma-mapping-common.h>,
>>    - Make "struct dma_map_ops *ops" const while we're at it.
>
>
> I think that more appropriate way of handling it is to avoid dma_map_=
ops
> based
> calls (those archs probably have some reasons why they don't use it a=
t all)
> and
> provide static inline stubs which call dma_common_mmap and
> dma_common_get_sgtable.

OK, I'll do that.

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
