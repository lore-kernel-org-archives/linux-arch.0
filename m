From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 0/3] Updates to the formal memory model
Date: Mon, 3 Dec 2018 15:04:11 -0800
Message-ID: <20181203230411.GA27476@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello, Ingo!

This series contains updates to the Linux kernel's formal memory model
in tools/memory-model.  These patches are ready for inclusion into -tip.

1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.

2.	Add scripts to check github litmus tests.

3.	Make scripts take "-j" abbreviation for "--jobs".

There is another series in preparation to model SRCU, but this series
requires hot-off-the presses changes to the herd tool that have not yet
been released.  This SRCU series is therefore targeting the merge window
after the upcoming one.  People wishing to experiment with the prototype
SRCU model may obtain it from my -rcu tree at branch "dev", and use
a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
version 7.51+2(dev), which is (commit 10403b24070c) or later.

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
