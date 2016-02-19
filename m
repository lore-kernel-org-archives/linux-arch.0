Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0118.outbound.protection.outlook.com ([207.46.100.118]:37664
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1424914AbcBSVlQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Feb 2016 16:41:16 -0500
From: "Long, Wai Man" <waiman.long@hpe.com>
Subject: Re: [PATCH] locking/qspinlock: move __ARCH_SPIN_LOCK_UNLOCKED to
 qspinlock_types.h
Date: Fri, 19 Feb 2016 21:09:16 +0000
Message-ID: <DF4PR84MB01387137F726244CB2DE148CF1A00@DF4PR84MB0138.NAMPRD84.PROD.OUTLOOK.COM>
References: <1455907767-17821-1-git-send-email-dan.streetman@canonical.com>
In-Reply-To: <1455907767-17821-1-git-send-email-dan.streetman@canonical.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E9DC8A92C6ED44DAEEDD20F9C95289F@HPEnterprise.onmicrosoft.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Streetman <dan.streetman@canonical.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dan Streetman <ddstreet@ieee.org>
Message-ID: <20160219210916.n98Eelm6WTLyUrUz05dJECsUDMuEzwzbnAOzK-XwQ9w@z>

On 02/19/2016 01:49 PM, Dan Streetman wrote:
> Move __ARCH_SPIN_LOCK_UNLOCKED definition from qspinlock.h into
> qspinlock_types.h.
>
> The definition of __ARCH_SPIN_LOCK_UNLOCKED comes from the build arch's
> include files; but on x86 when CONFIG_QUEUED_SPINLOCKS is set, it just
> it's defined in asm-generic/qspinlock.h.  In most cases, this doesn't
> matter because linux/spinlock.h includes asm/spinlock.h, which for x86
> includes asm-generic/qspinlock.h.  However, any code that only includes
> linux/mutex.h will break, because it only includes asm/spinlock_types.h.
>
> For example, this breaks systemtap, which only includes mutex.h.
>
> Signed-off-by: Dan Streetman<dan.streetman@canonical.com>
> Cc: Dan Streetman<ddstreet@ieee.org>
> ---
>   include/asm-generic/qspinlock.h       | 5 -----
>   include/asm-generic/qspinlock_types.h | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index 39e1cb2..35a52a8 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -120,11 +120,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>   #endif
>
>   /*
> - * Initializier
> - */
> -#define	__ARCH_SPIN_LOCK_UNLOCKED	{ ATOMIC_INIT(0) }
> -
> -/*
>    * Remapping spinlock architecture specific functions to the corresponding
>    * queued spinlock functions.
>    */
> diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
> index 85f888e..034acd0 100644
> --- a/include/asm-generic/qspinlock_types.h
> +++ b/include/asm-generic/qspinlock_types.h
> @@ -33,6 +33,11 @@ typedef struct qspinlock {
>   } arch_spinlock_t;
>
>   /*
> + * Initializier
> + */
> +#define	__ARCH_SPIN_LOCK_UNLOCKED	{ ATOMIC_INIT(0) }
> +
> +/*
>    * Bitfields in the atomic value:
>    *
>    * When NR_CPUS<  16K
Acked-by: Waiman Long <Waiman.Long@hpe.com>

