Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [RFC] unify semaphore implementations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <17010.58144.95239.716600@cargo.ozlabs.ibm.com>
References: <20050428182926.GC16545@kvack.org>
	 <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	 <20050429141437.GA24617@kvack.org>
	 <1114789320.10086.81.camel@lade.trondhjem.org>
	 <17010.58144.95239.716600@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 30 Apr 2005 12:40:29 -0400
Message-Id: <1114879229.14213.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On lau , 2005-04-30 at 11:45 +1000, Paul Mackerras wrote:

> What is "your machine"?  Is a single cmpxchg really slower than
> locking and unlocking a spinlock?  If so, by how much?

Sorry. Thinking back, I realize that I was testing the non-irqsafe
spinlocks, since that was the only case that was of interest for the
iosem stuff. I should go back and test for the case of irqsafe ones.

FYI, though, the machine on which I tested it is a mobile P4. When
averaging over 1000 iterations, a single bus-locked cmpxchg took more
than twice the amount of time to complete than a single bus-locked incb
or decb (as used in the 386 spinlock implementations).
The spinlocked version was therefore not much faster for the fast path,
but for the slow path you do only a single spin_lock/spin_unlock
combination instead of cmpxchg+spinlock/spinunlock. It is therefore
twice as fast.

Cheers,
  Trond
