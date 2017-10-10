Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54736 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932385AbdJJPzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Oct 2017 11:55:02 -0400
Date: Tue, 10 Oct 2017 17:54:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Message-ID: <20171010155451.wv2dfirmra5aeake@hirez.programming.kicks-ass.net>
References: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <20171010155042.GD3521@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010155042.GD3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171010155451.1DCs3M_kXTa6wbuTEEGf-7xv0fbSugye0OpziVV-RNE@z>

On Tue, Oct 10, 2017 at 08:50:42AM -0700, Paul E. McKenney wrote:
> +			/* We need a barrier between the read of the pointer,
> +			 * which is supplied by the above READ_ONCE().
>  			 */

>  			/* We need a barrier between the read of the pointer
>  			 * and dereferencing the pointer - but only if we are
>  			 * actually going to dereference it.
>  			 */

Could you also fix those "disgusting drug-induced crap" comment styles
while you're there anyway?

  http://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html
