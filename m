From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 0/15] Remove to-be-unneeded
 smp_read_barrier_depends()
Date: Mon, 9 Oct 2017 17:19:51 -0700
Message-ID: <20171010001951.GA6476@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41027 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755560AbdJJAT4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:19:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JQPL118126
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:19:56 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dgcabvnd1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:19:56 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:19:55 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, mark.rutland@arm.com, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, tj@kernel.org, cl@linux.com, davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org, corbet@lwn.net, james.l.morris@oracle.com, torvalds@linux-foundation.org

Hello!

Will Deacon has proposed adding smp_read_barrier_depends() to READ_ONCE(),
which would mean that quite a few instances of smp_read_barrier_depends()
would become redundant.  This series depends on Will's change and removes
those smp_read_barrier_depends(), while fixing a bug or two along the
way.  Some of these bugs are subtle, hence posting this sooner rather
than later.

This patch series depends on an in-progress series from Mark Rutland that
changes all calls to ACCESS_ONCE() to either READ_ONCE() or WRITE_ONCE(),
depending.  This patch series also depends on an upcoming patch from Will
Deacon that adds smp_read_barrier_depends() to Alpha's relaxed/release
RMW atomic operations.

As Will pointed out, once all of these patch series are in place, the
core kernel will no longer need any Alpha-specific code, with the sole
exception of READ_ONCE() and of course smp_read_barrier_depends() itself.

Pretty cool, huh?  ;-)

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt         |   11 ++++++-----
 arch/mn10300/kernel/mn10300-serial.c      |    7 +++++--
 drivers/net/ethernet/qlogic/qed/qed_spq.c |    4 +---
 fs/dcache.c                               |   10 +++-------
 include/linux/assoc_array_priv.h          |    5 +++--
 include/linux/percpu-refcount.h           |    6 +++---
 include/linux/rcupdate.h                  |   23 +++++++++++------------
 include/linux/rtnetlink.h                 |    3 +--
 include/linux/seqlock.h                   |    3 +--
 kernel/events/uprobes.c                   |   12 ++++++------
 kernel/locking/qspinlock.c                |   12 +++++-------
 kernel/tracepoint.c                       |    9 ++++-----
 lib/assoc_array.c                         |   20 ++------------------
 lib/percpu-refcount.c                     |    8 ++++----
 mm/ksm.c                                  |    9 +--------
 net/ipv4/netfilter/arp_tables.c           |    7 +------
 net/ipv4/netfilter/ip_tables.c            |    7 +------
 net/ipv6/netfilter/ip6_tables.c           |    7 +------
 security/keys/keyring.c                   |    7 -------
 19 files changed, 59 insertions(+), 111 deletions(-)
