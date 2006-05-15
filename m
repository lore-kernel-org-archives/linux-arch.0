Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:20692 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751430AbWEORai (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 May 2006 13:30:38 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] s390 kconfig cleanup.
Date: Mon, 15 May 2006 19:30:31 +0200
References: <20060515171645.GA11397@skybase>
In-Reply-To: <20060515171645.GA11397@skybase>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605151930.32241.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-ID: <linux-arch.vger.kernel.org>

On Monday 15 May 2006 19:16, Martin Schwidefsky wrote:
> Hi folks,
> I tried once again to clean up the Kconfig files for s390.
> We do not use drivers/Kconfig so far because this creates
> a lot of config options that make absolutely no sense for
> s390. The hardware for whole families of drivers, e.g.
> IPMI, TPM, I2C, I2O, ATA, IEEE1394, ISDN, etc, do not exist
> and very likely will never exist on a s390.
> 
> The "solution" so far had been to avoid drivers/Kconfig and
> use a special s390 version in driver/s390/Kconfig which
> includes some Kconfig files from the drivers directory
> tree and <copies> a few more config options which are useful
> for s390.
> 
> This has obviously two drawbacks: 1) we tend to "forget" new
> useful config options from Kconfig files we do not include,
> 2) the copies of the config options bit-rot just like code
> does, for example we still have UNIX98_PTY_COUNT which does
> not exist anymore.
> 
> The attached patch makes s390 use the common drivers/Kconfig
> and adds a lot of "depends on !S390" to hide all the config
> options that do not make sense for us.> What I think could 
> be improved is the fact that the dependency is negative,
> that is not-something, it would be much cleaner to have
> positive dependencies. For example the menues for Fusion
> or I2O are hidden with "depends on PCI" which is much nicer
> than "depends on !S390". Unluckily it is not obvious what
> the positive dependency should be for almost all menus.
> That is where the arch people get involved. Can we come
> up with a method how to "tag" all menus in the Kconfig files
> under drivers/ with a positive list of the architectures
> that actually want to include the menu/driver? Or even
> better tag the menu/driver with the bus that is required
> to attach the device?

Xen has a similar problem. They currently have tons of ugly negative
checks too. REAL_HARDWARE or similar is needed there, but it might
not fit the s390.

Checking PCI is a good start and should apply to most menus already.

I would suggest you guys come up with a common solution that works
for Xen and s390 at least (and maybe UML too?)

-Andi
