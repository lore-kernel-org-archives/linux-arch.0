From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 3 Jul 2012 13:39:34 +0000
Message-ID: <201207031339.34369.arnd@arndb.de>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20120703114844.GJ29030@opensource.wolfsonmicro.com> <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Tuesday 03 July 2012, Stephen Rothwell wrote:
> > > Maybe Michal Marek or someone on the kbuild mailing list can help
> > > out with a solution for that.
> > 
> > We could do that incrementally...
> 
> Yes, indeed it should be a separate change.

Ok, let's do that then. What tree should we use for merging it?

In theory I should take it to some asm-generic tree, but since
I get very little traffic there, I'm usually happy to just provide
an Ack and let anyone who needs the patch merge it through their
trees.

	Arnd
