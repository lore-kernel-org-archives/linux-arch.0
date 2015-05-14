Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:57836 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422888AbbENW5b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 May 2015 18:57:31 -0400
Message-ID: <1431644248.2981.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] Documentation/arch: Add kernel feature descriptions
 and arch support status under Documentation/features/
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 15 May 2015 08:57:28 +1000
In-Reply-To: <20150514123835.1bf436bc35d711f8dbf9bc0f@linux-foundation.org>
References: <20150513083441.GA17336@gmail.com>
	 <20150513085636.GA11030@gmail.com> <20150513092421.GB11030@gmail.com>
	 <20150513094622.GC11030@gmail.com> <20150513094756.GD11030@gmail.com>
	 <20150513131835.GJ1517@pd.tnic> <20150513134842.GA1657@gmail.com>
	 <20150513162757.GA21894@x>
	 <20150513150523.ddd65d7cd51f820b78f0c8e3@linux-foundation.org>
	 <20150514101518.GA27550@gmail.com> <20150514103544.GA7027@gmail.com>
	 <20150514123835.1bf436bc35d711f8dbf9bc0f@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150514225728.20-_7yRDqCbwZLmSpTCzy4vQjc6PRJblJ-Q2RWNzlDw@z>

On Thu, 2015-05-14 at 12:38 -0700, Andrew Morton wrote:
> > Add arch support matrices for more than 40 generic kernel features
> > that need per architecture support.
> > 
> > Each feature has its own directory under Documentation/features/feature_name/,
> > and the arch-support.txt file shows its current arch porting status.
> 
> It would be nice to provide people with commit IDs to look at, but the
> IDs won't be known at the time the documentation file is created.  We
> could provide patch titles.

+1 on patch titles.

> But still, let's not overdo it - get something in there, see how well
> it works, evolve it over time.
> 
> I don't think we've heard from any (non-x86) arch maintainers?  Do they
> consider this useful at all?  Poke.

Yes it is. I have my own version I've cobbled together for powerpc, but this is
much better.

I'd like to see more description in the individual files of what the feature
is, and preferably some pointers to what's needed to implement it.

The kconfig for HAVE_ARCH_SECCOMP_FILTER is a good example of what I mean.

I realise retrofitting that for all these existing features is quite time
consuming, but for new features hopefully the bar can be raised a little in
terms of that description.

cheers


