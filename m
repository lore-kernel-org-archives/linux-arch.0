Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:35379 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754593Ab2GIWXr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2012 18:23:47 -0400
Received: by pbbrq2 with SMTP id rq2so18853616pbb.34
        for <linux-arch@vger.kernel.org>; Mon, 09 Jul 2012 15:23:45 -0700 (PDT)
Date: Mon, 9 Jul 2012 15:23:32 -0700
From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Message-ID: <20120709222332.GA16202@gmail.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120703114844.GJ29030@opensource.wolfsonmicro.com>
 <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
 <201207031339.34369.arnd@arndb.de>
 <20120703134729.GP29030@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120703134729.GP29030@opensource.wolfsonmicro.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120709222332.8Zn2RapCJgpZ9vN8BMUQreTuyMRJ_qBWmECJNfnD0Ro@z>

On 20120703-14:47, Mark Brown wrote:
> On Tue, Jul 03, 2012 at 01:39:34PM +0000, Arnd Bergmann wrote:
> 
> > Ok, let's do that then. What tree should we use for merging it?
> 
> > In theory I should take it to some asm-generic tree, but since
> > I get very little traffic there, I'm usually happy to just provide
> > an Ack and let anyone who needs the patch merge it through their
> > trees.
> 
> I guess one of the clock trees which probably means Mike?

Hi Mark,

Russell owns clkdev so I'd prefer he take this patch.

Thanks,
Mike
