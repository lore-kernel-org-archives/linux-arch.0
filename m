Return-Path: <SRS0=lDRc=3L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVJQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:16:11 -0500
Date: Wed, 22 Jan 2020 10:15:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 1/5] locking/qspinlock: Rename mcs lock/unlock macros
 and make them more generic
Message-ID: <20200122091547.GU14879@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-2-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125210709.10293-2-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20200122091547.8TwqnUd3Bc0GqHLviFvT4OhuIJf2dx4Bwrxh7ungXFY@z>

On Mon, Nov 25, 2019 at 04:07:05PM -0500, Alex Kogan wrote:

> --- a/arch/arm/include/asm/mcs_spinlock.h
> +++ b/arch/arm/include/asm/mcs_spinlock.h
> @@ -6,7 +6,7 @@
>  #include <asm/spinlock.h>
>  
>  /* MCS spin-locking. */
> -#define arch_mcs_spin_lock_contended(lock)				\
> +#define arch_mcs_spin_lock(lock)				\
>  do {									\
>  	/* Ensure prior stores are observed before we enter wfe. */	\
>  	smp_mb();							\
> @@ -14,9 +14,9 @@ do {									\
>  		wfe();							\
>  } while (0)								\
>  
> -#define arch_mcs_spin_unlock_contended(lock)				\
> +#define arch_mcs_pass_lock(lock, val)					\
>  do {									\
> -	smp_store_release(lock, 1);					\
> +	smp_store_release((lock), (val));				\
>  	dsb_sev();							\
>  } while (0)

So I hate those names; it used to be clear this was the contended path,
not so anymore. arch_mcs_spin_lock() in particular is grossly misnamed
now.

's/arch_mcs_spin_lock/arch_mcs_spin_wait/g' could perhaps work, if you
really want to get rid of the _contended suffix.

Also, pass_lock seems unfortunately named...
