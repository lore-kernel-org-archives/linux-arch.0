From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 24 Nov 2016 18:20:26 +1100
Message-ID: <20161124182026.34e6570b@roar.ozlabs.ibm.com>
References: <20161123205338.GA12050@angband.pl>
        <20161123210256.31501-1-kilobyte@angband.pl>
        <20161124044028.GA12704@gmail.com>
        <20161124162051.5e336127@roar.ozlabs.ibm.com>
        <20161124060050.GA788@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33111 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbcKXHUq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2016 02:20:46 -0500
In-Reply-To: <20161124060050.GA788@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Adam Borowski <kilobyte@angband.pl>, Michal Marek <mmarek@suse.com>, Philip Muller <philm@manjaro.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>

On Thu, 24 Nov 2016 07:00:50 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> * Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > >  scripts/Makefile.build | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 72 insertions(+), 6 deletions(-)
> > > 
> > > It was applied 4 hours after it was sent in the -rc3 timeframe, and then it went 
> > > upstream in -rc5:
> > > 
> > >      "Here are some regression fixes for kbuild:
> > >     
> > >        - modversion support for exported asm symbols (Nick Piggin). The
> > >          affected architectures need separate patches adding
> > >          asm-prototypes.h.
> > > 
> > > ... the fine merge log even says that the commit 'needs separate patches'!
> > > 
> > > It's still totally broken upstream and it didn't fix any regressions AFAICS (or if 
> > > it did then its changelog was very silent on that fact).  
> > 
> > Well it doesn't fix regression by itself, as discussed it needs architecture
> > patches. I've tried keeping linux-arch on cc for all this modversion breakage
> > stuff since it became clear it would require arch changes.
> > 
> > The actual x86 bug I suppose you would say is caused by 784d5699eddc5. But I
> > should probably have included more background in the above initial crc support
> > patch, e.g, at least reference 22823ab419d. So mea culpa for that.  
> 
> Indeed 784d5699eddc5 makes more sense:
> 
>   784d5699eddc ("x86: move exports to actual definitions")
>   22823ab419d8 ("EXPORT_SYMBOL() for asm")
> 
> ... and sorry about coming down on you and Marek!
> 
> I've Cc:-ed Al.
> 
> I think what happened is that 22823ab419d8 and 784d5699eddc caused the boot 
> regression (modular builds with modversions enabled not booting), and your fix 
> half-fixed it - with the remaining fix (that adds the header to x86) fixing the 
> rest.

That's about right. My patch *should* be a noop by itself (just provides the
framework for x86 fix to work). So if you notice any new breakage let me
know.

> 
> Still the fact remains that modversions was broken in -rc1 which delayed testing 
> done by a number of prominent testers. :-(

Yep, not ideal. I have a patch or so which is supposed to make CRC failure
warnings more reliable.

But still, modversions is pretty complicated for what it gives us. It sends
preprocessed C into a C parser that makes CRCs using type definitions of
exported symbols, then turns those CRCs into a linker script which which is
used to link the .o file with. What we get in return is a quite limited and
symbol "versioning" system.

What if we ripped all that out and just attached an explicit version to
each export, and incompatible changes require an increment? Google tells me
Linus is not a neutral bystander on the topic of symbol versioning, so I'm
bracing for a robust response :) (actually I don't much care either way, I'm
happy to put a couple of bandaids on it and keep it going)

Thanks,
Nick
