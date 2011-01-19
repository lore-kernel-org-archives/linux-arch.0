From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Fix io{read,write}{16,32}be for big
 endian systems
Date: Wed, 19 Jan 2011 13:28:36 +0100
Message-ID: <AANLkTimaTOBfC18TUyTDZ-9CLGv8qGJG714-d7Jk7NVr@mail.gmail.com>
References: <1295374261-19609-1-git-send-email-lars@metafoo.de>
	<201101182237.53601.arnd@arndb.de>
	<4D36129F.8000302@metafoo.de>
	<201101191058.30096.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34061 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab1ASM2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2011 07:28:38 -0500
In-Reply-To: <201101191058.30096.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 19 January 2011 10:58, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 18 January 2011 23:22:23 Lars-Peter Clausen wrote:
>> On 01/18/2011 10:37 PM, Arnd Bergmann wrote:
>> > ...
>> The lm32 architecture is a big-endian softcpu architecture. I'm curr=
ently working on
>> the MilkyMist SoC which uses it and all the SoC components have nati=
ve endianess.
>
> ok.

I think this is the key concept that's being missed here:  devices
with _native_ endianess.  This is something that I've been grappling
with for the OpenRISC platform, as well.

The ioread/write accessors are supposed to be a platform-agnostic
interface and have a builtin assumption about the endianess of the
device/bus.  Device drivers that use ioread32 are explicity accessing
a little-endian device; ioread32be explicitly a big-endian device.
It's not really for the architecture to redefine these.  The same
applies to the readl/readw accessors as well, as far as I understand
it.

What's needed is another way of accessing device memory that doesn't
carry the endianess implication.  For the Wishbone bus, used by the
OpenRISC processor, I still haven't found a more satisfactory solution
than to define "wishbone accessors" that map to the underlying
io-accessors of the desired endianess.  These allow the endianess of
the bus to be set at compile time and hopefully for all wishbone
device drivers to do the right thing.

#ifdef CONFIG_WISHBONE_BIG_ENDIAN
#define wb_ioread8(p) ioread8(p)
#define wb_ioread16(p) ioread16be(p)
#define wb_ioread32(p) ioread32be(p)
#define wb_iowrite8(p) iowrite8(p)
#define wb_iowrite16(p) iowrite16be(p)
#define wb_iowrite32(p) iowrite32be(p)
#else
#define wb_ioread8(p) ioread8(p)
#define wb_ioread16(p) ioread16(p)
#define wb_ioread32(p) ioread32(p)
#define wb_iowrite8(p) iowrite8(p)
#define wb_iowrite16(p) iowrite16(p)
#define wb_iowrite32(p) iowrite32(p)
#endif /* CONFIG_WISHBONE_BIG_ENDIAN */

That said, there are architectures that do redefine the endianess of
the io-accessors to mean "native endianess", but this must have
implications for a large number of the drivers in the kernel tree and,
in my opinion, must be technically _incorrect_.  A driver written with
ioread32 shouldn't have the endianess of the access changed by the
architecture underneath it... or are others of a different opinion?

>> >
>> > * change the common ioread*/iowrite* functions to all be based on
>> > =C2=A0 the __raw_* I/O versions, not just the big-endian ones. The
>> > =C2=A0 space overhead you quoted is enough of a justification for =
that.
>>

Doing this breaks the endianess assumption built into the io-accessors.

/Jonas
