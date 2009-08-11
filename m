From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch 0/4] Allow inlined spinlocks again V2
Date: Tue, 11 Aug 2009 15:00:49 +0200
Message-ID: <1249995649.10001.6.camel@twins>
References: <20090811124756.873490673@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viefep12-int.chello.at ([62.179.121.32]:22425 "EHLO
	viefep12-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbZHKNBO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2009 09:01:14 -0400
In-Reply-To: <20090811124756.873490673@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, David Miller <davem@davemloft.net>

On Tue, 2009-08-11 at 14:47 +0200, Heiko Carstens wrote:
> This patch set allows to have inlined spinlocks again.
> 
> V2: rewritten from scratch - now with readable code
> 
> The rationale behind this is that function calls on at least s390 are
> expensive.
> 
> If one considers that server kernels are usually compiled with
> !CONFIG_PREEMPT a simple spin_lock is just a compare and swap loop.
> The extra overhead for a function call is significant.
> With inlined spinlocks overall cpu usage gets reduced by 1%-5% on s390.
> These numbers were taken with some network benchmarks. However I expect
> any workload that calls frequently into the kernel and which grabs a few
> locks to perform better.
> 
> The implementation is straight forward: move the function bodies of the
> locking functions to static inline functions and place them in a header
> file.
> Dependent on CONFIG_SPINLOCK_INLINE generate out-of-line or inlined
> locking functions.
> 
> The patches should be self explaining.

These look lots better than the previous series ;-)

Given that you've got a significant performance gain from this and it
doesn't look too horrible anymore,

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

IIRC sparc64 also has a funny calling convention, so it might be of
interest to DaveM as well.
