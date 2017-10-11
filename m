From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 17:07:05 +0100
Message-ID: <7484.1507738025@warthog.procyon.org.uk>
References: <20171011155948.GE3521@linux.vnet.ibm.com> <20171011122217.GD11106@arm.com> <20171010155042.GD3521@linux.vnet.ibm.com> <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com> <20171010001951.GA6476@linux.vnet.ibm.com> <8079.1507628146@warthog.procyon.org.uk> <26455.1507724399@warthog.procyon.org.uk> <6309.1507735045@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011155948.GE3521@linux.vnet.ibm.com>
Content-ID: <7483.1507738025.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com
List-Id: linux-arch.vger.kernel.org

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
