From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GPIO]implement sleeping GPIO chip removal
Date: Wed, 10 Nov 2010 10:49:44 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1011101045230.2900@localhost6.localdomain6>
References: <4CD6F049.10102@o2.pl> <20101110050947.GC4110@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42036 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805Ab0KJJuT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Nov 2010 04:50:19 -0500
In-Reply-To: <20101110050947.GC4110@angua.secretlab.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Maciej Szmigiero <mhej@o2.pl>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Greg Kroah-Hartman <gregkh@suse.de>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@cam.ac.uk>, Ben Nizette <bn@niasdigital.com>

On Tue, 9 Nov 2010, Grant Likely wrote:

> On Sun, Nov 07, 2010 at 07:30:33PM +0100, Maciej Szmigiero wrote:
> > [GPIO]implement sleeping GPIO chip removal
> > 
> > Existing GPIO chip removal code is only of "non-blocking" type: if the chip is currently
> > requested it just returns -EBUSY.
> > This is bad for devices which disappear and reappear, like those on hot pluggable buses,
> > because it forces the driver to call gpiochip_remove() in loop until it returns 0.
> > 
> > This patch implements a new function which sleeps until device is free instead of
> > returning -EBUSY like gpiochip_remove().
> > 
> > Signed-off-by: Maciej Szmigiero <mhej@o2.pl>
> 
> This patch makes me uncomfortable, but I'm not entirely sure why.  Is

Maybe because it open codes a sloppy refcounting with a loop and magic
sleeps instead of converting the code to kobjects and proper
refcounting ?

Thanks,

	tglx
