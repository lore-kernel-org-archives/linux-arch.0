Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:48615 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab2GKCoy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jul 2012 22:44:54 -0400
Date: Wed, 11 Jul 2012 11:44:12 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Message-ID: <20120711024411.GA11440@linux-sh.org>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120709233022.GO16319@n2100.arm.linux.org.uk>
 <20120710172223.GM10022@opensource.wolfsonmicro.com>
 <201207101807.28993.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201207101807.28993.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120711024412.9slX7HQBmbyMGJPm43QUxu6mT6gqPoaKDp_bEQA5jJY@z>

On Tue, Jul 10, 2012 at 06:07:28PM +0000, Arnd Bergmann wrote:
> On Tuesday 10 July 2012, Mark Brown wrote:
> > On Tue, Jul 10, 2012 at 12:30:22AM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Jul 09, 2012 at 03:23:32PM -0700, Mike Turquette wrote:
> > 
> > > > Russell owns clkdev so I'd prefer he take this patch.
> > 
> > > Note that I'm not going to be taking any further patches for at least
> > > the next 16 days (as I'm away), and I'm not going to even guarantee
> > > that I'll pick up on anything on the mailing lists during that period.
> > 
> > Oh dear, that's a bit sad - given that the merge window may well open
> > it'll mean we'll end up with at least one additional release where we
> > can't get the clock API available as standard :(
> 
> I can start an asm-generic branch in the arm-soc tree then (or maybe
> a new tree) and apply the patch there.
> 
Given that this patch has nothing at all to do with ARM, why not just
take it through the asm-generic tree?
