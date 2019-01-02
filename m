Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfABU5u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jan 2019 15:57:50 -0500
Date: Wed, 2 Jan 2019 15:57:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/4] barriers using data dependency
Message-ID: <20190102205715.14054-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
Message-ID: <20190102205745.ILsTRWx_01xSsiaUXAuR59pOPmj0-bIqAzo1DRZfrxg@z>

So as explained in Documentation/memory-barriers.txt e.g.
a load followed by a store require a full memory barrier,
to avoid store being ordered before the load.
Similarly load-load requires a read memory barrier.

Thinking about it, we can actually create a data dependency
by mixing the first loaded value into the pointer being
accessed.

This adds an API for this and uses it in virtio.

Written over the holiday and build tested only so far.

This patchset is also suboptimal on e.g. x86 where e.g. smp_rmb is a nop.

Sending out for early feedback/flames.

Michael S. Tsirkin (4):
  include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
  include/linux/compiler.h: allow memory operands
  barriers: convert a control to a data dependency
  virtio: use dependent_ptr_mb

 Documentation/memory-barriers.txt | 20 ++++++++++++++++++++
 arch/alpha/include/asm/barrier.h  |  1 +
 drivers/virtio/virtio_ring.c      |  6 ++++--
 include/asm-generic/barrier.h     | 18 ++++++++++++++++++
 include/linux/compiler-clang.h    |  5 ++---
 include/linux/compiler-gcc.h      |  4 ----
 include/linux/compiler-intel.h    |  4 +---
 include/linux/compiler.h          |  8 +++++++-
 8 files changed, 53 insertions(+), 13 deletions(-)

-- 
MST
