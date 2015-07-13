From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 15:11:43 +0200
Message-ID: <20150713131143.GY19282@twins.programming.kicks-ass.net>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54112 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbGMNLv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 09:11:51 -0400
Content-Disposition: inline
In-Reply-To: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, Jul 13, 2015 at 01:15:04PM +0100, Will Deacon wrote:
> smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> into a full memory barrier.
> 
> However:

>   - The barrier only applies to UNLOCK + LOCK, not general
>     RELEASE + ACQUIRE operations

No it does too; note that on ppc both acquire and release use lwsync and
two lwsyncs do not make a sync.
