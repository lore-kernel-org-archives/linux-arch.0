From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 16:28:24 +0100
Message-ID: <6544.1507735704@warthog.procyon.org.uk>
References: <20171011125857.GY3521@linux.vnet.ibm.com> <20171010155042.GD3521@linux.vnet.ibm.com> <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com> <20171010001951.GA6476@linux.vnet.ibm.com> <8079.1507628146@warthog.procyon.org.uk> <26455.1507724399@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011125857.GY3521@linux.vnet.ibm.com>
Content-ID: <6543.1507735704.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-arch.vger.kernel.org

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
