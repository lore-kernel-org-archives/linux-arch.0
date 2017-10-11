Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752250AbdJKQHJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 12:07:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20171011155948.GE3521@linux.vnet.ibm.com>
References: <20171011155948.GE3521@linux.vnet.ibm.com> <20171011122217.GD11106@arm.com> <20171010155042.GD3521@linux.vnet.ibm.com> <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com> <20171010001951.GA6476@linux.vnet.ibm.com> <8079.1507628146@warthog.procyon.org.uk> <26455.1507724399@warthog.procyon.org.uk> <6309.1507735045@warthog.procyon.org.uk>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7483.1507738025.1@warthog.procyon.org.uk>
Date: Wed, 11 Oct 2017 17:07:05 +0100
Message-ID: <7484.1507738025@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com
Message-ID: <20171011160705.Xtm3U5ht5kXDT0vEqoEZONF8u6QkudQFgy4do7Dy8bo@z>

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> It does not.  In most cases, the barriered version would be
> smp_store_release().

Ummm... Is that good enough?  Is:

	WRITE_ONCE(x, 1);
	WRITE_ONCE(x, 2);

equivalent to:

	smp_store_release(x, 1);
	smp_store_release(x, 2);

if CONFIG_SMP=n?

(Consider what happens if an interrupt messes with x).

If it is good enough, should we be using smp_load_acquire() rather than
READ_ONCE()?

David
