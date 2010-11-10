From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GPIO]implement sleeping GPIO chip removal
Date: Wed, 10 Nov 2010 23:47:09 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1011102346000.2900@localhost6.localdomain6>
References: <4CD6F049.10102@o2.pl> <20101110050947.GC4110@angua.secretlab.ca> <4CDABA03.2050000@o2.pl> <alpine.LFD.2.00.1011102134350.2900@localhost6.localdomain6> <4CDB0834.4080101@o2.pl> <alpine.LFD.2.00.1011102203500.2900@localhost6.localdomain6>
 <20101110211540.GA7063@angua.secretlab.ca> <20101110224516.GA19567@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35049 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218Ab0KJWsE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Nov 2010 17:48:04 -0500
In-Reply-To: <20101110224516.GA19567@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Maciej Szmigiero <mhej@o2.pl>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@cam.ac.uk>, Ben Nizette <bn@niasdigital.com>

On Wed, 10 Nov 2010, Greg KH wrote:
> On Wed, Nov 10, 2010 at 02:15:40PM -0700, Grant Likely wrote:
> > On Wed, Nov 10, 2010 at 10:07:05PM +0100, Thomas Gleixner wrote:
> > > If we see a shortcoming like this, we fix it and do not magically work
> > > around it.
> > 
> > +1
> > 
> > Thomas is right.  kobject reference counting is the correct solution.
> > Nack on this approach.
> 
> Only use a kobject if you want to be in the sysfs hierarchy (which I
> don't think you want to do here.)  If you want proper reference
> counting, use a 'struct kref' instead.

Oops, yes. I always confuse those.

Thanks for pointing it out - probably not the first time :)

       tglx
