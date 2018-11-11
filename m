From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/3] LKMM updates for v4.21/v5.0
Date: Sun, 11 Nov 2018 12:24:45 -0800
Message-ID: <20181111202445.GA14026@linux.ibm.com>
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

This series contains updates for the Linux-kernel memory model:

1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.

2.	Add scripts to check github litmus tests.

3.	Make scripts take "-j" abbreviation for "--jobs".

								Thanx, Paul

------------------------------------------------------------------------

 .gitignore                 |    1 
 README                     |    2 
 linux-kernel.bell          |    3 
 linux-kernel.cat           |    4 -
 linux-kernel.def           |    1 
 scripts/README             |   70 ++++++++++++++++++++++
 scripts/checkalllitmus.sh  |   53 +++++++----------
 scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
 scripts/checklitmus.sh     |   74 +++--------------------
 scripts/checklitmushist.sh |   60 +++++++++++++++++++
 scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
 scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
 scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
 scripts/newlitmushist.sh   |   61 +++++++++++++++++++
 scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
 scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
 16 files changed, 757 insertions(+), 97 deletions(-)
