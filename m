From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/31] LKMM updates for review
Date: Thu, 1 Aug 2019 15:20:26 -0700
Message-ID: <20190801222026.GA11315@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello!

This series contains LKMM updates:

1.	Make scripts be executable.

2-3.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

4.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

5.	Make LKMM scripts detect unconditional deadlocks.

6.	Fix email address on LKMM scripts.

7-29.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models for
	checkalllitmus.sh.  This is a work in progress.

30.	Use cumul-fence instead of fence in ->prop example, courtesy
	of Joel Fernandes.

31.	Update the informal documentation, courtesy of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |   53 +++++++--------
 README                        |   18 ++---
 litmus-tests/.gitignore       |    4 -
 scripts/README                |   16 +++-
 scripts/checkalllitmus.sh     |   29 ++++----
 scripts/checkghlitmus.sh      |   11 +--
 scripts/checklitmus.sh        |  101 ++++++++++++-----------------
 scripts/checklitmushist.sh    |    2 
 scripts/checktheselitmus.sh   |   43 ++++++++++++
 scripts/cmplitmushist.sh      |   53 ++++++++++++++-
 scripts/hwfnseg.sh            |   20 +++++
 scripts/initlitmushist.sh     |    2 
 scripts/judgelitmus.sh        |  142 +++++++++++++++++++++++++++++++----------
 scripts/newlitmushist.sh      |    4 -
 scripts/parseargs.sh          |   21 ++++--
 scripts/runlitmus.sh          |  144 ++++++++++++++++++++++++++++++++----------
 scripts/runlitmushist.sh      |   30 +++++---
 scripts/simpletest.sh         |   35 ++++++++++
 18 files changed, 514 insertions(+), 214 deletions(-)
