From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 16 Jun 2009 15:04:44 -0600
Message-ID: <fa686aa40906161404x69b473a3ufc3c67fd57abcb21@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com>
	<fa686aa40906160906i7a05fc77jd1b2b920a1680812@mail.gmail.com>
	<20090616181855.GF11893@shareable.org> <fa686aa40906161228o569fa75fp60cdfc450ccbb5ea@mail.gmail.com>
	<20090616200705.GP11893@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:52037 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbZFPVFC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2009 17:05:02 -0400
In-Reply-To: <20090616200705.GP11893@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue, Jun 16, 2009 at 2:07 PM, Jamie Lokier<jamie@shareable.org> wrot=
e:
> Grant Likely wrote:
>> On Tue, Jun 16, 2009 at 12:18 PM, Jamie Lokier<jamie@shareable.org> =
wrote:
>> > Something which lets you specify a dependency in a one-line
>> > MODULE_INIT_PREREQS() macro would be much nicer.
>>
>> That would work for some cases, but a lot of cases the problem is no=
t
>> module init order, but rather driver the probe order. =A0ie. In the
>> Ethernet case I was working on the mac cannot be opened before the
>> phy_device is registered. =A0Or another example is GPIOs. =A0An GPIO
>> driven SPI or MDIO bus cannot be probed before all the devices
>> providing the GPIOs are probed (right now GPIOs are 'special' and
>> probed early, but this is ugly and there is no reason it couldn't be
>> handled within the Linux driver model.
>
> Both of those cases look like a simple module init order problem.
>
> I'm not seeing how it's a probe order problem. =A0Even if you can pro=
be
> PHYs independently first, how are they going to be bound to the
> ethernet MACs, other than by dodgy defaults?
>
> In any of your examples, is the "modprobe" symbol dependency order
> insufficient, when they are external modules?

In both cases the driver is waiting for a specific instance, but has
no idea which driver will provide that service.

=46or the Ethernet example:  Both the MAC driver and the MDIO bus drive=
r
are registered independently (say via either the platform bus).  The
MDIO bus driver creates a new mdio_bus instance and registers a
phy_device for each child on the bus.  The pdata for the MAC driver
only contains the address of the phy, but it does not know which
driver handles the MDIO bus and it does not know what driver will
handle the phy.  All the MAC cares about dereferencing the phy address
to get a pointer to the phy_device structure which only works after
the MDIO bus is probed and the correct phy_device is registered..
Module dependencies won't help here because the MAC cannot know what
module to depend against.  Plus, in some cases, the MAC will be used
without a PHY, in which case it cannot depend on any phy modules.

=46or the GPIO example, same thing.  Something like the i2c-gpio driver
doesn't know anything about which device provides the GPIO signals.
It is only handled GPIO numbers for each signal and it cannot be
probed before all the required GPIOs are registered with the system.
Again module dependencies don't work because the driver doesn't know
which GPIO driver it will get bound against at run time.

> If the problem is simply that "modprobe" can calculate dependencies
> but linked-in modules don't, maybe the solution is to use the symboli=
c
> dependencies to calculate a linked-in driver initialisation order.
>
> If it's a probe order problem, where there aren't symbolic
> dependencies, then MODULE_PROVIDE("gpio") and MODULE_REQUIRE("gpio")
> or something like that might handle those cases, except for tricky
> ones like a GPIO-driven I2C bus which controls a GPIO chip.

Ugh.... it feels too coarse grained to me.  It solves some of the
problems, but still requires playing dirty tricks for the tricky cases
which scuttles the whole lot.  ie. your i2c GPIO chip example.
Another driver wired to one of those 2nd level GPIOs and using
MODULE_REQUIRE("gpio") would immediately be defeated and would need
some other method to indicate the dependency.  Plus there is the
question when stuff is loaded as modules as to how does the kernel
know when MODULE_PROVIDE("gpio") is complete?  What if I load the gpio
driver after the gpio-i2c driver?  I'd much rather define the
dependency at the resource level, not module level because that is
what the driver is actually needing.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
