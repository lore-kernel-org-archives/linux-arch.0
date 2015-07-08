From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/9] locking/qrwlock: avoid redundant atomic_add_return
 on read_lock_slowpath
Date: Wed, 8 Jul 2015 11:59:44 +0200
Message-ID: <20150708095944.GA3644@twins.programming.kicks-ass.net>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-3-git-send-email-will.deacon@arm.com>
 <559C11BA.1070309@hp.com>
 <20150707181941.GL23879@arm.com>
 <559C284D.4090907@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49646 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946AbbGHJ7v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2015 05:59:51 -0400
Content-Disposition: inline
In-Reply-To: <559C284D.4090907@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mingo@redhat.com" <mingo@redhat.com>

On Tue, Jul 07, 2015 at 03:28:13PM -0400, Waiman Long wrote:
> #ifndef queued_inc_reader_return
> static inline u32 queued_inc_reader_return(struct qrwlock *lock)

That's actually a misleading name, we don't do an inc_return, we do a
fetch_inc.

> {
>     return atomic_add_return(_QR_BIAS, &lock->cnts) - _QR_BIAS;
> }
> #endif

With that you (Will) could even reuse the ll/sc load and avoid issuing a
second load. You basically need atomic_fetch_add_relaxed().
