From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 24 Nov 2016 16:24:10 +0100
Message-ID: <20161124152410.GC30905@kroah.com>
References: <20161123205338.GA12050@angband.pl>
 <20161123210256.31501-1-kilobyte@angband.pl>
 <20161124044028.GA12704@gmail.com>
 <20161124162051.5e336127@roar.ozlabs.ibm.com>
 <20161124060050.GA788@gmail.com>
 <20161124182026.34e6570b@roar.ozlabs.ibm.com>
 <20161124073639.GA12728@kroah.com>
 <20161124185322.1e2a492c@roar.ozlabs.ibm.com>
 <20161124095622.GA14390@kroah.com>
 <20161124213152.30d8d27a@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965473AbcKXPYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2016 10:24:01 -0500
Content-Disposition: inline
In-Reply-To: <20161124213152.30d8d27a@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Adam Borowski <kilobyte@angband.pl>, Michal Marek <mmarek@suse.com>, Philip Muller <philm@manjaro.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>

On Thu, Nov 24, 2016 at 09:31:52PM +1100, Nicholas Piggin wrote:
> On Thu, 24 Nov 2016 10:56:22 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Nov 24, 2016 at 06:53:22PM +1100, Nicholas Piggin wrote:
> > > On Thu, 24 Nov 2016 08:36:39 +0100
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > On Thu, Nov 24, 2016 at 06:20:26PM +1100, Nicholas Piggin wrote:  
> > > > > But still, modversions is pretty complicated for what it gives us. It sends
> > > > > preprocessed C into a C parser that makes CRCs using type definitions of
> > > > > exported symbols, then turns those CRCs into a linker script which which is
> > > > > used to link the .o file with. What we get in return is a quite limited and
> > > > > symbol "versioning" system.
> > > > > 
> > > > > What if we ripped all that out and just attached an explicit version to
> > > > > each export, and incompatible changes require an increment?    
> > > > 
> > > > How would that work for structures?  Would that be required for every
> > > > EXPORT_SYMBOL* somehow?  
> > > 
> > > Yeah just have EXPORT_SYMBOL take another parameter which attaches a version
> > > number and use that as the value for the __crc_ symbol versions rather than
> > > a calculated CRC.
> > > 
> > > Yes it would require some level of care from developers and may be a small
> > > annoyance when changing exports. But making people think a tiny bit more
> > > before chnaging exported ABI shouldn't be the end of the world.  
> > 
> > That wouldn't work at all for structures that change, as we never
> > explicitly "mark" them for export anywhere.
> 
> Well, the module arrives at the objects one way or another via an exported
> symbol. Although it can be by following a lot of pointers so yes it's
> probably near impossible to do well.

Yes, manual "marking" is never going to be a viable solution.

> >  You need a tool that looks
> > at either the source code (what we have today), or looks at the
> 
> What we have today only looks at the type of the exported function or
> variable I think (or does it? I didn't look that far into the parser).

It should catch things if you change a structure layout of something
that is an argument in a function (like a pointer to a structure),
otherwise it wouldn't really be that good of a check, and kind of
useless.

> Does not follow down all possible derivable pointer types.

It should be pretty good, as I think the code is based on the old SuSE
scripts that used to do this really well.  But it's been a long time
since I looked at it, so I could be wrong.

> > > > > Google tells me
> > > > > Linus is not a neutral bystander on the topic of symbol versioning, so I'm
> > > > > bracing for a robust response :) (actually I don't much care either way, I'm
> > > > > happy to put a couple of bandaids on it and keep it going)    
> > > > 
> > > > There are tools that people are working on to make it more obvious where
> > > > API breaks happen by looking at the .o debug data instead of our crazy
> > > > current system (which is really better than nothing), perhaps we should
> > > > start using them instead?
> > > > 
> > > > See here for more details about this:
> > > > 	https://kernel-recipes.org/en/2016/talks/would-an-abi-changes-visualization-tool-be-useful-to-linux-kernel-maintenance/  
> > > 
> > > Hmm. I guess it's basically similar to modversions, so has downsides of not
> > > detecting a semantic change unless it changes the type. But still, if we could
> > > replace our custom code with a tool like this for modversions functionality,
> > > that alone would be a massive improvement. But requiring debug info might be
> > > a bit of a show stopper. I also don't know if that would handle asm functions.  
> > 
> > I think we can live without asm functions changing their arguments as
> > that is usually very rare.  And maybe debugging info being a requirement
> > for those that want modversions (i.e. the distros), is ok as they
> > already generate that as part of their build.
> 
> Maybe. I'd like to know how people really care about it. Linus post from
> 
> http://yarchive.net/comp/linux/modversions.html
> 
> Seem to be that he just likes it to prevent module loading if the git version
> is not available. Fair usage, but could we do better with less effort? Maybe
> ship with a source version that can do the same job. If you take care of that
> case, then what is left?

The goal is to be able to tell when a symbol changed somehow (structure
or function signature) and if it has, then to hopefully prevent loading
a module that doesn't have the same signature.  The distros really want
this as they want "external" modules to load properly, even when they
bump their main kernel package version.  And it's a good goal to have,
no need to rebuild external packages (that usually come from external
places) if you don't have to, as sometimes you need those modules to
have your machine to work properly (like the fibre channel mess of
out-of-tree drivers...)

So however that type of checking is done, is fine with me, I have no
real desire to mess with this as personally, I never use it for my own
machines (I just use module signing and then throw away the key after
building the kernel).

thanks,

greg k-h
