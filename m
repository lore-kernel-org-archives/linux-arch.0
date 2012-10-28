From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH 2/4] asm-generic: io: don't perform swab during
 {in,out} string functions
Date: Sun, 28 Oct 2012 10:28:30 +0100
Message-ID: <CAMuHMdXJaUD6u+m1ax1_QYVXDrdm-W7VDUq0VN6a_v9QAgP4og@mail.gmail.com>
References: <1350488704-3711-1-git-send-email-will.deacon@arm.com>
	<1350488704-3711-3-git-send-email-will.deacon@arm.com>
	<CAMuHMdXcQjDyen+o5aH=1zUOkNX-cfT3aXBOgCpyop=V67jk7w@mail.gmail.com>
	<1350518655.4678.120.camel@pasglop>
	<CAMuHMdWH3GXJ_dW-FCAX=LAkBuQmQtwRUtNpcqg_afm-UFK_2g@mail.gmail.com>
	<1350955556.2728.18.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:50422 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab2J1J2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Oct 2012 05:28:32 -0400
In-Reply-To: <1350955556.2728.18.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>

Hi Ben,

On Tue, Oct 23, 2012 at 3:25 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2012-10-18 at 07:48 +0200, Geert Uytterhoeven wrote:
>> So assume you have the bytestream "Hello, world!\n" in memory on the
>> PCI device.I.e.
>>
>> 00000000  48 65 6c 6c 6f 2c 20 77  6f 72 6c 64 21 0a        |Hello, =
world!.|
>>
>> You want to copy it to system RAM using readsl(), which does:
>>
>>                u32 *buf =3D buffer;
>>                do {
>>                        u32 x =3D __raw_readl(addr + PCI_IOBASE);
>>                        *buf++ =3D x;
>>                 } while (--count);
>>
>> On little endian, the first __raw_readl() should return "0x6c6c6548"=
, so
>> it is stored correctly by "*buf =3D x ".
>
> Right.
>
>> On big endian, the first __raw_readl() should return "0x48656c6c" in=
stead,
>> else it's stored incorrectly by "*buf =3D x ".
>> But the PCI bus is little endian, so I expect __raw_readl() would re=
turn
>> "0x6c6c6548", and thus needs swapping?
>
> No. The PCI bus will return 0x48656c6c.
>
> This is due to how the PCI bus is wired to the CPU bus, which is call=
ed
> "byte address invariant". When doing a read of your byte 0, the CPU w=
ill
> effectively read 0 with byte enables picking 48. Since the CPU wants
> the first byte in the MSB, the bus must be wired up to the CPU such t=
hat
> the MSB is the first byte in address order.

According to
https://developer.apple.com/library/mac/#documentation/DeviceDrivers/Co=
nceptual/WritingPCIDrivers/endianness/endianness.html

"Byte-invariant addressing is a property of the bus bridge itself."

and

"From the software designer=E2=80=99s perspective, this means that the
hardware does not byte swap the data. However, from the hardware
designer=E2=80=99s perspective, the hardware must byte swap all data."

So this depends on a correct hardware implementation in the PCI
host bridge?

> This is how a BE CPU is normally wired to a LE bus. The fact that a
> register needs to be swapped comes from the fact that the device will
> put the MSB in the higher address byte, which then corresponds to the
> LSB on the BE CPU -> needs swapping.
>
> But for a byte stream, as you can see, no swapping is required.
>
> To some extent, it looks as if the wiring is byte swapped, in order t=
o
> provide the byte address invariance (and thus causes registers to loo=
k
> byteswapped) but it's really not, it's just a convention.
>
>> On m68k (classic with MMU), the situation is a bit more complicated,=
 as some ISA
>> (or PCMCIA) busses are physically wired swapped. But inw() and insw(=
) always do
>> either both swapping, or both no swapping. The state of support for =
ISA drivers
>> is a bit vague, though.
>
> Then something is horribly wrong in those m68k setups :-) Either in t=
he
> way the busses are wired or in your implementation of either inw or
> insw.

On (classic) m68k all of this is not about PCI (Atari Hades PCI is no
more), but about ISA and PCMCIA. I.e. no PCI host bridge with a modern
understanding of how it should be wired correctly on a big endian platf=
orm.

>> Now, on m68k without MMU, inw() doesn't do swapping, but insw() does=
=2E
>> This agrees more or less with you and Will, except that the bus seem=
s to be
>> physically swapped?
>
> Yeah that's possible. In the early days people incorrectly thought it
> would be smart to do that, thus avoiding a byteswap for register
> accesses .... and causing all data (DMA or FIFO) to be all backward.
>
> That's for example why the disks in the Tivo are byteswapped 16-bit b=
y
> 16-bit on the platter (ie, all the data is).
>
> I wouldn't be surprised if some 68k suffered from similar HW designer
> stupidity.

Yep, Atari IDE suffers from this, too.

> But the "proper" generic rule is byte address invariance, and that
> implies swap on register access and no swap on byte streams.

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
