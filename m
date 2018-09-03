From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Mon, 3 Sep 2018 18:05:50 +0100
Message-ID: <20180903170550.GM6954@arm.com>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
 <20180831160640.GG30626@arm.com>
 <20180831182845.GA4673@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831182845.GA4673@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 31, 2018 at 08:28:46PM +0200, Andrea Parri wrote:
> > > Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> > > should be correct on all existing architectures.  And Paul has invited 
> > > a patch to modify the LKMM accordingly.  If you feel that such a change 
> > > would be a useful enhancement to the LKMM's applicability, please write 
> > > it.
> > 
> > Yes, please! That would be the "RmW" discussion which Andrea partially
> > quoted earlier on, so getting that going independently from this patch
> > sounds like a great idea to me.
> 
> That was indeed one of the proposal we discussed.  As you recalled, that
> proposal only covered RmWs load-acquire (and ordinary store-release); in
> particular, I realized that comments such as:
> 
>   "The atomic_cond_read_acquire() call above has provided the
>    necessary acquire semantics required for locking."
> 
>    [from kernel/locking/qspinlock.c]
> 
> (for example)  would still _not have "generic validity" _if we added the
> above po-unlock-rf-lock-po term... (which, again, makes me somehow uncon-
> fortable);  Would to have _all_ the acquire be admissible for you?

I think you've missed some words here, but if you're asking if I'd be
ok strengthening all acquire operations, then the answer is no. See the
huge amount of previous discussion.

Will
