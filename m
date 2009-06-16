From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 16 Jun 2009 13:28:40 -0600
Message-ID: <fa686aa40906161228o569fa75fp60cdfc450ccbb5ea@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com>
	<fa686aa40906160906i7a05fc77jd1b2b920a1680812@mail.gmail.com>
	<20090616181855.GF11893@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20090616181855.GF11893@shareable.org>
Sender: linux-embedded-owner@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 16, 2009 at 12:18 PM, Jamie Lokier<jamie@shareable.org> wro=
te:
> Grant Likely wrote:
>> http://patchwork.ozlabs.org/patch/24152/
>>
>> I never actually pushed through and finished it because it turned ou=
t
>> to be a non-issue for Ethernet devices in the end. =A0However, I can=
 see
>> the value. =A0With this approach, a driver can use a
>> bus_register_notifier() variant without caring about the device
>> registration order, and the drivers notifier callback will get calle=
d
>> at the appropriate time.
>>
>> In your example case I could see the framebuffer driver deferring th=
e
>> final part of its initialization until the needed i2c device shows u=
p.
>
> It makes drivers more complicated and larger than necessary, though,
> having to add more functions and register more callbacks.
>
> Something which lets you specify a dependency in a one-line
> MODULE_INIT_PREREQS() macro would be much nicer.

That would work for some cases, but a lot of cases the problem is not
module init order, but rather driver the probe order.  ie. In the
Ethernet case I was working on the mac cannot be opened before the
phy_device is registered.  Or another example is GPIOs.  An GPIO
driven SPI or MDIO bus cannot be probed before all the devices
providing the GPIOs are probed (right now GPIOs are 'special' and
probed early, but this is ugly and there is no reason it couldn't be
handled within the Linux driver model.

I could see some form of .probe_prereqs member of a device driver, but
what form should it take?  Callback?  Data structure?  The field of
prereqs (or rather figuring out the prereqs) is so large that I don't
feel confident trying to define something.  A callback is probably the
most flexible if it could be called after each probe or registration
event on other devices.  The idea being that if the prereq call fails,
then it will be tried again later.  Or, thinking further, perhaps
instead of a .probe_prereq, just have .probe returns -ETRYAGAIN and
make the driver core put the device on the end of the queue of devices
to get probed.  This could get ugly in the driver core though.

Needs more thought....

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
