Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40950 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab2GIXat (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2012 19:30:49 -0400
Date: Tue, 10 Jul 2012 00:30:22 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Message-ID: <20120709233022.GO16319@n2100.arm.linux.org.uk>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20120703114844.GJ29030@opensource.wolfsonmicro.com> <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au> <201207031339.34369.arnd@arndb.de> <20120703134729.GP29030@opensource.wolfsonmicro.com> <20120709222332.GA16202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120709222332.GA16202@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Turquette <mturquette@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120709233022.RY4ZrtHIGgEmrHxq4t6NhSRlQNZl5GJG0rkDE8KomCo@z>

On Mon, Jul 09, 2012 at 03:23:32PM -0700, Mike Turquette wrote:
> On 20120703-14:47, Mark Brown wrote:
> > On Tue, Jul 03, 2012 at 01:39:34PM +0000, Arnd Bergmann wrote:
> > 
> > > Ok, let's do that then. What tree should we use for merging it?
> > 
> > > In theory I should take it to some asm-generic tree, but since
> > > I get very little traffic there, I'm usually happy to just provide
> > > an Ack and let anyone who needs the patch merge it through their
> > > trees.
> > 
> > I guess one of the clock trees which probably means Mike?
> 
> Hi Mark,
> 
> Russell owns clkdev so I'd prefer he take this patch.

Note that I'm not going to be taking any further patches for at least
the next 16 days (as I'm away), and I'm not going to even guarantee
that I'll pick up on anything on the mailing lists during that period.
