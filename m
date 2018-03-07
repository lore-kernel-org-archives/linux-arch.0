From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 0/4] Documentation updates and fixes
Date: Wed, 7 Mar 2018 09:26:27 -0800
Message-ID: <20180307172627.GA15805@linux.vnet.ibm.com>
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

This patch series adds some documentation and fixes to the Linux-kernel
memory model (LKMM):

1.	Add more text to meomry-barrier.txt to de-emphasize
	smp_read_barrier_depends().

2.	Remove mention of the now-obsolete docker and gentoo images
	from README.

3.	Add documentation for the new ISA2+pooncelock+pooncelock+pombonce
	litmus test.

4.	Update the removal of rb-dep, smp_read_barrier_depends(), and
	lockless_dereference() to reflect feedback.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                |   26 +++++++++++++++--------
 tools/memory-model/Documentation/cheatsheet.txt  |    6 ++---
 tools/memory-model/Documentation/explanation.txt |    4 +--
 tools/memory-model/README                        |   15 -------------
 tools/memory-model/linux-kernel.def              |    2 -
 tools/memory-model/litmus-tests/README           |    6 +++++
 6 files changed, 30 insertions(+), 29 deletions(-)
