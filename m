From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent()
 and dma_get_sgtable()
Date: Tue, 22 Jan 2013 11:23:38 -0200
Message-ID: <20130122112338.1c34adf7@redhat.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
	<1358073890-3610-3-git-send-email-geert@linux-m68k.org>
	<1358177872.4357.53.camel@t520.localdomain>
	<50F4D83A.7020803@synopsys.com>
	<CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
	<50F56286.8070200@samsung.com>
	<1358269008.10591.11.camel@dabdike.int.hansenpartnership.com>
	<CAMuHMdXk1mdkMViYqypvnXO0_1LdjbH8S7z8FNe97yDUW6BYRA@mail.gmail.com>
	<1358809159.3975.63.camel@dabdike.int.hansenpartnership.com>
	<1358849633.2387.11.camel@dabdike.int.hansenpartnership.com>
	<1358849808.2387.13.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab3AVNY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2013 08:24:29 -0500
In-Reply-To: <1358849808.2387.13.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mark Salter <msalter@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Pawel Osciak <pawel@osciak.com>

Hi James,

Em Tue, 22 Jan 2013 10:16:48 +0000
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> [adding Mauro and v4l since they're the only non-arm consumers]
> On Tue, 2013-01-22 at 10:13 +0000, James Bottomley wrote:
> > On Mon, 2013-01-21 at 22:59 +0000, James Bottomley wrote:
> > > On Mon, 2013-01-21 at 21:00 +0100, Geert Uytterhoeven wrote:
> > > > On Tue, Jan 15, 2013 at 5:56 PM, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > On Tue, 2013-01-15 at 15:07 +0100, Marek Szyprowski wrote:
> > > > >> On 1/15/2013 10:13 AM, Geert Uytterhoeven wrote:
> > > > >> > Marek?
> > > > >> >
> > > > >> > On Tue, Jan 15, 2013 at 5:16 AM, Vineet Gupta
> > > > >> > <Vineet.Gupta1@synopsys.com> wrote:
> > > > >> > > On Monday 14 January 2013 09:07 PM, Mark Salter wrote:
> > > > >> > >> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven w=
rote:
> > > > >> > >>> c6x/allmodconfig (assumed):
> > > > >> > >>>
> > > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In fun=
ction =E2=80=98vb2_dc_mmap=E2=80=99:
> > > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: er=
ror: implicit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> > > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In fun=
ction =E2=80=98vb2_dc_get_base_sgt=E2=80=99:
> > > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: er=
ror: implicit declaration of function =E2=80=98dma_get_sgtable=E2=80=99
> > > > >> > >>>
> > > > >> > >>> For architectures using dma_map_ops, dma_mmap_coherent=
() and
> > > > >> > >>> dma_get_sgtable() are provided in <asm-generic/dma-map=
ping-common.h>.
> > > > >> > >>>
> > > > >> > >>> C6x does not use dma_map_ops, hence it should implemen=
t them as inline
> > > > >> > >>> stubs using dma_common_mmap() and dma_common_get_sgtab=
le().
> > > > >> > >>>
> > > > >> > >> So are dma_mmap_coherent() and dma_get_sgtable() part o=
f the DMA API
> > > > >> > >> now? I don't them in Documentation/DMA*.txt anywhere.
> > > > >> > >>
> > > > >> > >> Why does the default dma_common_mmap() for !CONFIG_MMU =
return an
> > > > >> > >> error?
> > > > >> > >>
> > > > >> > >> Wouldn't it be better to provide default implementation=
s that an arch
> > > > >> > >> could override rather than having to patch all "no dma_=
map_ops"
> > > > >> > >> architectures?
> > > > >> > >>
> > > > >> > > Speaking for the still-reviewed ARC Port, I completely a=
gree with Mark.
> > > > >>
> > > > >> dma_mmap_coherent() was partially in the DMA mapping API for=
 some time, but
> > > > >> it was available only on a few architectures (afair ARM, pow=
erpc and avr32).
> > > > >> This caused significant problems for writing unified device =
drivers or some
> > > > >> device helper modules which were aimed to work on more than =
one
> > > > >> architecture.
> > > > >>
> > > > >> dma_get_sgtable() is an extension discussed during the Linar=
o meetings. It
> > > > >> is required to correctly implement buffer sharing between de=
vice driver
> > > > >> without hacks or any assumptions about memory layout in the =
device drivers.
> > > > >>
> > > > >> I have implemented some generic code for both of those two f=
unctions,
> > > > >> keeping
> > > > >> in mind that on some hardware architectures (like already me=
ntioned VIVT)
> > > > >> it might be not possible to provide coherent mapping to user=
space. It is
> > > > >> perfectly fine for those functions to return an error in suc=
h case.
> > > > >
> > > > > It's not possible on VIPT either.  This means that the API is=
 unusable
> > > > > on quite a large number of architectures.  Surely, if we're s=
tarting to
> > > > > write drivers using this, we need to fix the API before more =
people try
> > > > > to use it.
> > > > >
> > > > > For PA-RISC (and all other VIPT, I assume) I need an API whic=
h allows me
> > > > > to remap the virtual address of the kernel component (probabl=
y using the
> > > > > kmap area) so the user space and kernel space addresses are c=
ongruent.
> > > >=20
> > > > So what are we gonna do for 3.8? I'd like to get my allmodconfi=
g build
> > > > green again ;-)
> > > >=20
> > > > Change the API?
> > >=20
> > > Well, if we want the API to work universally, we have to.  As I s=
aid,
> > > for VIPT systems, the only coherency mechanism we have is the vir=
tual
> > > address ... we have to fix that in the kernel to be congruent wit=
h the
> > > userspace virtual address if we want coherency between the kernel=
 and
> > > userspace.
> > >=20
> > > However, if it only needs to work on ARM and x86, it can stay the=
 way it
> > > is and we could just pull it out of the generic core.
> > >=20
> > > Who actually wants to use this API, and what for?
> > >=20
> > > > Keep the API but do a best-effort fix to unbreak the builds?
> > > >   - Apply my patches that got acks (avr32/blackfin/cris/m68k),
> > > >   - Use static inlines that return -EINVAL for the rest
> > > > (c6x/frv/mn10300/parisc/xtensa).
> > > > I still have a few m68k fixes queued for 3.8, for which I've be=
en postponing the
> > > > pull request to get this sorted out, so I could include the abo=
ve.
> > > >=20
> > > > Any other solution?
> > >=20
> > > If it's an API that only works on ARM and x86, there's not much p=
oint
> > > pretending it's universal, so we should remove it from the generi=
c arch
> > > code and allow only those architectures which can use it.
> >=20
> > There might be a simple solution:  just replace void *cpu_addr with=
 void
> > **cpu_addr in the API.  This is a bit nasty since compilers think t=
hat
> > void ** to void * conversion is quite legal, so it would be hard to=
 pick
> > up misuse of this (uint8_t ** would be better).  That way VIPT coul=
d
> > remap the kernel pages to a coherent address.  This would probably =
have
> > to change in the dma_mmap_attr() and dma_ops structures.
> >=20
> > All consumers would have to expect cpu_addr might change, but that =
seems
> > doable.
>=20
> Mauro, will this work for you and the v4l guys?  You've got a use
> embedded in=20
>=20
> drivers/media/v4l2-core/videobuf2-dma-contig.c
>=20
> Which I can't tell how extensive it might be.

Proper handling of video stream is a hard task and can be very tricky.
In order to avoid duplicated stuff, the video streaming buffer handling=
,
implemented by videobuf2 (aka VB2), is part of the media core,=20
and it was written to be as much architecture-independent as possible.
There is a previous implementation of it, and we're gradually changing
the drivers to VB2, as it is more robust and fixes some known issues
with the legacy one.

The VB2 core has one generic driver, completely independent on the memo=
ry
model, with provides the interface for the V4L drivers, and 3 memory-sp=
ecific
ones that match the DMA needs for that architecture and device:

	- one for vmalloc'ed memory - used by USB based devices where double
buffering is needed in order to strip USB protocol packets from the vid=
eo
payload;
	- one for DMA scatter/gather - most PCI/PCIe devices use DMA
scatter/gather;

	- one for DMA where a continuous memory is required to fit an entire
video image (videobuf2-dma-contig). This is generally required by the=20
embedded drivers, as either the video capture IP block and/or the DMA
engine can't handle scatter/gather pages.

So, while the current drivers that use videobuf2-dma-contig are (mainly=
)
for x86 and arm, the better is for videobuf2-dma-contig to be able of
working with all possible architectures, as I'm sure that sooner or lat=
er
a video device will be needed at the other architectures, and this driv=
er
will be needed there.

That's said, changing from *cpu_addr to **cpu_addr sounds ok on my
eyes, but Pawel and Marek knows a lot more about videobuf2 than me,
as they wrote this driver. So, they can contribute more with the
interface specifics.

=46rom my side, I don't care that much with the needed API changes
for the DMA interfaces to be generic, provided that the v4l2 core
compilation won't depend on any CONFIG_ARCH* Kconfig symbol, and
that all architectures implement the DMA API interfaces at the same
way, so, there will be no need to add #if's inside the videobuf2 code[1=
].

Regards,
Mauro

[1] Unfortunately, there's currently one such #if's there, in order to
support (sub)architectures where there's no MMU.
