From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent() and
 dma_get_sgtable()
Date: Thu, 24 Jan 2013 11:49:52 +0100
Message-ID: <510111D0.4000501@samsung.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
 <1358073890-3610-3-git-send-email-geert@linux-m68k.org>
 <1358177872.4357.53.camel@t520.localdomain> <50F4D83A.7020803@synopsys.com>
 <CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
 <50F56286.8070200@samsung.com>
 <1358269008.10591.11.camel@dabdike.int.hansenpartnership.com>
 <CAMuHMdXk1mdkMViYqypvnXO0_1LdjbH8S7z8FNe97yDUW6BYRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:55019 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab3AXKt4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jan 2013 05:49:56 -0500
In-reply-to: <CAMuHMdXk1mdkMViYqypvnXO0_1LdjbH8S7z8FNe97yDUW6BYRA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mark Salter <msalter@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org


On 1/21/2013 9:00 PM, Geert Uytterhoeven wrote:
> On Tue, Jan 15, 2013 at 5:56 PM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Tue, 2013-01-15 at 15:07 +0100, Marek Szyprowski wrote:
> >> On 1/15/2013 10:13 AM, Geert Uytterhoeven wrote:
> >> > Marek?
> >> >
> >> > On Tue, Jan 15, 2013 at 5:16 AM, Vineet Gupta
> >> > <Vineet.Gupta1@synopsys.com> wrote:
> >> > > On Monday 14 January 2013 09:07 PM, Mark Salter wrote:
> >> > >> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
> >> > >>> c6x/allmodconfig (assumed):
> >> > >>>
> >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =
=E2=80=98vb2_dc_mmap=E2=80=99:
> >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: i=
mplicit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =
=E2=80=98vb2_dc_get_base_sgt=E2=80=99:
> >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: i=
mplicit declaration of function =E2=80=98dma_get_sgtable=E2=80=99
> >> > >>>
> >> > >>> For architectures using dma_map_ops, dma_mmap_coherent() and
> >> > >>> dma_get_sgtable() are provided in <asm-generic/dma-mapping-c=
ommon.h>.
> >> > >>>
> >> > >>> C6x does not use dma_map_ops, hence it should implement them=
 as inline
> >> > >>> stubs using dma_common_mmap() and dma_common_get_sgtable().
> >> > >>>
> >> > >> So are dma_mmap_coherent() and dma_get_sgtable() part of the =
DMA API
> >> > >> now? I don't them in Documentation/DMA*.txt anywhere.
> >> > >>
> >> > >> Why does the default dma_common_mmap() for !CONFIG_MMU return=
 an
> >> > >> error?
> >> > >>
> >> > >> Wouldn't it be better to provide default implementations that=
 an arch
> >> > >> could override rather than having to patch all "no dma_map_op=
s"
> >> > >> architectures?
> >> > >>
> >> > > Speaking for the still-reviewed ARC Port, I completely agree w=
ith Mark.
> >>
> >> dma_mmap_coherent() was partially in the DMA mapping API for some =
time, but
> >> it was available only on a few architectures (afair ARM, powerpc a=
nd avr32).
> >> This caused significant problems for writing unified device driver=
s or some
> >> device helper modules which were aimed to work on more than one
> >> architecture.
> >>
> >> dma_get_sgtable() is an extension discussed during the Linaro meet=
ings. It
> >> is required to correctly implement buffer sharing between device d=
river
> >> without hacks or any assumptions about memory layout in the device=
 drivers.
> >>
> >> I have implemented some generic code for both of those two functio=
ns,
> >> keeping
> >> in mind that on some hardware architectures (like already mentione=
d VIVT)
> >> it might be not possible to provide coherent mapping to userspace.=
 It is
> >> perfectly fine for those functions to return an error in such case=
=2E
> >
> > It's not possible on VIPT either.  This means that the API is unusa=
ble
> > on quite a large number of architectures.  Surely, if we're startin=
g to
> > write drivers using this, we need to fix the API before more people=
 try
> > to use it.
> >
> > For PA-RISC (and all other VIPT, I assume) I need an API which allo=
ws me
> > to remap the virtual address of the kernel component (probably usin=
g the
> > kmap area) so the user space and kernel space addresses are congrue=
nt.
>
> So what are we gonna do for 3.8? I'd like to get my allmodconfig buil=
d
> green again ;-)
>
> Change the API?
>
> Keep the API but do a best-effort fix to unbreak the builds?
>    - Apply my patches that got acks (avr32/blackfin/cris/m68k),
>    - Use static inlines that return -EINVAL for the rest
> (c6x/frv/mn10300/parisc/xtensa).
> I still have a few m68k fixes queued for 3.8, for which I've been pos=
tponing the
> pull request to get this sorted out, so I could include the above.

I think this would be the best solution for fixing v3.8. I would like t=
o put
those patches in linux-next asap and then after a week or so send a pul=
l
request for merging them to v3.8-rc6.

EINVAL approach can be later fixed/extended with real implementation (i=
f
there are any driver candidates, which will use such interface).

Best regards
--=20
Marek Szyprowski
Samsung Poland R&D Center
