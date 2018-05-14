From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 0/19] Updates to the formal memory model
Date: Mon, 14 May 2018 16:33:28 -0700
Message-ID: <20180514233328.GA7601@linux.vnet.ibm.com>
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

This series contains updates to the Linux kernel's formal memory model in
tools/memory-model.  These are ready for inclusion into -tip.

1.	Rename LKMM's "link" and "rcu-path" relations to "rcu-link"
	and "rb", respectively, courtesy of Alan Stern.

2.	Redefine LKMM's "rb" relation in terms of rcu-fence in order
	to match the structure of LKMM's other strong fences, courtesy
	of Alan Stern.

3.	Update required version of herdtools7, courtesy of Akira Yokosawa.

4.	 Fix cheat sheet typo: "RWM" should be "RMW", courtesy of Paolo Bonzini.

5.	Improve cheatsheet.txt key for SELF and SV.

6.	Fix cheatsheet.txt to note that smp_mb__after_atomic() orders
	later RMW operations.

7.	Model smp_store_mb(), courtesy of Andrea Parri.

8.	Fix coding style in 'linux-kernel.def', courtesy of Andrea Parri.

9.	Add scripts to test the memory model.

10.	Add model support for spin_is_locked(), courtesy of Luc Maranget.

11.	Flag the tests that exercise "cumulativity" and "propagation".

12.	Remove duplicated code from lock.cat, courtesy of Alan Stern.

13.	Improve comments in lock.cat, courtesy of Alan Stern.

14.	Improve mixed-access checking in lock.cat, courtesy of Alan Stern.

15.	Remove out-of-date comments and code from lock.cat, which have
	been obsoleted by the settled-upon spin_is_locked() semantics,
	courtesy of Alan Stern.

16.	Fix coding style in 'lock.cat', bringing the indentation to
	Linux-kernel standard, courtesy of Andrea Parri.

17.	Update Andrea Parri's email address in the MAINTAINERS file,
	oddly enough courtesy of Andrea Parri.  ;-)

18.	Update ASPLOS information now that ASPLOS has come and gone,
	courtesy of Andrea Parri.

19.	Add reference for 'Simplifying ARM concurrency', courtesy
	of Andrea Parri.

								Thanx, Paul

------------------------------------------------------------------------

 MAINTAINERS                                                               |    2 
 tools/memory-model/Documentation/cheatsheet.txt                           |    7 
 tools/memory-model/Documentation/explanation.txt                          |  261 +++++-----
 tools/memory-model/Documentation/references.txt                           |   17 
 tools/memory-model/README                                                 |    2 
 tools/memory-model/linux-kernel.bell                                      |    4 
 tools/memory-model/linux-kernel.cat                                       |   53 +-
 tools/memory-model/linux-kernel.def                                       |   34 -
 tools/memory-model/litmus-tests/.gitignore                                |    1 
 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus          |    2 
 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus    |   35 +
 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus      |   34 +
 tools/memory-model/litmus-tests/README                                    |   19 
 tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus |    4 
 tools/memory-model/lock.cat                                               |  197 ++++---
 tools/memory-model/scripts/checkalllitmus.sh                              |   73 ++
 tools/memory-model/scripts/checklitmus.sh                                 |   86 +++
 17 files changed, 595 insertions(+), 236 deletions(-)
