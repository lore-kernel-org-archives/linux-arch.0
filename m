Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECPTT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 11:19:19 -0400
Date: Fri, 3 May 2019 17:19:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: f68f031d ("Documentation: atomic_t.txt: Explain ordering
 provided by smp_mb__{before,after}_atomic()")
Message-ID: <20190503151915.GD2606@hirez.programming.kicks-ass.net>
References: <20190503145326.GA21541@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503145326.GA21541@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190503151915.SYB_Fr_7J4EUKGHCA8r7defK1OGEvN-xLe62DGTH7Hs@z>

On Fri, May 03, 2019 at 07:53:26AM -0700, Paul E. McKenney wrote:
> Hello, Alan,
> 
> Just following up on the -rcu commit below.  I believe that it needs
> some adjustment given Peter Zijlstra's addition of "memory" to the x86
> non-value-returning atomics, but thought I should double-check.

Right; I should get back to that thread...
