From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/21] LKMM updates for review
Date: Tue, 26 Mar 2019 16:41:14 -0700
Message-ID: <20190326234114.GA23843@linux.ibm.com>
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

This series contains LKMM updates:

1.	Make scripts be executable.

2.	Fix comment in MP+poonceonces.litmus, courtesy of Andrea Parri.

3.	Do not use "herd" to refer to "herd7", courtesy of Andrea Parri.

4.	Rewrite "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt,
	courtesy of Will Deacon.

5-6.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

7.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

8.	Add support for synchronize_srcu_expedited().

9.	Make LKMM scripts detect unconditional deadlocks.

10-21.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models
	for checkalllitmus.sh.  This is a work in progress.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                     |  115 +++++++++------
 tools/memory-model/linux-kernel.def                   |    1 
 tools/memory-model/litmus-tests/.gitignore            |    4 
 tools/memory-model/litmus-tests/MP+poonceonces.litmus |    2 
 tools/memory-model/litmus-tests/README                |    2 
 tools/memory-model/lock.cat                           |    2 
 tools/memory-model/scripts/README                     |   12 -
 tools/memory-model/scripts/checkalllitmus.sh          |   29 +--
 tools/memory-model/scripts/checklitmus.sh             |  101 +++++--------
 tools/memory-model/scripts/cmplitmushist.sh           |   53 ++++++
 tools/memory-model/scripts/judgelitmus.sh             |  114 +++++++++++---
 tools/memory-model/scripts/parseargs.sh               |   11 +
 tools/memory-model/scripts/runlitmus.sh               |  137 ++++++++++++++----
 tools/memory-model/scripts/runlitmushist.sh           |    3 
 tools/memory-model/scripts/simpletest.sh              |   35 ++++
 15 files changed, 425 insertions(+), 196 deletions(-)
