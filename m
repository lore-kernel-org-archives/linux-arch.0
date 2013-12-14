From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL locking/mb] Locking/memory-barrier commits
Date: Fri, 13 Dec 2013 23:48:46 -0800
Message-ID: <20131214074846.GA23612@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:52984 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3LNHsy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 14 Dec 2013 02:48:54 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 14 Dec 2013 00:48:54 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0D6E93E40040
	for <linux-arch@vger.kernel.org>; Sat, 14 Dec 2013 00:48:51 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBE7moNk4522276
	for <linux-arch@vger.kernel.org>; Sat, 14 Dec 2013 08:48:50 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id rBE7pqWW009815
	for <linux-arch@vger.kernel.org>; Sat, 14 Dec 2013 00:51:54 -0700
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: dhowells@redhat.com, josh@joshtriplett.org, peterz@infradead.org, linux-arch@vger.kernel.org, oleg@redhat.com, corbet@lwn.net, rusty@rustcorp.com.au, torvalds@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org

Hello, Ingo,

This pull request contains additions to the memory-barrier documentation,
along with a downgrading of UNLOCK+LOCK to no longer be a full memory
barrier, and finally an smp_mb__after_unlock_lock() that allows upgrading
a particular LOCK to pair with a preceding UNLOCK to form a full memory
barrier, and application of smp_mb__after_unlock_lock() to RCU.

The first four documentation commits are ready for 3.14:

b145f8acfd82 (Add needed ACCESS_ONCE() calls to memory-barriers.txt)
6be08d626389 (Add long atomic examples to memory-barriers.txt)
c89bb78cfbe1 (Prohibit speculative writes)
b2ba08be67fc (Document ACCESS_ONCE())

The remaining commits might or might not be, but are at a point where
getting them into -tip is appropriate given other changes in this area,
e.g., Peter's smp_load_acquire() and smp_store_release().

These changes are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git locking/mb

for you to fetch changes up to 9f9df17e265b2c5aea11a95e3e69269d005ac0ae:

  powerpc: Full barrier for smp_mb__after_unlock_lock() (2013-12-13 09:05:13 -0800)

----------------------------------------------------------------
Paul E. McKenney (7):
      Documentation/memory-barriers.txt: Add needed ACCESS_ONCE() calls to memory-barriers.txt
      Documentation/memory-barriers.txt: Add long atomic examples to memory-barriers.txt
      Documentation/memory-barriers.txt: Document ACCESS_ONCE()
      locking: Add an smp_mb__after_unlock_lock() for UNLOCK+LOCK barrier
      Documentation/memory-barriers.txt: Downgrade UNLOCK+LOCK
      rcu: Apply smp_mb__after_unlock_lock() to preserve grace periods
      powerpc: Full barrier for smp_mb__after_unlock_lock()

Peter Zijlstra (1):
      Documentation/memory-barriers.txt: Prohibit speculative writes

 Documentation/memory-barriers.txt   | 733 ++++++++++++++++++++++++++++++------
 arch/powerpc/include/asm/spinlock.h |   2 +
 include/linux/spinlock.h            |  10 +
 kernel/rcu/tree.c                   |  18 +-
 kernel/rcu/tree_plugin.h            |  13 +
 5 files changed, 661 insertions(+), 115 deletions(-)
