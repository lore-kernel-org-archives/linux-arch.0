Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37117 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756602AbYD0Rdg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Apr 2008 13:33:36 -0400
Date: Sun, 27 Apr 2008 10:32:28 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
In-Reply-To: <20080427172235.GA2252@cs181133002.pp.htv.fi>
Message-ID: <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
Message-ID: <20080427173228.qAnojMChrDPivdj3-zNE7dYz_mW46slPpY0aDASeZrI@z>



On Sun, 27 Apr 2008, Adrian Bunk wrote:
> 
> I'm looking at it from a different angle, all code in the kernel should 
> follow the following rules [1]:
> - no functions in .c files should be marked inline
> - all functions in headers should be static inline
> - all functions in headers should either be very small or collapse
>   to become very small after inlining
> 
> I can simply not see any usecase for a non-forced inline in the kernel,
> and fixing the kernel should give a superset of the space savings of 
> this "inline optimization".

Your whole argument is premised on the assumption that the compiler does 
the right thing.

That's a *known*to*be*bogus* assumption.

Modern versions of gcc may do the right thing. Note the two very important 
code-words: "modern" and "may".

I'm just telling you that

 - older versions of gcc (and by "older" I do not mean "really ancient" or 
   "deprecated", but stuff that is still in use) are known to be total and 
   utter crap when it comes to inlining

 - even absent that, there are historical reasons stemming from even more 
   ancient versions of gcc that are no longer in use.

In other words, my arguments have nothing to do with "I wish". They are 
plain facts. Why argue with them?

			Linus
