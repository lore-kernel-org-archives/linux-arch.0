From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Q&A from "Concurrency with tools/memory-model"
Date: Thu, 15 Nov 2018 14:56:30 -0800
Message-ID: <20181115225630.GA30917@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello!

Good turnout and some good questions here in Vancouver BC, please see
below for rough notes.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

"Concurrency with tools/memory-model"

Andrea Parri presenting.

Rough notes of Q&A.

o	Want atomic bit operation.

o	But smp_read_barrier_depends() not there, so how to note pairing?
	A:  Note the dependency as the other end of the pairing.

o	Speculation barriers, as in Spectre and Meltdown?  A: This would
	require adding timing, not in the immediate future.

o	What ordering does system calls provide?  A: None that we know of.
	Boqun: Userspace needs to explicitly provide the needed ordering
	when interacting with the kernel.  Some architectures do provide
	full barriers, but not to be counted on.

o	Why herd7?  A: Based on other formalizations -- note that herd7
	had a number of hardware models.  Paul: Plus the founder of the
	LKMM project is a co-author of herd, which might have had some
	effect.

o	Why not also model interrupts and NMIs?  Promela and spin have
	been used for this.  A: Cannot currently model them.  You can
	emulated them with additional threads and locks, if you wish.
	Vincent Nimal and Lihao Liang have done some academic work on
	these topics.
