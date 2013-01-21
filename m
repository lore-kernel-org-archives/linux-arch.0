From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent() and dma_get_sgtable()
Date: Mon, 21 Jan 2013 21:00:53 +0100
Message-ID: <CAMuHMdXk1mdkMViYqypvnXO0_1LdjbH8S7z8FNe97yDUW6BYRA@mail.gmail.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
	<1358073890-3610-3-git-send-email-geert@linux-m68k.org>
	<1358177872.4357.53.camel@t520.localdomain>
	<50F4D83A.7020803@synopsys.com>
	<CAMuHMdWjZAY19GPpjoXKfWb3pOp2RbZXDvb4nr5pMmjEMFuB4w@mail.gmail.com>
	<50F56286.8070200@samsung.com>
	<1358269008.10591.11.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:44825 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583Ab3AUUAz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 15:00:55 -0500
In-Reply-To: <1358269008.10591.11.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Mark Salter <msalter@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org

On Tue, Jan 15, 2013 at 5:56 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Tue, 2013-01-15 at 15:07 +0100, Marek Szyprowski wrote:
>> On 1/15/2013 10:13 AM, Geert Uytterhoeven wrote:
>> > Marek?
>> >
>> > On Tue, Jan 15, 2013 at 5:16 AM, Vineet Gupta
>> > <Vineet.Gupta1@synopsys.com> wrote:
>> > > On Monday 14 January 2013 09:07 PM, Mark Salter wrote:
>> > >> On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
>> > >>> c6x/allmodconfig (assumed):
>> > >>>
>> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=
=80=98vb2_dc_mmap=E2=80=99:
>> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: imp=
licit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99
>> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=
=80=98vb2_dc_get_base_sgt=E2=80=99:
>> > >>> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: imp=
licit declaration of function =E2=80=98dma_get_sgtable=E2=80=99
>> > >>>
>> > >>> For architectures using dma_map_ops, dma_mmap_coherent() and
>> > >>> dma_get_sgtable() are provided in <asm-generic/dma-mapping-com=
mon.h>.
>> > >>>
>> > >>> C6x does not use dma_map_ops, hence it should implement them a=
s inline
>> > >>> stubs using dma_common_mmap() and dma_common_get_sgtable().
>> > >>>
>> > >> So are dma_mmap_coherent() and dma_get_sgtable() part of the DM=
A API
>> > >> now? I don't them in Documentation/DMA*.txt anywhere.
>> > >>
>> > >> Why does the default dma_common_mmap() for !CONFIG_MMU return a=
n
>> > >> error?
>> > >>
>> > >> Wouldn't it be better to provide default implementations that a=
n arch
>> > >> could override rather than having to patch all "no dma_map_ops"
>> > >> architectures?
>> > >>
>> > > Speaking for the still-reviewed ARC Port, I completely agree wit=
h Mark.
>>
>> dma_mmap_coherent() was partially in the DMA mapping API for some ti=
me, but
>> it was available only on a few architectures (afair ARM, powerpc and=
 avr32).
>> This caused significant problems for writing unified device drivers =
or some
>> device helper modules which were aimed to work on more than one
>> architecture.
>>
>> dma_get_sgtable() is an extension discussed during the Linaro meetin=
gs. It
>> is required to correctly implement buffer sharing between device dri=
ver
>> without hacks or any assumptions about memory layout in the device d=
rivers.
>>
>> I have implemented some generic code for both of those two functions=
,
>> keeping
>> in mind that on some hardware architectures (like already mentioned =
VIVT)
>> it might be not possible to provide coherent mapping to userspace. I=
t is
>> perfectly fine for those functions to return an error in such case.
>
> It's not possible on VIPT either.  This means that the API is unusabl=
e
> on quite a large number of architectures.  Surely, if we're starting =
to
> write drivers using this, we need to fix the API before more people t=
ry
> to use it.
>
> For PA-RISC (and all other VIPT, I assume) I need an API which allows=
 me
> to remap the virtual address of the kernel component (probably using =
the
> kmap area) so the user space and kernel space addresses are congruent=
=2E

So what are we gonna do for 3.8? I'd like to get my allmodconfig build
green again ;-)

Change the API?

Keep the API but do a best-effort fix to unbreak the builds?
  - Apply my patches that got acks (avr32/blackfin/cris/m68k),
  - Use static inlines that return -EINVAL for the rest
(c6x/frv/mn10300/parisc/xtensa).
I still have a few m68k fixes queued for 3.8, for which I've been postp=
oning the
pull request to get this sorted out, so I could include the above.

Any other solution?

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
