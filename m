From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/9] locking/qrwlock: avoid redundant atomic_add_return
 on read_lock_slowpath
Date: Tue, 7 Jul 2015 23:30:01 +0200
Message-ID: <20150707213000.GL19282@twins.programming.kicks-ass.net>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-3-git-send-email-will.deacon@arm.com>
 <559C11BA.1070309@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52728 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933512AbbGGVaI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 17:30:08 -0400
Content-Disposition: inline
In-Reply-To: <559C11BA.1070309@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mingo@redhat.com

On Tue, Jul 07, 2015 at 01:51:54PM -0400, Waiman Long wrote:
> >-	cnts = atomic_add_return(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> >+	atomic_add(_QR_BIAS,&lock->cnts);
> >+	cnts = smp_load_acquire((u32 *)&lock->cnts);
> >  	rspin_until_writer_unlock(lock, cnts);
> >
> >  	/*
> 
> Atomic add in x86 is actually a full barrier too. The performance difference
> between "lock add" and "lock xadd" should be minor. The additional load,
> however, could potentially cause an additional cacheline load on a contended
> lock. So do you see actual performance benefit of this change in ARM?

Yes, atomic_add() does not imply (and does not have) any memory barriers
on ARM.
