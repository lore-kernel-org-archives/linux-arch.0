From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/13] mm: preemptibility -v2
Date: Thu, 08 Apr 2010 22:35:07 +0200
Message-ID: <1270758907.20295.3077.camel@laptop>
References: <20100408191737.296180458@chello.nl>
	 <20100408.132935.202349434.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37965 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253Ab0DHUfM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 16:35:12 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1NzyRT-0007yS-2N
	for linux-arch@vger.kernel.org; Thu, 08 Apr 2010 20:35:11 +0000
In-Reply-To: <20100408.132935.202349434.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: aarcange@redhat.com, avi@redhat.com, tglx@linutronix.de, riel@redhat.com, mingo@elte.hu, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, benh@kernel.crashing.org, hugh.dickins@tiscali.co.uk, mel@csn.ul.ie, npiggin@suse.de

On Thu, 2010-04-08 at 13:29 -0700, David Miller wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date: Thu, 08 Apr 2010 21:17:37 +0200
> 
> > This patch-set seems to build and boot on my x86_64 machines and even builds a
> > kernel. I've also attempted powerpc and sparc, which I've compile tested with
> > their respective defconfigs, remaining are (afaikt the rest uses the generic
> > tlb bits):
> 
> Did a build and test boot of this on my 128-cpu Niagara2 box, seems to
> work basically fine.

Wheee, thanks Dave!
