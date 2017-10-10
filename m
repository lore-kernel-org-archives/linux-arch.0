Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:52044 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbdJJPuC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Oct 2017 11:50:02 -0400
Date: Tue, 10 Oct 2017 08:49:58 -0700
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC tip/core/rcu 05/15] percpu: READ_ONCE() now implies
 smp_read_barrier_depends()
Message-ID: <20171010154958.GM3301751@devbig577.frc2.facebook.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <1507594969-8347-5-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010140813.GK3301751@devbig577.frc2.facebook.com>
 <20171010153047.GB3521@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010153047.GB3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Christoph Lameter <cl@linux.com>
Message-ID: <20171010154958.y3gVHaRuBfO8VBPzkt6UskD46FjBxgqqE45qo34eSC4@z>

On Tue, Oct 10, 2017 at 08:30:47AM -0700, Paul E. McKenney wrote:
> > Please feel free to route with other patches.  If this should be
> > routed through the percpu tree, please let me know.
> 
> This depends on some other not-yet-finalized patch series, so if you
> are OK with it, I will route them with that group of serieses.

Sure thing.  Thanks for the much needed simplification!

-- 
tejun
