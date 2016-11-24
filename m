From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 24 Nov 2016 07:00:50 +0100
Message-ID: <20161124060050.GA788@gmail.com>
References: <20161123205338.GA12050@angband.pl>
 <20161123210256.31501-1-kilobyte@angband.pl>
 <20161124044028.GA12704@gmail.com>
 <20161124162051.5e336127@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34486 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcKXGAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2016 01:00:54 -0500
Content-Disposition: inline
In-Reply-To: <20161124162051.5e336127@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Adam Borowski <kilobyte@angband.pl>, Michal Marek <mmarek@suse.com>, Philip Muller <philm@manjaro.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>


* Nicholas Piggin <npiggin@gmail.com> wrote:

> >  scripts/Makefile.build | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 72 insertions(+), 6 deletions(-)
> > 
> > It was applied 4 hours after it was sent in the -rc3 timeframe, and then it went 
> > upstream in -rc5:
> > 
> >      "Here are some regression fixes for kbuild:
> >     
> >        - modversion support for exported asm symbols (Nick Piggin). The
> >          affected architectures need separate patches adding
> >          asm-prototypes.h.
> > 
> > ... the fine merge log even says that the commit 'needs separate patches'!
> > 
> > It's still totally broken upstream and it didn't fix any regressions AFAICS (or if 
> > it did then its changelog was very silent on that fact).
> 
> Well it doesn't fix regression by itself, as discussed it needs architecture
> patches. I've tried keeping linux-arch on cc for all this modversion breakage
> stuff since it became clear it would require arch changes.
> 
> The actual x86 bug I suppose you would say is caused by 784d5699eddc5. But I
> should probably have included more background in the above initial crc support
> patch, e.g, at least reference 22823ab419d. So mea culpa for that.

Indeed 784d5699eddc5 makes more sense:

  784d5699eddc ("x86: move exports to actual definitions")
  22823ab419d8 ("EXPORT_SYMBOL() for asm")

... and sorry about coming down on you and Marek!

I've Cc:-ed Al.

I think what happened is that 22823ab419d8 and 784d5699eddc caused the boot 
regression (modular builds with modversions enabled not booting), and your fix 
half-fixed it - with the remaining fix (that adds the header to x86) fixing the 
rest.

Still the fact remains that modversions was broken in -rc1 which delayed testing 
done by a number of prominent testers. :-(

Thanks,

	Ingo
