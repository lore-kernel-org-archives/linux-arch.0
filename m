From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: LKMM patch status
Date: Mon, 18 Mar 2019 10:50:59 -0700
Message-ID: <20190318175059.GA3322@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello!


pick 0172d9e32203 tools/memory-model: Rename some RCU relations
pick 284749b0aebb tools/memory-model: Refactor some RCU relations
pick a3f600d92da5 tools/memory-model: Add SRCU support
pick ad9fd20b6dad tools/memory-model: Update README for addition of SRCU
pick 648e717586f2 tools/memory-model: Update Documentation/explanation.txt to include SRCU support
pick 9393998e9ee0 tools/memory-model: Dynamically check SRCU lock-to-unlock matching
pick 034fb712a620 tools/memory-model: Avoid duplicating herdtools versions

	Ready to go, sent for inclusion in tip, and will presumably show
	up there soon.

	http://lkml.kernel.org/r/20190213173650.GA26078@linux.ibm.com

pick 487ecc460732 sched/Documentation/kokr: Update Korean translation to update wake_up() & co. memory-barrier guarantees
pick db467147f131 locking/memory-barriers/kokr: Update Korean translation to replace smp_cond_acquire() with smp_cond_load_acquire()
pick f1887143f598 Documentation/atomic_t: Clarify signed vs unsigned

	These have the needed acks/reviews, so I will send them as RFC
	patches within the next week or two.

pick ece264389af9 tools/memory-model: Make scripts be executable
pick fd4b7b3c6c0d tools/memory-model: Fix comment in MP+poonceonces.litmus
pick e9cc6e9437e2 tools/memory-model: Do not use "herd" to refer to "herd7"
pick 093e4c7dcf79 docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER EFFECTS" section

	These all need at least one Reviewed-by or Acked-by.

								Thanx, Paul
