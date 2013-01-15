From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent() and
 dma_get_sgtable()
Date: Tue, 15 Jan 2013 15:07:02 +0100
Message-ID: <50F56286.8070200@samsung.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
 <1358073890-3610-3-git-send-email-geert@linux-m68k.org>
 <1358177872.4357.53.camel@t520.localdomain> <50F4D83A.7020803@synopsys.com>
 <CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:11922 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab3AOOHJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2013 09:07:09 -0500
In-reply-to: <CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Salter <msalter@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org

Hello,

On 1/15/2013 10:13 AM, Geert Uytterhoeven wrote:
> Marek?
>
> On Tue, Jan 15, 2013 at 5:16 AM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
> > On Monday 14 January 2013 09:07 PM, Mark Salter wrote:
> >> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
> >>> c6x/allmodconfig (assumed):
> >>>
> >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=
=98vb2_dc_mmap=E2=80=99:
> >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implic=
it declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=
=98vb2_dc_get_base_sgt=E2=80=99:
> >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implic=
it declaration of function =E2=80=98dma_get_sgtable=E2=80=99
> >>>
> >>> For architectures using dma_map_ops, dma_mmap_coherent() and
> >>> dma_get_sgtable() are provided in <asm-generic/dma-mapping-common=
=2Eh>.
> >>>
> >>> C6x does not use dma_map_ops, hence it should implement them as i=
nline
> >>> stubs using dma_common_mmap() and dma_common_get_sgtable().
> >>>
> >> So are dma_mmap_coherent() and dma_get_sgtable() part of the DMA A=
PI
> >> now? I don't them in Documentation/DMA*.txt anywhere.
> >>
> >> Why does the default dma_common_mmap() for !CONFIG_MMU return an
> >> error?
> >>
> >> Wouldn't it be better to provide default implementations that an a=
rch
> >> could override rather than having to patch all "no dma_map_ops"
> >> architectures?
> >>
> > Speaking for the still-reviewed ARC Port, I completely agree with M=
ark.

dma_mmap_coherent() was partially in the DMA mapping API for some time,=
 but
it was available only on a few architectures (afair ARM, powerpc and av=
r32).
This caused significant problems for writing unified device drivers or =
some
device helper modules which were aimed to work on more than one=20
architecture.

dma_get_sgtable() is an extension discussed during the Linaro meetings.=
 It
is required to correctly implement buffer sharing between device driver
without hacks or any assumptions about memory layout in the device driv=
ers.

I have implemented some generic code for both of those two functions,=20
keeping
in mind that on some hardware architectures (like already mentioned VIV=
T)
it might be not possible to provide coherent mapping to userspace. It i=
s
perfectly fine for those functions to return an error in such case.

My common implementation returns error for NOMMU systems because I was
convinced that remapping the pages to userspace is simply not possible
without the MMU.

I'm really sorry for skipping the non dma_map_ops based architectures, =
I had
a plan to cover them in one of the next updates, but in meantime the v4=
l2
updates requiring those interfaces has been merged and I got very busy =
with
other stuff, then Geert was faster fixing it.

I'm also working on updated DMA mapping documentation to cover those ne=
w
functions as well as some new DMA attributes introduced recently, I hop=
e to
post them soon.

Best regards
--=20
Marek Szyprowski
Samsung Poland R&D Center
