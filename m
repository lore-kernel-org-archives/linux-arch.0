From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Thu, 24 Nov 2016 10:38:04 +0100
Message-ID: <2648926.soV2DX4tAK@wuerfel>
References: <20161123205338.GA12050@angband.pl> <20161124073639.GA12728@kroah.com> <20161124185322.1e2a492c@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161124185322.1e2a492c@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Adam Borowski <kilobyte@angband.pl>, Michal Marek <mmarek@suse.com>, Philip Muller <philm@manjaro.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Russell King <rmk+lkml@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Thursday, November 24, 2016 6:53:22 PM CET Nicholas Piggin wrote:
> > 
> > > Google tells me
> > > Linus is not a neutral bystander on the topic of symbol versioning, so I'm
> > > bracing for a robust response  (actually I don't much care either way, I'm
> > > happy to put a couple of bandaids on it and keep it going)  
> > 
> > There are tools that people are working on to make it more obvious where
> > API breaks happen by looking at the .o debug data instead of our crazy
> > current system (which is really better than nothing), perhaps we should
> > start using them instead?
> > 
> > See here for more details about this:
> >       https://kernel-recipes.org/en/2016/talks/would-an-abi-changes-visualization-tool-be-useful-to-linux-kernel-maintenance/
> 
> Hmm. I guess it's basically similar to modversions, so has downsides of not
> detecting a semantic change unless it changes the type. But still, if we could
> replace our custom code with a tool like this for modversions functionality,
> that alone would be a massive improvement. But requiring debug info might be
> a bit of a show stopper. I also don't know if that would handle asm functions.

It's certainly not an option for v4.9 at this point. There is also no
realistic way we can get a correct asm/asm-prototypes.h for all the
other architectures in place. At the moment, powerpc is the only
one that actually works with modversions.

We can either make CONFIG_MODVERSIONS a per-architecture opt-in
and let only the ones that have the header file select that, or
revert all of Al's original patches that moved the exports.

	Arnd
