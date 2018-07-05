From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Date: Thu, 5 Jul 2018 19:59:02 +0200
Message-ID: <20180705175902.GF2530@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:

> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	unsigned int *p = &lock->lock;
> +	unsigned int tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 1b   \n"
> +		"	movi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "memory");
> +	smp_mb();
> +}

Test-and-set with MB acting as ACQUIRE, ok.

> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	unsigned int *p = &lock->lock;
> +	unsigned int tmp;
> +
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	movi		%0, 0    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "memory");
> +}

MB acting for RELEASE, but _why_ are you using a LDEX/STEX to clear the
lock word? Would not a normal store work?

Also, the fact that you need MB for release implies your LDEX does not
in fact imply anything and your xchg/cmpxchg implementation is broken.

> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	unsigned int *p = &lock->lock;
> +	unsigned int tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 2f   \n"
> +		"	movi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		"	movi		%0, 0    \n"
> +		"2:				 \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "memory");
> +	smp_mb();
> +
> +	return !tmp;
> +}

Strictly speaking you can avoid the MB on failure. You only need to
provide ACQUIRE semantics on success.

That said, I would really suggest you implement a ticket lock instead of
a test-and-set lock. They're not really all that complicated and do
provide better worst case behaviour.


> +/****** read lock/unlock/trylock ******/

Please have a look at using qrwlock -- esp. if you implement a ticket
lock, then the rwlock comes for 'free'.
