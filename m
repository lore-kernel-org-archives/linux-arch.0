From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch/tile: new multi-core architecture for Linux
Date: Thu, 27 May 2010 15:41:44 +0200
Message-ID: <AANLkTinTjpx6GTRidb6mzJ7At2tDlm6VeKW5dBGZZQcc@mail.gmail.com>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com>
	<201005252345.15685.arnd@arndb.de>
	<4BFDC3D1.40708@tilera.com>
	<201005271041.30519.arnd@arndb.de>
	<4BFE73DF.5090107@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50203 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab0E0Nlp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2010 09:41:45 -0400
In-Reply-To: <4BFE73DF.5090107@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Thu, May 27, 2010 at 15:30, Chris Metcalf <cmetcalf@tilera.com> wrot=
e:
> On 5/27/2010 4:41 AM, Arnd Bergmann wrote:
>> On Thursday 27 May 2010, Chris Metcalf wrote:
>>>> +EXPORT_SYMBOL(inb);
>>>>
>>>> If you just remove these definitions, you get a link error for any
>>>> driver that tries to use these, which is probably more helpful tha=
n
>>>> the panic.
>>>>
>>>> OTOH, are you sure that you can't just map the PIO calls to mmio f=
unctions
>>>> like readb plus some fixed offset? On most non-x86 architectures, =
the PIO
>>>> area of the PCI bus is just mapped to a memory range somewhere.
>>>>
>>>>
>>> I'll try to remove them and see if anything falls over. =C2=A0We do=
n't have
>>> any memory-mapped addresses in the 32-bit architecture, though that
>>> changes with the 64-bit architecture, which introduces IO mappings.=
 =C2=A0For
>>> PCI we actually have to do a hypervisor transaction for reads or wr=
ites.
>>>
>> Ok, then I assume that PIO would also be a hypervisor call, right?
>> If you don't have MMIO on 32 bit, you might want to not define eithe=
r
>> PIO (inb, ...) no MMIO (readb, ...) calls there and disable
>> CONFIG_HAVE_MMIO in Kconfig.
>>
>
> We don't define CONFIG_HAVE_MMIO, but drivers certainly seem to use
> ioread/iowrite methods as well as inb/outb without guarding them with
> any particular tests, so we have to provide definitions of some kind =
for
> all of them. =C2=A0I'll confer with our PCI developer to see if we ca=
n clean
> up the set of definitions in io.h.

It's CONFIG_NO_IOMEM (cfr. s390 and um), which is inverted and turned i=
nto
CONFIG_HAS_IOMEM, to be checked by drivers.

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
