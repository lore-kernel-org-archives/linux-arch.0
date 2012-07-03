From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 3 Jul 2012 11:16:05 +0000
Message-ID: <201207031116.05876.arnd@arndb.de>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au> <20120703101209.GH29030@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55858 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab2GCLQM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 07:16:12 -0400
In-Reply-To: <20120703101209.GH29030@opensource.wolfsonmicro.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>

On Tuesday 03 July 2012, Mark Brown wrote:
> On Tue, Jul 03, 2012 at 12:00:59PM +1000, Stephen Rothwell wrote:
> > On Mon,  2 Jul 2012 19:04:10 +0100 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > +#define __clk_get(clk)     ({ 1; })
> > > +#define __clk_put(clk)     do { } while (0)
> 
> > So why not:
> 
> > struct clk;
> 
> > static inline int __clk_get(struct clk *clk) { return 1; }
> > static inline void __clk_put(struct clk *clk) ( )
> 
> No idea, I'm just taking the existing default header and making it more
> generally available.

I prefer Stephen's version because that maintains the type checking.
However, that is not a controversial point at all IMHO. The question
that we need to decide on is whether we want automatic "generic-y"
statements in Kbuild.asm.

I'm not opposed to the idea, but I can imagine some arch maintainers
fine it confusing. When you first posted the patch, I spent some
time trying to get the wildcard logic moved to scripts/Makefile.asm-generic
and scripts/Makefile.headersinst but couldn't figure it out in the end.

I would definitely prefer being able to just write 

generic-y += clkdev.h 

in include/asm-generic/Kbuild.asm, rather than 

ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/clkdev.h),)
generic-y += clkdev.h
endif

Maybe Michal Marek or someone on the kbuild mailing list can help
out with a solution for that.

	Arnd
