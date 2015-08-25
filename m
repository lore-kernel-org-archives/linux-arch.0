From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL rcu/next] Additional RCU commit for 4.3
Date: Mon, 24 Aug 2015 17:03:11 -0700
Message-ID: <20150825000311.GA32412@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:52583 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbHYADR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2015 20:03:17 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 24 Aug 2015 18:03:17 -0600
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: llinux-kernel@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, benh@kernel.crashing.org, linux-arch@vger.kernel.org

Hello, Ingo,

This additional series contains a single change:

1.	Privatize smp_mb__after_unlock_lock().  This commit moves the
	definition of smp_mb__after_unlock_lock() to kernel/rcu/tree.h,
	in recognition of the fact that RCU is the only thing using
	this, that nothing else is likely to use it, and that it is
	likely to go away completely.

This change has been subjected to 0day Test Robot and -next testing,
and is available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 12d560f4ea87030667438a169912380be00cea4b:

  rcu,locking: Privatize smp_mb__after_unlock_lock() (2015-08-04 08:49:21 -0700)

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu,locking: Privatize smp_mb__after_unlock_lock()

 Documentation/memory-barriers.txt   | 71 +++----------------------------------
 arch/powerpc/include/asm/spinlock.h |  2 --
 include/linux/spinlock.h            | 10 ------
 kernel/rcu/tree.h                   | 12 +++++++
 4 files changed, 16 insertions(+), 79 deletions(-)
