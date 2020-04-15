From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 0/10] LKMM updates for v5.8
Date: Wed, 15 Apr 2020 11:49:19 -0700
Message-ID: <20200415184918.GA16301@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello!

This series contains LKMM updates:

1.	Add recent references.

2.	Fix "conflict" definition, courtesy of Marco Elver.

3.	Move MP+onceassign+derefonce to new litmus-tests/rcu/, courtesy
	of Joel Fernandes.

4.	Add litmus test for RCU GP guarantee where updater frees object,
	courtesy of Joel Fernandes.

5.	Add litmus test for RCU GP guarantee where reader stores, courtesy
	of Joel Fernandes.

6.	Update maintainers for new Documentaion/litmus-tests/, courtesy of
	Joel Fernandes.

7.	Add an exception for limitations on _unless() family, courtesy of
	Boqun Feng.

8.	Introduce an atomic directory in Documentation, courtesy of Boqun
	Feng.

9.	Add a test for atomic_set(), courtesy of Boqun Feng.

10.	Add a test for smp_mb__after_atomic(), courtesy of Boqun Feng.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/atomic_t.txt                                                                    |   24 +-
 Documentation/litmus-tests/README                                                             |   14 +
 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus |   32 +++
 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus             |   24 ++
 Documentation/litmus-tests/atomic/README                                                      |   16 +
 Documentation/litmus-tests/rcu/RCU+sync+free.litmus                                           |   42 +++++
 Documentation/litmus-tests/rcu/RCU+sync+read.litmus                                           |   37 ++++
 MAINTAINERS                                                                                   |    2 
 tools/memory-model/Documentation/explanation.txt                                              |   83 +++++-----
 tools/memory-model/Documentation/references.txt                                               |   21 ++
 tools/memory-model/README                                                                     |   10 -
 tools/memory-model/litmus-tests/README                                                        |    3 
 12 files changed, 250 insertions(+), 58 deletions(-)
