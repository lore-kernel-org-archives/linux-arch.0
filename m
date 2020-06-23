From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 0/14] LKMM updates for v5.9
Date: Mon, 22 Jun 2020 17:51:52 -0700
Message-ID: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731785AbgFWAvx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:51:53 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com

Hello!

This series contains updates to the Linux-kernel memory model:

1.	tools/memory-model: Add recent references.

2.	tools/memory-model: Fix "conflict" definition, courtesy of
	Marco Elver.

3.	Documentation: LKMM: Add litmus test for RCU GP guarantee where
	updater frees object, courtesy of Joel Fernandes.

4.	Documentation: LKMM: Add litmus test for RCU GP guarantee where
	reader stores, courtesy of Joel Fernandes.

5.	MAINTAINERS: Update maintainers for new Documentation/litmus-tests,
	courtesy of Joel Fernandes.

6.	tools/memory-model: Add an exception for limitations on _unless()
	family, courtesy of Boqun Feng.

7.	Documentation/litmus-tests: Introduce atomic directory, courtesy of
	Boqun Feng.

8.	Documentation/litmus-tests/atomic: Add a test for atomic_set()
	courtesy of Boqun Feng.

9.	Documentation/litmus-tests/atomic: Add a test for
	smp_mb__after_atomic(), courtesy of Boqun Feng.

10.	tools/memory-model: Fix reference to litmus test in recipes.txt
	courtesy of Akira Yokosawa.

11.	Documentation/litmus-tests: Merge atomic's README into top-level
	one, courtesy of Akira Yokosawa.

12.	Documentation/litmus-tests: Cite an RCU litmus test, courtesy of
	Joel Fernandes.

13.	tools/memory-model/README: Expand dependency of klitmus7, courtesy
	of Akira Yokosawa.

14.	fix references for DMA*.txt files, courtesy of Mauro Carvalho Chehab.

							Thanx, Paul

------------------------------------------------------------------------

 /Documentation/litmus-tests/atomic/README                                                       |   16 -
 b/Documentation/atomic_t.txt                                                                    |   24 +-
 b/Documentation/litmus-tests/README                                                             |   34 ++++
 b/Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus |   32 +++
 b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus             |   24 ++
 b/Documentation/litmus-tests/atomic/README                                                      |   16 +
 b/Documentation/litmus-tests/rcu/RCU+sync+free.litmus                                           |   42 +++++
 b/Documentation/litmus-tests/rcu/RCU+sync+read.litmus                                           |   37 ++++
 b/Documentation/memory-barriers.txt                                                             |    6 
 b/MAINTAINERS                                                                                   |    2 
 b/tools/memory-model/Documentation/explanation.txt                                              |   83 +++++-----
 b/tools/memory-model/Documentation/recipes.txt                                                  |    2 
 b/tools/memory-model/Documentation/references.txt                                               |   21 ++
 b/tools/memory-model/README                                                                     |   40 ++++
 14 files changed, 302 insertions(+), 77 deletions(-)
