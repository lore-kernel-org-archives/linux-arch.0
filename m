Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbdI1IiL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2017 04:38:11 -0400
Date: Thu, 28 Sep 2017 10:38:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Use READ_ONCE/WRITE_ONCE when
 accessing page tables
Message-ID: <20170928083801.m6rb4frbbgzgam2o@hirez.programming.kicks-ass.net>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
 <1506527369-19535-2-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506527369-19535-2-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com
Message-ID: <20170928083801.ya0udh3DT6ooqhsUCJnSHWay1OY21cMNeVcsVU7w8EY@z>

On Wed, Sep 27, 2017 at 04:49:28PM +0100, Will Deacon wrote:
> In many cases, page tables can be accessed concurrently by either another
> CPU (due to things like fast gup) or by the hardware page table walker
> itself, which may set access/dirty bits. In such cases, it is important
> to use READ_ONCE/WRITE_ONCE when accessing page table entries so that
> entries cannot be torn, merged or subject to apparent loss of coherence.

In fact, we should use lockless_dereference() for many of them. Yes
Alpha is the only one that cares about the difference between that and
READ_ONCE() and they do have the extra barrier, but if we're going to do
this, we might as well do it 'right' :-)

Also, a very long standing item on my TODO list is to see how much of it
we can unify across the various architectures, because there's a giant
amount of boiler plate involved with all this.
