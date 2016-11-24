From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 24 Nov 2016 16:20:51 +1100
Message-ID: <20161124162051.5e336127@roar.ozlabs.ibm.com>
References: <20161123205338.GA12050@angband.pl>
        <20161123210256.31501-1-kilobyte@angband.pl>
        <20161124044028.GA12704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35700 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750698AbcKXFVI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2016 00:21:08 -0500
In-Reply-To: <20161124044028.GA12704@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Michal Marek <mmarek@suse.com>, Philip Muller <philm@manjaro.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>

On Thu, 24 Nov 2016 05:40:28 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> * Adam Borowski <kilobyte@angband.pl> wrote:
> 
> > Commit 4efca4ed ("kbuild: modversions for EXPORT_SYMBOL() for asm") adds
> > modversion support for symbols exported from asm files. Architectures
> > must include C-style declarations for those symbols in asm/asm-prototypes.h
> > in order for them to be versioned.
> > 
> > Add these declarations for x86, and an architecture-independent file that
> > can be used for common symbols.
> > 
> > User impact: kernels may fail to load modules at all when
> > CONFIG_MODVERSIONS=y.
> > 
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > Tested-by: Kalle Valo <kvalo@codeaurora.org>
> > Acked-by: Nicholas Piggin <npiggin@gmail.com>
> > Tested-by: Peter Wu <peter@lekensteyn.nl>
> > Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > ---
> > Changes: corrected Peter Wu's address, added Tested-by: Oliver.
> > This is an unsplit version (x86/include/ and include/ together).
> > 
> >  arch/x86/include/asm/asm-prototypes.h | 12 ++++++++++++
> >  include/asm-generic/asm-prototypes.h  |  7 +++++++
> >  2 files changed, 19 insertions(+)
> >  create mode 100644 arch/x86/include/asm/asm-prototypes.h
> >  create mode 100644 include/asm-generic/asm-prototypes.h  
> 
> Michal, I'm quite unhappy about how the offending commit that broke modversions 
> for essentially _everyone_ who does more complex modular builds on x86 ended up 
> upstream:
> 
>   commit 4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187
>   Author:     Nicholas Piggin <npiggin@gmail.com>
>   AuthorDate: Tue Nov 1 12:46:19 2016 +1100
>   Commit:     Michal Marek <mmarek@suse.com>
>   CommitDate: Tue Nov 1 16:20:17 2016 +0100
> 
>       kbuild: modversions for EXPORT_SYMBOL() for asm
> 
>       Allow architectures to create asm/asm-prototypes.h file that
>       provides C prototypes for exported asm functions, which enables
>       proper CRC versions to be generated for them.

What did this break? It's the first I've heard of it. For all architectures
without asm/asm-prototypes.h it should have been a functional noop. Any
breakage is some bug in my patch so that would need to be fixed urgently.

> 
>  scripts/Makefile.build | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 72 insertions(+), 6 deletions(-)
> 
> It was applied 4 hours after it was sent in the -rc3 timeframe, and then it went 
> upstream in -rc5:
> 
>      "Here are some regression fixes for kbuild:
>     
>        - modversion support for exported asm symbols (Nick Piggin). The
>          affected architectures need separate patches adding
>          asm-prototypes.h.
> 
> ... the fine merge log even says that the commit 'needs separate patches'!
> 
> It's still totally broken upstream and it didn't fix any regressions AFAICS (or if 
> it did then its changelog was very silent on that fact).

Well it doesn't fix regression by itself, as discussed it needs architecture
patches. I've tried keeping linux-arch on cc for all this modversion breakage
stuff since it became clear it would require arch changes.

The actual x86 bug I suppose you would say is caused by 784d5699eddc5. But I
should probably have included more background in the above initial crc support
patch, e.g, at least reference 22823ab419d. So mea culpa for that.

> Why was such a complex patch applied and why isn't it reverted or fixed upstream?

It's been discussed and reviewed and tested for a long time (mainly on
linux-arch and linux-kbuild) and simply taken a while to find the least nasty
way to get 4.9 working.

The real problem is that this regression was found very late because it seems
very specific to the exact build environment. Simply enabling modversions was
not enough to break it on all configs (you would silently get 0 CRCs) so it
slipped through despite build tests. Then it took a quite a while longer to
settle on how to fix it.

Thanks,
Nick
