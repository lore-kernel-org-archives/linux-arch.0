Return-Path: <SRS0=948I=23=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21924 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726446AbgAFPsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jan 2020 10:48:31 -0500
Subject: Re: [PATCH v8 0/5] Add NUMA-awareness to qspinlock
References: <20191230194042.67789-1-alex.kogan@oracle.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <13cde730-34c1-8b99-6990-1f64cc78670d@redhat.com>
Date: Mon, 6 Jan 2020 10:48:15 -0500
MIME-Version: 1.0
In-Reply-To: <20191230194042.67789-1-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200106154815.xf86hYtKuVbHQN9wFfw9ZAtS70d13Mw6JfXljsSiVno@z>

On 12/30/19 2:40 PM, Alex Kogan wrote:
> Minor changes from v7 based on feedback from Longman:
> -----------------------------------------------------
>
> - Move __init functions from alternative.c to qspinlock_cna.h
>
> - Introduce enum for return values from cna_pre_scan(), for better
> readability.
>
> - Add/revise a few comments to improve readability.
>
>
> Summary
> -------
>
> Lock throughput can be increased by handing a lock to a waiter on the
> same NUMA node as the lock holder, provided care is taken to avoid
> starvation of waiters on other NUMA nodes. This patch introduces CNA
> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>
> CNA is a NUMA-aware version of the MCS lock. Spinning threads are
> organized in two queues, a main queue for threads running on the same
> node as the current lock holder, and a secondary queue for threads
> running on other nodes. Threads store the ID of the node on which
> they are running in their queue nodes. After acquiring the MCS lock and
> before acquiring the spinlock, the lock holder scans the main queue
> looking for a thread running on the same node (pre-scan). If found (call
> it thread T), all threads in the main queue between the current lock
> holder and T are moved to the end of the secondary queue.  If such T
> is not found, we make another scan of the main queue after acquiring 
> the spinlock when unlocking the MCS lock (post-scan), starting at the
> node where pre-scan stopped. If both scans fail to find such T, the
> MCS lock is passed to the first thread in the secondary queue. If the
> secondary queue is empty, the MCS lock is passed to the next thread in the
> main queue. To avoid starvation of threads in the secondary queue, those
> threads are moved back to the head of the main queue after a certain
> number of intra-node lock hand-offs.
>
> More details are available at https://arxiv.org/abs/1810.05600.
>
> The series applies on top of v5.5.0-rc2, commit ea200dec51.
> Performance numbers are available in previous revisions
> of the series.
>
> Further comments are welcome and appreciated.
>
> Alex Kogan (5):
>   locking/qspinlock: Rename mcs lock/unlock macros and make them more
>     generic
>   locking/qspinlock: Refactor the qspinlock slow path
>   locking/qspinlock: Introduce CNA into the slow path of qspinlock
>   locking/qspinlock: Introduce starvation avoidance into CNA
>   locking/qspinlock: Introduce the shuffle reduction optimization into
>     CNA
>
>  .../admin-guide/kernel-parameters.txt         |  18 +
>  arch/arm/include/asm/mcs_spinlock.h           |   6 +-
>  arch/x86/Kconfig                              |  20 +
>  arch/x86/include/asm/qspinlock.h              |   4 +
>  arch/x86/kernel/alternative.c                 |   4 +
>  include/asm-generic/mcs_spinlock.h            |   4 +-
>  kernel/locking/mcs_spinlock.h                 |  20 +-
>  kernel/locking/qspinlock.c                    |  82 +++-
>  kernel/locking/qspinlock_cna.h                | 400 ++++++++++++++++++
>  kernel/locking/qspinlock_paravirt.h           |   2 +-
>  10 files changed, 537 insertions(+), 23 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
>
I have reviewed this patch series. Besides a few minor nits, the rests
look solid to me. So you can put my review tag.

Reviewed-by: Waiman Long <longman@redhat.com>

Peter and Will, would you mind taking a look to see if you have anything
to add?

Thanks,
Longman
