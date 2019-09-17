Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:2231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbfIQGZ5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Sep 2019 02:25:57 -0400
Subject: Re: [PATCH v4 1/5] locking/qspinlock: Rename
 arch_mcs_spin_unlock_contended to arch_mcs_pass_lock and make it more generic
References: <20190906142541.34061-1-alex.kogan@oracle.com>
 <20190906142541.34061-2-alex.kogan@oracle.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <22a45ca4-fcae-c805-596e-67f1809eb1dd@huawei.com>
Date: Tue, 17 Sep 2019 14:25:45 +0800
MIME-Version: 1.0
In-Reply-To: <20190906142541.34061-2-alex.kogan@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190917062545.S_hM_fDAR1f6Col7R0z7OBWVrtdZZWHCwui4yeqB_8Y@z>

Hi Alex,

On 2019/9/6 22:25, Alex Kogan wrote:
> The new macro should accept the value to be stored into the lock argument
> as another argument. This allows using the same macro in cases where the
> value to be stored when passing the lock is different from 1.
> 
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  arch/arm/include/asm/mcs_spinlock.h | 4 ++--
>  kernel/locking/mcs_spinlock.h       | 6 +++---
>  kernel/locking/qspinlock.c          | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
> index 529d2cf4d06f..f3f9efdcd2ca 100644
> --- a/arch/arm/include/asm/mcs_spinlock.h
> +++ b/arch/arm/include/asm/mcs_spinlock.h
> @@ -14,9 +14,9 @@ do {									\
>  		wfe();							\
>  } while (0)								\
>  
> -#define arch_mcs_spin_unlock_contended(lock)				\
> +#define arch_mcs_pass_lock(lock, val)					\

arch_mcs_spin_unlock_contended() has a matching function arch_mcs_spin_lock_contended(),
please see include/asm-generic/mcs_spinlock.h, so if we update this function name,
should we update the matching one as well? and update the relevant comments as well?

>  do {									\
> -	smp_store_release(lock, 1);					\
> +	smp_store_release((lock), (val));				\
>  	dsb_sev();							\
>  } while (0)
>  
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index 5e10153b4d3c..84327ca21650 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -41,8 +41,8 @@ do {									\
>   * operations in the critical section has been completed before
>   * unlocking.
>   */
> -#define arch_mcs_spin_unlock_contended(l)				\

Before this line of the code, there is:

#ifndef arch_mcs_spin_lock_contended

...

#define arch_mcs_spin_lock_contended(l)                 \

So #ifndef should be updated too.

Thanks
Hanjun
