From: Ingo Molnar <mingo@elte.hu>
Subject: Re: LMB bits
Date: Fri, 9 Jul 2010 09:24:08 +0200
Message-ID: <20100709072408.GD10743@elte.hu>
References: <1278031351-23223-1-git-send-email-yinghai@kernel.org>
 <1278659480.28659.149.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:48498 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab0GIHYV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Jul 2010 03:24:21 -0400
Content-Disposition: inline
In-Reply-To: <1278659480.28659.149.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> So I've pushed the memblocks rename and the modified version of my patches 
> that Yinghai produced in the "memblock" branch of the powerpc.git tree, 
> based on top of current Linus tree.

I guess that means this URI:

 git pull git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git memblock

right?

> I've left out all the other patches for x86.
> 
> I did some compile tests and all my test configs on powerpc pass. I won't 
> have time to do in depth runtime tests but I will eventually get to it.
> 
> Now we really need the other archs affected by my LMB rework to test that I 
> haven't broken things for them :-)
> 
> I'm especially worried with things like sparc NUMA bits. I think I got it 
> right but I couldn't test.
> 
> So those patches aren't yet candidate for next, though they will be with a 
> tad more testing.

Thanks Ben.

Dave, can you confirm that it works fine on Sparc? If it does then i'd like to 
pull your tree and use it as a base from that point on. I can push it to 
linux-next as well and treat it together with Yinghai's x86 changes. Would 
that be fine with you, or would you like to push it to Linus?

Also, after some testing we could send the tree cut at this point:

  506e7de: lmb: rename to memblock

to Linus straight away - to get the big rename out of the way:

 74 files changed, 1039 insertions(+), 1039 deletions(-)

Hm?

	Ingo
