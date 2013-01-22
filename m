From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent()
 and dma_get_sgtable()
Date: Tue, 22 Jan 2013 10:22:44 +0000
Message-ID: <1358850164.2387.16.camel@dabdike.int.hansenpartnership.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
	 <1358073890-3610-3-git-send-email-geert@linux-m68k.org>
	 <1358177872.4357.53.camel@t520.localdomain> <50F4D83A.7020803@synopsys.com>
	 <CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
	 <50F56286.8070200@samsung.com>
	 <1358269008.10591.11.camel@dabdike.int.hansenpartnership.com>
	 <50FE66C6.4040900@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51302 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750723Ab3AVKWs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Jan 2013 05:22:48 -0500
In-Reply-To: <50FE66C6.4040900@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org

On Tue, 2013-01-22 at 11:15 +0100, Marek Szyprowski wrote:
> Hello,
>=20
> On 1/15/2013 5:56 PM, James Bottomley wrote:
> > On Tue, 2013-01-15 at 15:07 +0100, Marek Szyprowski wrote:
> > > Hello,
> > >
> > > On 1/15/2013 10:13 AM, Geert Uytterhoeven wrote:
> > > > Marek?
> > > >
> > > > On Tue, Jan 15, 2013 at 5:16 AM, Vineet Gupta
> > > > <Vineet.Gupta1@synopsys.com> wrote:
> > > > > On Monday 14 January 2013 09:07 PM, Mark Salter wrote:
> > > > >> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
> > > > >>> c6x/allmodconfig (assumed):
> > > > >>>
> > > > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function=
 =E2=80=98vb2_dc_mmap=E2=80=99:
> > > > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: =
implicit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> > > > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function=
 =E2=80=98vb2_dc_get_base_sgt=E2=80=99:
> > > > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: =
implicit declaration of function =E2=80=98dma_get_sgtable=E2=80=99
> > > > >>>
> > > > >>> For architectures using dma_map_ops, dma_mmap_coherent() an=
d
> > > > >>> dma_get_sgtable() are provided in <asm-generic/dma-mapping-=
common.h>.
> > > > >>>
> > > > >>> C6x does not use dma_map_ops, hence it should implement the=
m as inline
> > > > >>> stubs using dma_common_mmap() and dma_common_get_sgtable().
> > > > >>>
> > > > >> So are dma_mmap_coherent() and dma_get_sgtable() part of the=
 DMA API
> > > > >> now? I don't them in Documentation/DMA*.txt anywhere.
> > > > >>
> > > > >> Why does the default dma_common_mmap() for !CONFIG_MMU retur=
n an
> > > > >> error?
> > > > >>
> > > > >> Wouldn't it be better to provide default implementations tha=
t an arch
> > > > >> could override rather than having to patch all "no dma_map_o=
ps"
> > > > >> architectures?
> > > > >>
> > > > > Speaking for the still-reviewed ARC Port, I completely agree =
with Mark.
> > >
> > > dma_mmap_coherent() was partially in the DMA mapping API for some=
 time, but
> > > it was available only on a few architectures (afair ARM, powerpc =
and avr32).
> > > This caused significant problems for writing unified device drive=
rs or some
> > > device helper modules which were aimed to work on more than one
> > > architecture.
> > >
> > > dma_get_sgtable() is an extension discussed during the Linaro mee=
tings. It
> > > is required to correctly implement buffer sharing between device =
driver
> > > without hacks or any assumptions about memory layout in the devic=
e drivers.
> > >
> > > I have implemented some generic code for both of those two functi=
ons,
> > > keeping
> > > in mind that on some hardware architectures (like already mention=
ed VIVT)
> > > it might be not possible to provide coherent mapping to userspace=
=2E It is
> > > perfectly fine for those functions to return an error in such cas=
e.
> >
> > It's not possible on VIPT either.  This means that the API is unusa=
ble
> > on quite a large number of architectures.  Surely, if we're startin=
g to
> > write drivers using this, we need to fix the API before more people=
 try
> > to use it.
>=20
> I don't get this one. On ARM coherent mappings are implemented as=20
> non-cacheable,
> both in userspace and kernel-space, so having a coherent mapping is=20
> possible on
> VIPT architecture.

Only if you have an uncacheable bit in the architecture page table ...
which some of ours don't.

Regardless, setting pages Uncacheable is really a hack job on shared
buffers because it creates a huge slow down .... like an order of
magnitude more than simply copying the page, which I believe is the
current solution.

> There are common, already defined and widely used user interfaces (li=
ke=20
> mentioned
> fbdev, v4l2, alsa) which rely on mmaping coherent buffers to userspac=
e.=20
> There are
> drivers which use coherent buffers for those interfaces. It is alread=
y=20
> an issue
> to implement mmap call for those drivers as it requires some architec=
ture
> specific assumptions. We wanted to remove those assumptions from the=20
> drivers and
> move them to some common dma-mapping calls.
>=20
> I agree that this might not be directly possible on non-mmu systems,=20
> where mmap
> syscall is handled differently. Some architectures might also have so=
me=20
> hardware
> limitations, which prevents implementing such interface. That's ok, a=
s=20
> probably
> there is no drivers which will use this interface on this architectur=
e.
>=20
> > For PA-RISC (and all other VIPT, I assume) I need an API which allo=
ws me
> > to remap the virtual address of the kernel component (probably usin=
g the
> > kmap area) so the user space and kernel space addresses are congrue=
nt.
>=20
> How such API would look like? What syscall might be used for it?

See next email.

James
