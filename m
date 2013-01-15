From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent()
 and dma_get_sgtable()
Date: Tue, 15 Jan 2013 16:56:48 +0000
Message-ID: <1358269008.10591.11.camel@dabdike.int.hansenpartnership.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
	 <1358073890-3610-3-git-send-email-geert@linux-m68k.org>
	 <1358177872.4357.53.camel@t520.localdomain> <50F4D83A.7020803@synopsys.com>
	 <CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
	 <50F56286.8070200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51745 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755471Ab3AOQ4w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jan 2013 11:56:52 -0500
In-Reply-To: <50F56286.8070200@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org

On Tue, 2013-01-15 at 15:07 +0100, Marek Szyprowski wrote:
> Hello,
>=20
> On 1/15/2013 10:13 AM, Geert Uytterhoeven wrote:
> > Marek?
> >
> > On Tue, Jan 15, 2013 at 5:16 AM, Vineet Gupta
> > <Vineet.Gupta1@synopsys.com> wrote:
> > > On Monday 14 January 2013 09:07 PM, Mark Salter wrote:
> > >> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
> > >>> c6x/allmodconfig (assumed):
> > >>>
> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=
=80=98vb2_dc_mmap=E2=80=99:
> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: impl=
icit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=
=80=98vb2_dc_get_base_sgt=E2=80=99:
> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: impl=
icit declaration of function =E2=80=98dma_get_sgtable=E2=80=99
> > >>>
> > >>> For architectures using dma_map_ops, dma_mmap_coherent() and
> > >>> dma_get_sgtable() are provided in <asm-generic/dma-mapping-comm=
on.h>.
> > >>>
> > >>> C6x does not use dma_map_ops, hence it should implement them as=
 inline
> > >>> stubs using dma_common_mmap() and dma_common_get_sgtable().
> > >>>
> > >> So are dma_mmap_coherent() and dma_get_sgtable() part of the DMA=
 API
> > >> now? I don't them in Documentation/DMA*.txt anywhere.
> > >>
> > >> Why does the default dma_common_mmap() for !CONFIG_MMU return an
> > >> error?
> > >>
> > >> Wouldn't it be better to provide default implementations that an=
 arch
> > >> could override rather than having to patch all "no dma_map_ops"
> > >> architectures?
> > >>
> > > Speaking for the still-reviewed ARC Port, I completely agree with=
 Mark.
>=20
> dma_mmap_coherent() was partially in the DMA mapping API for some tim=
e, but
> it was available only on a few architectures (afair ARM, powerpc and =
avr32).
> This caused significant problems for writing unified device drivers o=
r some
> device helper modules which were aimed to work on more than one=20
> architecture.
>=20
> dma_get_sgtable() is an extension discussed during the Linaro meeting=
s. It
> is required to correctly implement buffer sharing between device driv=
er
> without hacks or any assumptions about memory layout in the device dr=
ivers.
>=20
> I have implemented some generic code for both of those two functions,=
=20
> keeping
> in mind that on some hardware architectures (like already mentioned V=
IVT)
> it might be not possible to provide coherent mapping to userspace. It=
 is
> perfectly fine for those functions to return an error in such case.

It's not possible on VIPT either.  This means that the API is unusable
on quite a large number of architectures.  Surely, if we're starting to
write drivers using this, we need to fix the API before more people try
to use it.

=46or PA-RISC (and all other VIPT, I assume) I need an API which allows=
 me
to remap the virtual address of the kernel component (probably using th=
e
kmap area) so the user space and kernel space addresses are congruent.

James
