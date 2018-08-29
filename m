From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC memory-model 0/7] Memory-model changes
Date: Wed, 29 Aug 2018 14:10:18 -0700
Message-ID: <20180829211018.GA19646@linux.vnet.ibm.com>
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

This series contains memory-model updates, not yet ready for inclusion:

1.	Add extra ordering for locks and remove it for ordinary
	release/acquire, courtesy of Alan Stern.  There is some
	remaining disagreement as to whether or not locks and ordinary
	release/acquire should have identical ordering properties.

2.	Replace smp_cond_acquire() with smp_cond_load_acquire(),
	courtesy of Andrea Parri.

3.	Expand the list of LKMM limitations.

4.	Fix a README typo, courtesy of SeongJae Park.

5.	Add scripts to check github litmus tests.

6.	Make scripts take "-j" abbreviation for "--jobs".

7.	Add .cfg and .cat files for s390, which is a not-for-mainline
	placeholder.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                                          |    3 
 tools/memory-model/.gitignore                                              |    1 
 tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
 tools/memory-model/Documentation/recipes.txt                               |    2 
 tools/memory-model/README                                                  |   41 ++
 tools/memory-model/linux-kernel.cat                                        |    8 
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    7 
 tools/memory-model/s390.cat                                                |   18 
 tools/memory-model/s390.cfg                                                |   21 +
 tools/memory-model/scripts/README                                          |   70 +++
 tools/memory-model/scripts/checkalllitmus.sh                               |   53 +-
 tools/memory-model/scripts/checkghlitmus.sh                                |   65 +++
 tools/memory-model/scripts/checklitmus.sh                                  |   74 ---
 tools/memory-model/scripts/checklitmushist.sh                              |   60 +++
 tools/memory-model/scripts/cmplitmushist.sh                                |   87 ++++
 tools/memory-model/scripts/initlitmushist.sh                               |   68 +++
 tools/memory-model/scripts/judgelitmus.sh                                  |   78 ++++
 tools/memory-model/scripts/newlitmushist.sh                                |   61 +++
 tools/memory-model/scripts/parseargs.sh                                    |  140 +++++++
 tools/memory-model/scripts/runlitmushist.sh                                |   87 ++++
 20 files changed, 981 insertions(+), 149 deletions(-)
