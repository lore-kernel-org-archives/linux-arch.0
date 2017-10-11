Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbdJKP21 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 11:28:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20171011125857.GY3521@linux.vnet.ibm.com>
References: <20171011125857.GY3521@linux.vnet.ibm.com> <20171010155042.GD3521@linux.vnet.ibm.com> <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com> <20171010001951.GA6476@linux.vnet.ibm.com> <8079.1507628146@warthog.procyon.org.uk> <26455.1507724399@warthog.procyon.org.uk>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6543.1507735704.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Wed, 11 Oct 2017 16:28:24 +0100
Message-ID: <6544.1507735704@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171011152824.RMH8ObZ8mW9sC3Bgw63XyXSW98lPEzr2oqkdFu18fgQ@z>

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Placing the comment on the same line makes it less likely that some
> later change will move the comment away from the load that it applies to.

The problem with your 'address dep' comment is that it's not particularly
useful.

Either your comment needs to say "dep between X and Y", but if the following is
always the dep:

	Y = READ_ONCE(X)
	access(*Y)

then the comment is superfluous.

If it's not always true then your comment needs to indicate what the dependency
is.

The other thing your comment could/should say is where the other barrier is -
barriers always have to be paired as a general rule.  (I know I haven't put
these comments in here - but I've been doing that recently).

David
