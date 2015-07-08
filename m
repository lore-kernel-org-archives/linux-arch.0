From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/9] locking/qrwlock: avoid redundant atomic_add_return
 on read_lock_slowpath
Date: Wed, 8 Jul 2015 14:37:04 +0100
Message-ID: <20150708133704.GE9283@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-3-git-send-email-will.deacon@arm.com>
 <559C11BA.1070309@hp.com>
 <20150707181941.GL23879@arm.com>
 <559C284D.4090907@hp.com>
 <20150708095944.GA3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41130 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011AbbGHNhH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jul 2015 09:37:07 -0400
Content-Disposition: inline
In-Reply-To: <20150708095944.GA3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <waiman.long@hp.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mingo@redhat.com" <mingo@redhat.com>

On Wed, Jul 08, 2015 at 10:59:44AM +0100, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 03:28:13PM -0400, Waiman Long wrote:
> > #ifndef queued_inc_reader_return
> > static inline u32 queued_inc_reader_return(struct qrwlock *lock)
> 
> That's actually a misleading name, we don't do an inc_return, we do a
> fetch_inc.
> 
> > {
> >     return atomic_add_return(_QR_BIAS, &lock->cnts) - _QR_BIAS;
> > }
> > #endif
> 
> With that you (Will) could even reuse the ll/sc load and avoid issuing a
> second load. You basically need atomic_fetch_add_relaxed().

ARMv8.1 has an instruction for that :) [ldadd].

Will
