From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/33] LKMM updates for review
Date: Thu, 30 May 2019 07:42:02 -0700
Message-ID: <20190530144202.GA26201@linux.ibm.com>
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

1-3.	Add plain C-language accesses to the model, including data-race
	detection, courtesy of Alan Stern.

4.	Make scripts be executable.

5.	Explain ordering provided by smp_mb__{before,after}_atomic(),
	courtesy of Alan Stern.

6.	Fix comment in MP+poonceonces.litmus, courtesy of Andrea Parri.

7.	Make documentation referencing "herd" instead reference the
	actual name of the command, "herd7", courtesy of Andrea Parri.

8-9.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

10.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

11.	Make LKMM scripts detect unconditional deadlocks.

12.	Fix email address on LKMM scripts.

13-33.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models for
	checkalllitmus.sh.  This is a work in progress.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/atomic_t.txt                            |   17 +-
 tools/memory-model/linux-kernel.bell                  |    6 
 tools/memory-model/linux-kernel.cat                   |   82 ++++++++--
 tools/memory-model/linux-kernel.def                   |    1 
 tools/memory-model/litmus-tests/.gitignore            |    4 
 tools/memory-model/litmus-tests/MP+poonceonces.litmus |    2 
 tools/memory-model/litmus-tests/README                |    2 
 tools/memory-model/lock.cat                           |    2 
 tools/memory-model/scripts/README                     |   20 +-
 tools/memory-model/scripts/checkalllitmus.sh          |   31 +--
 tools/memory-model/scripts/checkghlitmus.sh           |   11 -
 tools/memory-model/scripts/checklitmus.sh             |  103 +++++--------
 tools/memory-model/scripts/checklitmushist.sh         |    2 
 tools/memory-model/scripts/checktheselitmus.sh        |   43 +++++
 tools/memory-model/scripts/cmplitmushist.sh           |   53 ++++++
 tools/memory-model/scripts/hwfnseg.sh                 |   20 ++
 tools/memory-model/scripts/initlitmushist.sh          |    2 
 tools/memory-model/scripts/judgelitmus.sh             |  136 +++++++++++++----
 tools/memory-model/scripts/newlitmushist.sh           |    4 
 tools/memory-model/scripts/parseargs.sh               |   23 ++
 tools/memory-model/scripts/runlitmus.sh               |  142 ++++++++++++++----
 tools/memory-model/scripts/runlitmushist.sh           |   32 ++--
 tools/memory-model/scripts/simpletest.sh              |   35 ++++
 23 files changed, 573 insertions(+), 200 deletions(-)
