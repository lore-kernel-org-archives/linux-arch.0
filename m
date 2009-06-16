From: Jamie Lokier <jamie@shareable.org>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 16 Jun 2009 21:07:05 +0100
Message-ID: <20090616200705.GP11893@shareable.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com> <fa686aa40906160906i7a05fc77jd1b2b920a1680812@mail.gmail.com> <20090616181855.GF11893@shareable.org> <fa686aa40906161228o569fa75fp60cdfc450ccbb5ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:33994 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbZFPUHK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2009 16:07:10 -0400
Content-Disposition: inline
In-Reply-To: <fa686aa40906161228o569fa75fp60cdfc450ccbb5ea@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

Grant Likely wrote:
> On Tue, Jun 16, 2009 at 12:18 PM, Jamie Lokier<jamie@shareable.org> wrote:
> > Something which lets you specify a dependency in a one-line
> > MODULE_INIT_PREREQS() macro would be much nicer.
> 
> That would work for some cases, but a lot of cases the problem is not
> module init order, but rather driver the probe order.  ie. In the
> Ethernet case I was working on the mac cannot be opened before the
> phy_device is registered.  Or another example is GPIOs.  An GPIO
> driven SPI or MDIO bus cannot be probed before all the devices
> providing the GPIOs are probed (right now GPIOs are 'special' and
> probed early, but this is ugly and there is no reason it couldn't be
> handled within the Linux driver model.

Both of those cases look like a simple module init order problem.

I'm not seeing how it's a probe order problem.  Even if you can probe
PHYs independently first, how are they going to be bound to the
ethernet MACs, other than by dodgy defaults?

In any of your examples, is the "modprobe" symbol dependency order
insufficient, when they are external modules?

If the problem is simply that "modprobe" can calculate dependencies
but linked-in modules don't, maybe the solution is to use the symbolic
dependencies to calculate a linked-in driver initialisation order.

If it's a probe order problem, where there aren't symbolic
dependencies, then MODULE_PROVIDE("gpio") and MODULE_REQUIRE("gpio")
or something like that might handle those cases, except for tricky
ones like a GPIO-driven I2C bus which controls a GPIO chip.

-- Jamie
