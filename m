Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64566 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2GJSHi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2012 14:07:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 10 Jul 2012 18:07:28 +0000
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20120709233022.GO16319@n2100.arm.linux.org.uk> <20120710172223.GM10022@opensource.wolfsonmicro.com>
In-Reply-To: <20120710172223.GM10022@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201207101807.28993.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120710180728.3jQufsA2o1OfB68F6lIfIMdq2JV9fvQqAsvR4WyDaLA@z>

On Tuesday 10 July 2012, Mark Brown wrote:
> On Tue, Jul 10, 2012 at 12:30:22AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 09, 2012 at 03:23:32PM -0700, Mike Turquette wrote:
> 
> > > Russell owns clkdev so I'd prefer he take this patch.
> 
> > Note that I'm not going to be taking any further patches for at least
> > the next 16 days (as I'm away), and I'm not going to even guarantee
> > that I'll pick up on anything on the mailing lists during that period.
> 
> Oh dear, that's a bit sad - given that the merge window may well open
> it'll mean we'll end up with at least one additional release where we
> can't get the clock API available as standard :(

I can start an asm-generic branch in the arm-soc tree then (or maybe
a new tree) and apply the patch there.

	Arnd
