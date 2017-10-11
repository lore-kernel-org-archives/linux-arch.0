From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RFC tip/core/rcu 0/15] Remove to-be-unneeded smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 13:21:03 +0100
Message-ID: <26479.1507724463@warthog.procyon.org.uk>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdJKMVI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 08:21:08 -0400
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Content-ID: <26478.1507724463.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, tj@kernel.org, cl@linux.com, davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org, corbet@lwn.net, james.l.morris@oracle.com, torvalds@linux-foundation.org

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Will Deacon has proposed adding smp_read_barrier_depends() to READ_ONCE(),
> which would mean that quite a few instances of smp_read_barrier_depends()
> would become redundant.

It's not clear from you description where the barrier is added in relation to
the read: before, after or both?

David
