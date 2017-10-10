Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754461AbdJJIkG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Oct 2017 04:40:06 -0400
Date: Tue, 10 Oct 2017 10:39:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Message-ID: <20171010083948.5s6bmggp3cyqtkrf@hirez.programming.kicks-ass.net>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171010083948.f5StoG8Y22r7FXY10rNLhf8J3fbbLqMjn51Z3YpPd2A@z>

On Mon, Oct 09, 2017 at 05:22:46PM -0700, Paul E. McKenney wrote:
> Now that smp_read_barrier_depends() is implied by READ_ONCE(), adding
> READ_ONCE() to assoc_array_ptr_to_leaf() and __assoc_array_ptr_to_meta()
> allows the several smp_read_barrier_depends() calls to be removed from
> lib/assoc_array.c.  This commit makes this change.

So arguably this code was broken for not already having READ_ONCE().
