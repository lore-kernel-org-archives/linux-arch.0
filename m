From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Thu, 6 Feb 2014 10:42:41 -0800
Message-ID: <20140206184241.GF4250@linux.vnet.ibm.com>
References: <20140206134825.305510953@infradead.org>
 <21984.1391711149@warthog.procyon.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21984.1391711149@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, ramana.radhakrishnan@arm.com
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 06, 2014 at 06:25:49PM +0000, David Howells wrote:
> 
> Is it worth considering a move towards using C11 atomics and barriers and
> compiler intrinsics inside the kernel?  The compiler _ought_ to be able to do
> these.

Makes sense to me!

> One thing I'm not sure of, though, is how well gcc's atomics will cope with
> interrupt handlers touching atomics on CPUs without suitable atomic
> instructions - that said, userspace does have to deal with signals getting
> underfoot. but then userspace can't normally disable interrupts.

Perhaps make the C11 definitions so that any arch can override any
specific definition?

							Thanx, Paul
