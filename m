From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 0/3] Kernel fixes to spin_is_locked()
Date: Mon, 14 May 2018 16:01:05 -0700
Message-ID: <20180514230105.GA6421@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello!

This series contains fixes to the kernel related to the semantics
of spin_is_locked(), all courtesy of Andrea Parri, and all ready for
inclusion in -tip:

1.	Document the semantics of spin_is_locked() by adding a docbook
	header comment.

2.	Remove smp_mb() from arch_spin_is_locked(), given that the
	new order-free spin_is_locked() semantics require no such barrier.

3.	Clean up comment and #ifndef for {,queued_}spin_is_locked().
	The comment was "XXX think about spin_is_locked", and I can
	attest that we have now done some serious thinking.  ;-)

							Thanx, Paul

------------------------------------------------------------------------
