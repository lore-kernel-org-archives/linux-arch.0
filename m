From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 0/8] memory-barriers.txt and atomic_ops.rst
 updates
Date: Mon, 14 May 2018 15:54:57 -0700
Message-ID: <20180514225457.GA5142@linux.vnet.ibm.com>
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

This series contains changes to the atomic_ops.rst file and to the
memory-barriers.txt file and its Korean translation.  These changes are
ready for inclusion into -tip.

1.	Fix memory-barriers.txt's ordering example contrasting DMA to
	MMIO, courtesy of Will Deacon.

2-6.	Updates to Korean translation of memory-barriers.txt, courtesy
	of SeongJae Park.

7.	Fix example code in atomic_ops.rst, courtesy of SeongJae Park.

8.	Use `warning` rst directive in atomic_ops.rst, courtesy of
	SeongJae Park.

							Thanx, Paul

------------------------------------------------------------------------

 core-api/atomic_ops.rst                |   13 ++++---
 memory-barriers.txt                    |   17 +++++-----
 translations/ko_KR/memory-barriers.txt |   56 +++++++++++++++++++++------------
 3 files changed, 53 insertions(+), 33 deletions(-)
