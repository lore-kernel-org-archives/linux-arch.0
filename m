Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAOgX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 10:36:23 -0400
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
Date: Mon, 1 Apr 2019 10:36:19 -0400
MIME-Version: 1.0
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190401143619.ZPnQu09Fu4FLyHbZ55MNIGh6rWwPAcZORUPeKO2EdKQ@z>

On 03/29/2019 11:20 AM, Alex Kogan wrote:
> In CNA, spinning threads are organized in two queues, a main queue for
> threads running on the same node as the current lock holder, and a
> secondary queue for threads running on other nodes. At the unlock time,
> the lock holder scans the main queue looking for a thread running on
> the same node. If found (call it thread T), all threads in the main queue
> between the current lock holder and T are moved to the end of the
> secondary queue, and the lock is passed to T. If such T is not found, the
> lock is passed to the first node in the secondary queue. Finally, if the
> secondary queue is empty, the lock is passed to the next thread in the
> main queue. For more details, see https://arxiv.org/abs/1810.05600.
>
> Note that this variant of CNA may introduce starvation by continuously
> passing the lock to threads running on the same node. This issue
> will be addressed later in the series.
>
> Enabling CNA is controlled via a new configuration option
> (NUMA_AWARE_SPINLOCKS), which is enabled by default if NUMA is enabled.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  arch/x86/Kconfig                      |  14 +++
>  include/asm-generic/qspinlock_types.h |  13 +++
>  kernel/locking/mcs_spinlock.h         |  10 ++
>  kernel/locking/qspinlock.c            |  29 +++++-
>  kernel/locking/qspinlock_cna.h        | 173 ++++++++++++++++++++++++++++++++++
>  5 files changed, 236 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 68261430fe6e..e70c39a901f2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1554,6 +1554,20 @@ config NUMA
>  
>  	  Otherwise, you should say N.
>  
> +config NUMA_AWARE_SPINLOCKS
> +	bool "Numa-aware spinlocks"
> +	depends on NUMA
> +	default y
> +	help
> +	  Introduce NUMA (Non Uniform Memory Access) awareness into
> +	  the slow path of spinlocks.
> +
> +	  The kernel will try to keep the lock on the same node,
> +	  thus reducing the number of remote cache misses, while
> +	  trading some of the short term fairness for better performance.
> +
> +	  Say N if you want absolute first come first serve fairness.
> +

The patch that I am looking for is to have a separate
numa_queued_spinlock_slowpath() that coexists with
native_queued_spinlock_slowpath() and
paravirt_queued_spinlock_slowpath(). At boot time, we select the most
appropriate one for the system at hand.

If you are going for the configuration option route, keep in mind that
we optimize for the most common cases which are single-socket systems.
Please default to "n" unless you can prove that your change won't
regress performance for single-socket systems.

Cheers,
Longman
