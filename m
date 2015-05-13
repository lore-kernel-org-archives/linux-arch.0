Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36456 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965154AbbEMNss (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 09:48:48 -0400
Date: Wed, 13 May 2015 15:48:42 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH v6] Documentation/arch: Add
 Documentation/arch-features.txt
Message-ID: <20150513134842.GA1657@gmail.com>
References: <20150511192918.GA11361@jtriplet-mobl1>
 <20150512142250.dcb053da81855ae1b5861173@linux-foundation.org>
 <20150512213843.GV21418@twins.programming.kicks-ass.net>
 <20150512144910.0b49c9a7a13336773449db33@linux-foundation.org>
 <20150513083441.GA17336@gmail.com>
 <20150513085636.GA11030@gmail.com>
 <20150513092421.GB11030@gmail.com>
 <20150513094622.GC11030@gmail.com>
 <20150513094756.GD11030@gmail.com>
 <20150513131835.GJ1517@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150513131835.GJ1517@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Josh Triplett <josh@joshtriplett.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150513134842.YTveZJpwSSyigfA9mB3Up2eHN41-tn21Eu_uJI-Sn1Q@z>


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, May 13, 2015 at 11:47:56AM +0200, Ingo Molnar wrote:
> >  - introduce the '..' denotion (in the final table) to show features 
> >    that cannot be supported by an architecture due to hardware 
> >    dependencies:
> > 
> > 		   gcov-profile-all:---------------.
> > 				THP:--------.      |
> > 		      irq-time-acct:-.      |      |
> > 				     |      |      |
> > 		----------------------------------------
> > 		  alpha           | TODO | TODO | TODO |
> > 		  arc             | TODO |  ..  | TODO |
> > 		  arm             |  ok  |  ok  |  ok  |
> > 		  arm64           | TODO |  ok  |  ok  |
> > 		  avr32           | TODO |  ..  | TODO |
> > 		  blackfin        | TODO |  ..  | TODO |
> > 		  c6x             | TODO |  ..  | TODO |
> > 
> >    so in the 'THP' column, if an architecture could in theory support 
> >    THP, it's listed as 'TODO', if it cannot, it's listed as '..'.
> 
> Shouldn't exactly that explanation be in the text file itself too?

Yeah, indeed, added it.

> Also, how about s/TODO//g for less clutter:

No, I'd like there to be a very visible 'TODO' item for missing 
features.

The 'clutter' shows how badly our generic kernel features are 
propagating :-/ We hope to reduce this clutter in the future.

Updated patch attached - I've added a few more features to the last 
table, and restructured the explanations, now every feature 
description also lists the Kconfig variable that it's tracking, e.g.:

      irq time acct: HAVE_IRQ_TIME_ACCOUNTING
                THP: HAVE_ARCH_TRANSPARENT_HUGEPAGE && 64BIT
   gcov profile all: ARCH_HAS_GCOV_PROFILE_ALL
    rwsem optimized: Optimized asm/rwsem.h
   queued spinlocks: ARCH_USE_QUEUED_SPINLOCKS
     queued rwlocks: ARCH_USE_QUEUED_RWLOCKS
     numa balancing: ARCH_SUPPORTS_NUMA_BALANCING && 64BIT && NUMA

Thanks,

	Ingo

=========================================>
