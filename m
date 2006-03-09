Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbWCIB1V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2006 20:27:21 -0500
Date: Wed, 8 Mar 2006 17:27:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <17423.32792.500628.226831@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
 <20060308184500.GA17716@devserv.devel.redhat.com>
 <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com>
 <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com>
 <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com>
 <14275.1141844922@warthog.cambridge.redhat.com> <19984.1141846302@warthog.cambridge.redhat.com>
 <17423.30789.214209.462657@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081652430.32577@g5.osdl.org>
 <17423.32792.500628.226831@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>



On Thu, 9 Mar 2006, Paul Mackerras wrote:
> 
> ... and x86 mmiowb is a no-op.  It's not x86 that I think is buggy.

x86 mmiowb would have to be a real op too if there were any multi-pathed 
PCI buses out there for x86, methinks.

Basically, the issue boils down to one thing: no "normal" barrier will 
_ever_ show up on the bus on x86 (ie ia64, afaik). That, together with any 
situation where there are multiple paths to one physical device means that 
mmiowb() _has_ to be a special op, and no spinlocks etc will _ever_ do the 
serialization you look for.

Put another way: the only way to avoid mmiowb() being special is either 
one of:
 (a) have the bus fabric itself be synchronizing
 (b) pay a huge expense on the much more critical _regular_ barriers

Now, I claim that (b) is just broken. I'd rather take the hit when I need 
to, than every time. 

Now, (a) is trivial for small cases, but scales badly unless you do some 
fancy footwork. I suspect you could do some scalable multi-pathable 
version with using similar approaches to resolving device conflicts as the 
cache coherency protocol does (or by having a token-passing thing), but it 
seems SGI's solution was fairly well thought out. 

That said, when I heard of the NUMA IO issues on the SGI platform, I was 
initially pretty horrified. It seems to have worked out ok, and as long as 
we're talking about machines where you can concentrate on validating just 
a few drivers, it seems to be a good tradeoff.

Would I want the hard-to-think-about IO ordering on a regular desktop 
platform? No.

			Linus
