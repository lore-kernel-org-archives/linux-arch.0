From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Sun, 16 Aug 2009 19:57:50 +0200
Message-ID: <20090816175750.GA5808@osiris.boeblingen.de.ibm.com>
References: <20090814125801.881618121@de.ibm.com>
 <20090814125857.181021997@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.uk.ibm.com ([195.212.29.140]:33211 "EHLO
	mtagate7.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162AbZHPR6B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2009 13:58:01 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7GHvqVQ497122
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2009 17:57:52 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7GHvpbe1749202
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2009 18:57:51 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7GHvoQX017587
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2009 18:57:51 +0100
Content-Disposition: inline
In-Reply-To: <20090814125857.181021997@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>

Hi Linus, Andrew,

do you have any objections to the approach below?
Just wondering, since I didn't receive any comments.

On Fri, Aug 14, 2009 at 02:58:03PM +0200, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> This allows an architecture to specify per lock variant if the
> locking code should be kept out-of-line or inlined.
> 
> If an architecure wants out-of-line locking code no change is
> needed. To force inlining of e.g. spin_lock() the line
> 
> #define __spin_lock_is_small
> 
> needs to be added to arch/<whatever>/include/asm/spinlock.h
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  include/linux/spinlock_api_smp.h |  146 ++++++++++++++++++++++++++++++++++++++-
>  kernel/spinlock.c                |   56 ++++++++++++++
>  2 files changed, 199 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/include/linux/spinlock_api_smp.h
> ===================================================================
> --- linux-2.6.orig/include/linux/spinlock_api_smp.h
> +++ linux-2.6/include/linux/spinlock_api_smp.h
> @@ -19,46 +19,186 @@ int in_lock_functions(unsigned long addr
> 
>  #define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
> 
> -void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
>  void __lockfunc _spin_lock_nested(spinlock_t *lock, int subclass)
>  							__acquires(lock);
>  void __lockfunc _spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *map)
>  							__acquires(lock);
> +unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
> +							__acquires(lock);
> +
> +#ifdef __spin_lock_is_small
> +#define _spin_lock(lock) __spin_lock(lock)
> +#else
> +void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
> +#endif

...

> Index: linux-2.6/kernel/spinlock.c
> ===================================================================
> --- linux-2.6.orig/kernel/spinlock.c
> +++ linux-2.6/kernel/spinlock.c

...

> +#ifndef __spin_lock_is_small
>  void __lockfunc _spin_lock(spinlock_t *lock)
>  {
>  	__spin_lock(lock);
>  }
>  EXPORT_SYMBOL(_spin_lock);
> +#endif
