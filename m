From: Jamie Lokier <jamie@shareable.org>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 16 Jun 2009 19:18:55 +0100
Message-ID: <20090616181855.GF11893@shareable.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com> <fa686aa40906160906i7a05fc77jd1b2b920a1680812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa686aa40906160906i7a05fc77jd1b2b920a1680812@mail.gmail.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Grant Likely wrote:
> http://patchwork.ozlabs.org/patch/24152/
> 
> I never actually pushed through and finished it because it turned out
> to be a non-issue for Ethernet devices in the end.  However, I can see
> the value.  With this approach, a driver can use a
> bus_register_notifier() variant without caring about the device
> registration order, and the drivers notifier callback will get called
> at the appropriate time.
> 
> In your example case I could see the framebuffer driver deferring the
> final part of its initialization until the needed i2c device shows up.

It makes drivers more complicated and larger than necessary, though,
having to add more functions and register more callbacks.

Something which lets you specify a dependency in a one-line
MODULE_INIT_PREREQS() macro would be much nicer.

I can see the callbacks being useful, and necessary, for drivers which
need to interleave their initialisation.  E.g. need to initialise an
external framebuffer chip before you can use it's I2C GPIOs, but then
need to initialise an I2C driver before you can read the framebuffer
parameters to finish setting up the framebuffer.

-- Jamie
