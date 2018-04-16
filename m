From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model 0/5] Additional proposed changes to
 LKMM
Date: Mon, 16 Apr 2018 09:22:28 -0700
Message-ID: <20180416162228.GA18167@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello!

This series contains a few additional changes to tools/memory-model,
however, the members of this series need more discussion and feedback
before they are ready for inclusion.

1.	Add LKMM test scripts.

2.	Add litmus test for full-up multicopy atomicity.

3.	Add experimental .cfg and .cat files for s390.  These are for
	expository purposes only, and would more likely be included in
	the herd tool than in the Linux kernel.

4.	Add LKMM support for spin_is_locked(), courtesy of Luc Maranget.
	It has been suggested that spin_is_locked() be removed from the
	kernel, but in the meantime we should at least have a definition
	of what it does.

5.	Flag litmus test demonstrating the A-cumulativity of
	smp_store_release() and LKMM's propagation rule.

							Thanx, Paul

------------------------------------------------------------------------

 linux-kernel.def                                       |    1 
 litmus-tests/.gitignore                                |    1 
 litmus-tests/IRIW+mbonceonces+OnceOnce.litmus          |    2 
 litmus-tests/MP+polockmbonce+poacquiresilsil.litmus    |   30 +++++
 litmus-tests/MP+polockonce+poacquiresilsil.litmus      |   29 +++++
 litmus-tests/README                                    |   19 +++
 litmus-tests/SB+poonceoncescoh.litmus                  |   31 ++++++
 litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus |    4 
 lock.cat                                               |   53 +++++++++-
 s390.cat                                               |   18 +++
 s390.cfg                                               |   21 ++++
 scripts/checkalllitmus.sh                              |   73 ++++++++++++++
 scripts/checklitmus.sh                                 |   86 +++++++++++++++++
 13 files changed, 359 insertions(+), 9 deletions(-)
