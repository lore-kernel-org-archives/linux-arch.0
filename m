From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent() and
 dma_get_sgtable()
Date: Wed, 23 Jan 2013 10:47:10 +0100
Message-ID: <50FFB19E.3020901@samsung.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
 <1358073890-3610-3-git-send-email-geert@linux-m68k.org>
 <1358177872.4357.53.camel@t520.localdomain> <50F4D83A.7020803@synopsys.com>
 <CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
 <50F56286.8070200@samsung.com>
 <1358269008.10591.11.camel@dabdike.int.hansenpartnership.com>
 <CAMuHMdXk1mdkMViYqypvnXO0_1LdjbH8S7z8FNe97yDUW6BYRA@mail.gmail.com>
 <1358809159.3975.63.camel@dabdike.int.hansenpartnership.com>
 <1358849633.2387.11.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1358849633.2387.11.camel@dabdike.int.hansenpartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


On 1/22/2013 11:13 AM, James Bottomley wrote:
> On Mon, 2013-01-21 at 22:59 +0000, James Bottomley wrote:
> > On Mon, 2013-01-21 at 21:00 +0100, Geert Uytterhoeven wrote:
> > > On Tue, Jan 15, 2013 at 5:56 PM, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > On Tue, 2013-01-15 at 15:07 +0100, Marek Szyprowski wrote:
> > > >> On 1/15/2013 10:13 AM, Geert Uytterhoeven wrote:
> > > >> > Marek?
> > > >> >
> > > >> > On Tue, Jan 15, 2013 at 5:16 AM, Vineet Gupta
> > > >> > <Vineet.Gupta1@synopsys.com> wrote:
> > > >> > > On Monday 14 January 2013 09:07 PM, Mark Salter wrote:
> > > >> > >> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wro=
te:
> > > >> > >>> c6x/allmodconfig (assumed):
> > > >> > >>>
> > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In funct=
ion =E2=80=98vb2_dc_mmap=E2=80=99:
> > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: erro=
r: implicit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In funct=
ion =E2=80=98vb2_dc_get_base_sgt=E2=80=99:
> > > >> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: erro=
r: implicit declaration of function =E2=80=98dma_get_sgtable=E2=80=99
> > > >> > >>>
> > > >> > >>> For architectures using dma_map_ops, dma_mmap_coherent()=
 and
> > > >> > >>> dma_get_sgtable() are provided in <asm-generic/dma-mappi=
ng-common.h>.
> > > >> > >>>
> > > >> > >>> C6x does not use dma_map_ops, hence it should implement =
them as inline
> > > >> > >>> stubs using dma_common_mmap() and dma_common_get_sgtable=
().
> > > >> > >>>
> > > >> > >> So are dma_mmap_coherent() and dma_get_sgtable() part of =
the DMA API
> > > >> > >> now? I don't them in Documentation/DMA*.txt anywhere.
> > > >> > >>
> > > >> > >> Why does the default dma_common_mmap() for !CONFIG_MMU re=
turn an
> > > >> > >> error?
> > > >> > >>
> > > >> > >> Wouldn't it be better to provide default implementations =
that an arch
> > > >> > >> could override rather than having to patch all "no dma_ma=
p_ops"
> > > >> > >> architectures?
> > > >> > >>
> > > >> > > Speaking for the still-reviewed ARC Port, I completely agr=
ee with Mark.
> > > >>
> > > >> dma_mmap_coherent() was partially in the DMA mapping API for s=
ome time, but
> > > >> it was available only on a few architectures (afair ARM, power=
pc and avr32).
> > > >> This caused significant problems for writing unified device dr=
ivers or some
> > > >> device helper modules which were aimed to work on more than on=
e
> > > >> architecture.
> > > >>
> > > >> dma_get_sgtable() is an extension discussed during the Linaro =
meetings. It
> > > >> is required to correctly implement buffer sharing between devi=
ce driver
> > > >> without hacks or any assumptions about memory layout in the de=
vice drivers.
> > > >>
> > > >> I have implemented some generic code for both of those two fun=
ctions,
> > > >> keeping
> > > >> in mind that on some hardware architectures (like already ment=
ioned VIVT)
> > > >> it might be not possible to provide coherent mapping to usersp=
ace. It is
> > > >> perfectly fine for those functions to return an error in such =
case.
> > > >
> > > > It's not possible on VIPT either.  This means that the API is u=
nusable
> > > > on quite a large number of architectures.  Surely, if we're sta=
rting to
> > > > write drivers using this, we need to fix the API before more pe=
ople try
> > > > to use it.
> > > >
> > > > For PA-RISC (and all other VIPT, I assume) I need an API which =
allows me
> > > > to remap the virtual address of the kernel component (probably =
using the
> > > > kmap area) so the user space and kernel space addresses are con=
gruent.
> > >
> > > So what are we gonna do for 3.8? I'd like to get my allmodconfig =
build
> > > green again ;-)
> > >
> > > Change the API?
> >
> > Well, if we want the API to work universally, we have to.  As I sai=
d,
> > for VIPT systems, the only coherency mechanism we have is the virtu=
al
> > address ... we have to fix that in the kernel to be congruent with =
the
> > userspace virtual address if we want coherency between the kernel a=
nd
> > userspace.
> >
> > However, if it only needs to work on ARM and x86, it can stay the w=
ay it
> > is and we could just pull it out of the generic core.
> >
> > Who actually wants to use this API, and what for?
> >
> > > Keep the API but do a best-effort fix to unbreak the builds?
> > >   - Apply my patches that got acks (avr32/blackfin/cris/m68k),
> > >   - Use static inlines that return -EINVAL for the rest
> > > (c6x/frv/mn10300/parisc/xtensa).
> > > I still have a few m68k fixes queued for 3.8, for which I've been=
 postponing the
> > > pull request to get this sorted out, so I could include the above=
=2E
> > >
> > > Any other solution?
> >
> > If it's an API that only works on ARM and x86, there's not much poi=
nt
> > pretending it's universal, so we should remove it from the generic =
arch
> > code and allow only those architectures which can use it.
>
> There might be a simple solution:  just replace void *cpu_addr with v=
oid
> **cpu_addr in the API.  This is a bit nasty since compilers think tha=
t
> void ** to void * conversion is quite legal, so it would be hard to p=
ick
> up misuse of this (uint8_t ** would be better).  That way VIPT could
> remap the kernel pages to a coherent address.  This would probably ha=
ve
> to change in the dma_mmap_attr() and dma_ops structures.
>
> All consumers would have to expect cpu_addr might change, but that se=
ems
> doable.

I still don't get how this can help having a coherent buffer between DM=
A
(devices) and CPU (kernel and user space mappings). The main purpose of
the dma_mmap_coherent() call is to provide a common API for mapping a
coherent buffer between DMA (device) and userspace. It is not about
creating a coherent mapping for sharing memory between userspace and
kernel space.

Best regards
--=20
Marek Szyprowski
Samsung Poland R&D Center
