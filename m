From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Mon, 9 Jul 2012 15:23:32 -0700
Message-ID: <20120709222332.GA16202@gmail.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120703114844.GJ29030@opensource.wolfsonmicro.com>
 <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
 <201207031339.34369.arnd@arndb.de>
 <20120703134729.GP29030@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120703134729.GP29030@opensource.wolfsonmicro.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
List-Id: linux-arch.vger.kernel.org

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
