Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755221AbdJJJgz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 05:36:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20171010083948.5s6bmggp3cyqtkrf@hirez.programming.kicks-ass.net>
References: <20171010083948.5s6bmggp3cyqtkrf@hirez.programming.kicks-ass.net> <20171010001951.GA6476@linux.vnet.ibm.com> <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8103.1507628212.1@warthog.procyon.org.uk>
Date: Tue, 10 Oct 2017 10:36:52 +0100
Message-ID: <8104.1507628212@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171010093652.D6zfhNjk9fzlHK8EnDKu0UccXda0s2R6guk5pKgapGc@z>

Peter Zijlstra <peterz@infradead.org> wrote:

> > Now that smp_read_barrier_depends() is implied by READ_ONCE(), adding
> > READ_ONCE() to assoc_array_ptr_to_leaf() and __assoc_array_ptr_to_meta()
> > allows the several smp_read_barrier_depends() calls to be removed from
> > lib/assoc_array.c.  This commit makes this change.
> 
> So arguably this code was broken for not already having READ_ONCE().

No, the code is right; this is the wrong place to use READ_ONCE().  The
callers already call READ_ONCE() or ACCESS_ONCE().

David
