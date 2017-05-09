From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
Date: Tue, 9 May 2017 12:47:08 +0800
Message-ID: <20170509044708.vvwgzhvdrqyljy6s@tardis>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <20170503145141.4966-4-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33188 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbdEIEsf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2017 00:48:35 -0400
Content-Disposition: inline
In-Reply-To: <20170503145141.4966-4-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

On Wed, May 03, 2017 at 05:51:41PM +0300, Yury Norov wrote:
> From: Jan Glauber <jglauber@cavium.com>
>=20
> Ported from x86_64 with paravirtualization support removed.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>=20
> Note. This patch removes protection from direct inclusion of
> arch/arm64/include/asm/spinlock_types.h. It's done because
> kernel/locking/qrwlock.c file does it thru the header
> include/asm-generic/qrwlock_types.h. Until now the only user
> of qrwlock.c was x86, and there's no such protection too.
>=20
> I'm not happy to remove the protection, but if it's OK for x86,
> it should be also OK for arm64. If not, I think we'd fix it
> for x86, and add the protection there too.
>=20
> Yury
>=20
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arm64/Kconfig                      | 24 +++++++++++++++++++
>  arch/arm64/include/asm/qrwlock.h        |  7 ++++++
>  arch/arm64/include/asm/qspinlock.h      | 42 +++++++++++++++++++++++++++=
++++++
>  arch/arm64/include/asm/spinlock.h       | 12 ++++++++++
>  arch/arm64/include/asm/spinlock_types.h | 14 ++++++++---
>  arch/arm64/kernel/Makefile              |  1 +
>  arch/arm64/kernel/qspinlock.c           | 34 ++++++++++++++++++++++++++
>  7 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/include/asm/qrwlock.h
>  create mode 100644 arch/arm64/include/asm/qspinlock.h
>  create mode 100644 arch/arm64/kernel/qspinlock.c
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 22dbde97eefa..db24b3b3f3c6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -25,6 +25,8 @@ config ARM64
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> +	select ARCH_USE_QUEUED_RWLOCKS if QUEUED_LOCKS
> +	select ARCH_USE_QUEUED_SPINLOCKS if QUEUED_LOCKS
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
>  	select ARM_GIC
> @@ -692,6 +694,28 @@ config ARCH_WANT_HUGE_PMD_SHARE
>  config ARCH_HAS_CACHE_LINE_SIZE
>  	def_bool y
> =20
> +choice
> +	prompt "Locking type"
> +	default TICKET_LOCKS
> +	help
> +	  Choose between traditional ticked-based locking mechanism and
> +	  queued-based mechanism.
> +
> +config TICKET_LOCKS
> +	bool "Ticket locks"
> +	help
> +	  Ticked-based locking implementation for ARM64
> +
> +config QUEUED_LOCKS
> +	bool "Queued locks"
> +	help
> +	  Queue-based locking mechanism. This option improves
> +	  locking performance in case of high-contended locking
> +	  on many-cpu machines. On low-cpu machines there is no
> +	  difference comparing to ticked-based locking.
> +
> +endchoice
> +
>  source "mm/Kconfig"
> =20
>  config SECCOMP
> diff --git a/arch/arm64/include/asm/qrwlock.h b/arch/arm64/include/asm/qr=
wlock.h
> new file mode 100644
> index 000000000000..626f6ebfb52d
> --- /dev/null
> +++ b/arch/arm64/include/asm/qrwlock.h
> @@ -0,0 +1,7 @@
> +#ifndef _ASM_ARM64_QRWLOCK_H
> +#define _ASM_ARM64_QRWLOCK_H
> +
> +#include <asm-generic/qrwlock_types.h>
> +#include <asm-generic/qrwlock.h>
> +
> +#endif /* _ASM_ARM64_QRWLOCK_H */
> diff --git a/arch/arm64/include/asm/qspinlock.h b/arch/arm64/include/asm/=
qspinlock.h
> new file mode 100644
> index 000000000000..09ef4f13f549
> --- /dev/null
> +++ b/arch/arm64/include/asm/qspinlock.h
> @@ -0,0 +1,42 @@
> +#ifndef _ASM_ARM64_QSPINLOCK_H
> +#define _ASM_ARM64_QSPINLOCK_H
> +
> +#include <asm-generic/qspinlock_types.h>
> +#include <asm/atomic.h>
> +
> +extern void queued_spin_unlock_wait(struct qspinlock *lock);
> +#define queued_spin_unlock_wait queued_spin_unlock_wait
> +
> +#define	queued_spin_unlock queued_spin_unlock
> +/**
> + * queued_spin_unlock - release a queued spinlock
> + * @lock : Pointer to queued spinlock structure
> + *
> + * A smp_store_release() on the least-significant byte.
> + */
> +static inline void queued_spin_unlock(struct qspinlock *lock)
> +{
> +	smp_store_release((u8 *)lock, 0);

I think this part will cause endian issues, maybe you want something
like what we do in queued_write_lock().

Have you tested this on an BE environment?

Regards,
Boqun

> +}
> +
> +#define queued_spin_is_locked queued_spin_is_locked
> +/**
> + * queued_spin_is_locked - is the spinlock locked?
> + * @lock: Pointer to queued spinlock structure
> + * Return: 1 if it is locked, 0 otherwise
> + */
> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
> +{
> +	/*
> +	 * See queued_spin_unlock_wait().
> +	 *
> +	 * Any !0 state indicates it is locked, even if _Q_LOCKED_VAL
> +	 * isn't immediately observable.
> +	 */
> +	smp_mb();
> +	return atomic_read(&lock->val);
> +}
> +
> +#include <asm-generic/qspinlock.h>
> +
> +#endif /* _ASM_ARM64_QSPINLOCK_H */
> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/s=
pinlock.h
> index cae331d553f8..37713397e0c5 100644
> --- a/arch/arm64/include/asm/spinlock.h
> +++ b/arch/arm64/include/asm/spinlock.h
> @@ -20,6 +20,10 @@
>  #include <asm/spinlock_types.h>
>  #include <asm/processor.h>
> =20
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#include <asm/qspinlock.h>
> +#else
> +
>  /*
>   * Spinlock implementation.
>   *
> @@ -187,6 +191,12 @@ static inline int arch_spin_is_contended(arch_spinlo=
ck_t *lock)
>  }
>  #define arch_spin_is_contended	arch_spin_is_contended
> =20
> +#endif /* CONFIG_QUEUED_SPINLOCKS */
> +
> +#ifdef CONFIG_QUEUED_RWLOCKS
> +#include <asm/qrwlock.h>
> +#else
> +
>  /*
>   * Write lock implementation.
>   *
> @@ -351,6 +361,8 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
>  /* read_can_lock - would read_trylock() succeed? */
>  #define arch_read_can_lock(x)		((x)->lock < 0x80000000)
> =20
> +#endif /* CONFIG_QUEUED_RWLOCKS */
> +
>  #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
>  #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
> =20
> diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include=
/asm/spinlock_types.h
> index 55be59a35e3f..0f0f1561ab6a 100644
> --- a/arch/arm64/include/asm/spinlock_types.h
> +++ b/arch/arm64/include/asm/spinlock_types.h
> @@ -16,9 +16,9 @@
>  #ifndef __ASM_SPINLOCK_TYPES_H
>  #define __ASM_SPINLOCK_TYPES_H
> =20
> -#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
> -# error "please don't include this file directly"
> -#endif
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#include <asm-generic/qspinlock_types.h>
> +#else
> =20
>  #include <linux/types.h>
> =20
> @@ -36,10 +36,18 @@ typedef struct {
> =20
>  #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
> =20
> +#endif /* CONFIG_QUEUED_SPINLOCKS */
> +
> +#ifdef CONFIG_QUEUED_RWLOCKS
> +#include <asm-generic/qrwlock_types.h>
> +#else
> +
>  typedef struct {
>  	volatile unsigned int lock;
>  } arch_rwlock_t;
> =20
>  #define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
> =20
> +#endif /* CONFIG_QUEUED_RWLOCKS */
> +
>  #endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 9d56467dc223..f48f6256e893 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -56,6 +56,7 @@ arm64-obj-$(CONFIG_KEXEC)		+=3D machine_kexec.o relocat=
e_kernel.o	\
>  arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+=3D arm64-reloc-test.o
>  arm64-reloc-test-y :=3D reloc_test_core.o reloc_test_syms.o
>  arm64-obj-$(CONFIG_CRASH_DUMP)		+=3D crash_dump.o
> +arm64-obj-$(CONFIG_QUEUED_SPINLOCKS)	+=3D qspinlock.o
> =20
>  obj-y					+=3D $(arm64-obj-y) vdso/ probes/
>  obj-$(CONFIG_ARM64_ILP32)		+=3D vdso-ilp32/
> diff --git a/arch/arm64/kernel/qspinlock.c b/arch/arm64/kernel/qspinlock.c
> new file mode 100644
> index 000000000000..924f19953adb
> --- /dev/null
> +++ b/arch/arm64/kernel/qspinlock.c
> @@ -0,0 +1,34 @@
> +#include <asm/qspinlock.h>
> +#include <asm/processor.h>
> +
> +void queued_spin_unlock_wait(struct qspinlock *lock)
> +{
> +	u32 val;
> +
> +	for (;;) {
> +		smp_mb();
> +		val =3D atomic_read(&lock->val);
> +
> +		if (!val) /* not locked, we're done */
> +			goto done;
> +
> +		if (val & _Q_LOCKED_MASK) /* locked, go wait for unlock */
> +			break;
> +
> +		/* not locked, but pending, wait until we observe the lock */
> +		cpu_relax();
> +	}
> +
> +	for (;;) {
> +		smp_mb();
> +		val =3D atomic_read(&lock->val);
> +		if (!(val & _Q_LOCKED_MASK)) /* any unlock is good */
> +			break;
> +
> +		cpu_relax();
> +	}
> +
> +done:
> +	smp_acquire__after_ctrl_dep();
> +}
> +EXPORT_SYMBOL(queued_spin_unlock_wait);
> --=20
> 2.11.0
>=20
