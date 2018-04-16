From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 0/17] Memory-model changes
Date: Mon, 16 Apr 2018 09:12:09 -0700
Message-ID: <20180416161209.GA6895@linux.vnet.ibm.com>
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

This series contains changes to the memory model, including the formal
model in tools/memory-model and documentation in memory-barriers.txt (plus
the Korean translation).  These changes are ready for inclusion in -tip.

1.	Rename LKMM's "link" and "rcu-path" relations to "rcu-link"
	and "rb", respectively, courtesy of Alan Stern.

2.	Redefine LKMM's "rb" relation in terms of rcu-fence in order
	to match the structure of LKMM's other strong fences, courtesy
	of Alan Stern.

3.	Fix memory-barriers.txt's ordering example contrasting DMA to
	MMIO, courtesy of Will Deacon.

4-6.	Fixes related to spin_is_locked(), courtesy of Andrea Parri.

7-11.	Updates to Korean translation of memory-barriers.txt, courtesy
	of SeongJae Park.

12.	Update required version of the herd7 tool, courtesy of Akira
	Yokosawa.

13.	Fix "RWM" typo in cheatsheet.txt, courtesy of Paolo Bonzini.

14.	Improve cheatsheet.txt's key.

15.	Fix cheatsheet.txt's ordering rules for smp_mb__after_atomic().

16.	Add smp_store_mb() to LKMM, courtesy of Andrea Parri.

17.	Use consistent coding style in linux-kernel.def, courtesy of
	Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                    |   17 -
 Documentation/translations/ko_KR/memory-barriers.txt |   56 ++--
 arch/arm64/include/asm/spinlock.h                    |    5 
 include/asm-generic/qspinlock.h                      |    2 
 include/linux/mutex.h                                |    3 
 include/linux/spinlock.h                             |   18 +
 tools/memory-model/Documentation/cheatsheet.txt      |    7 
 tools/memory-model/Documentation/explanation.txt     |  261 +++++++++++--------
 tools/memory-model/README                            |    2 
 tools/memory-model/linux-kernel.cat                  |   49 ++-
 tools/memory-model/linux-kernel.def                  |   29 +-
 11 files changed, 268 insertions(+), 181 deletions(-)
