From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH 05/35] Disintegrate asm/system.h for Blackfin [ver #2]
Date: Tue, 13 Mar 2012 12:44:10 +0800
Message-ID: <CAA_GA1d1tZ2kQJ4a1tY_fSQBEPyxzwx075vm9pkj8TCsGs-AaQ@mail.gmail.com>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
	<20120312233656.13888.39270.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48936 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab2CMEoL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Mar 2012 00:44:11 -0400
In-Reply-To: <20120312233656.13888.39270.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, uclinux-dist-devel@blackfin.uclinux.org, Mike Frysinger <vapier@gentoo.org>

On Tue, Mar 13, 2012 at 7:36 AM, David Howells <dhowells@redhat.com> wr=
ote:
> Disintegrate asm/system.h for Blackfin.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: uclinux-dist-devel@blackfin.uclinux.org

Thanks, i'll apply it.

> ---
>
> =C2=A0arch/blackfin/include/asm/atomic.h =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A02
> =C2=A0arch/blackfin/include/asm/barrier.h =C2=A0 =C2=A0 | =C2=A0 48 +=
+++++++
> =C2=A0arch/blackfin/include/asm/cmpxchg.h =C2=A0 =C2=A0 | =C2=A0132 +=
++++++++++++++++++++
> =C2=A0arch/blackfin/include/asm/exec.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A01
> =C2=A0arch/blackfin/include/asm/irq_handler.h | =C2=A0 =C2=A01
> =C2=A0arch/blackfin/include/asm/switch_to.h =C2=A0 | =C2=A0 39 ++++++
> =C2=A0arch/blackfin/include/asm/system.h =C2=A0 =C2=A0 =C2=A0| =C2=A0=
197 +------------------------------
> =C2=A0arch/blackfin/kernel/asm-offsets.c =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A01
> =C2=A0arch/blackfin/kernel/ipipe.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01
> =C2=A0arch/blackfin/kernel/kgdb_test.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A01
> =C2=A0arch/blackfin/kernel/process.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A01
> =C2=A0arch/blackfin/kernel/ptrace.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A01
> =C2=A0arch/blackfin/kernel/reboot.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A01
> =C2=A0arch/blackfin/kernel/setup.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01
> =C2=A0arch/blackfin/kernel/trace.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01
> =C2=A0arch/blackfin/kernel/traps.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01
> =C2=A016 files changed, 233 insertions(+), 196 deletions(-)
> =C2=A0create mode 100644 arch/blackfin/include/asm/barrier.h
> =C2=A0create mode 100644 arch/blackfin/include/asm/cmpxchg.h
> =C2=A0create mode 100644 arch/blackfin/include/asm/exec.h
> =C2=A0create mode 100644 arch/blackfin/include/asm/switch_to.h
>
> diff --git a/arch/blackfin/include/asm/atomic.h b/arch/blackfin/inclu=
de/asm/atomic.h
> index 54c6e28..c8db653 100644
> --- a/arch/blackfin/include/asm/atomic.h
> +++ b/arch/blackfin/include/asm/atomic.h
> @@ -7,6 +7,8 @@
> =C2=A0#ifndef __ARCH_BLACKFIN_ATOMIC__
> =C2=A0#define __ARCH_BLACKFIN_ATOMIC__
>
> +#include <asm/cmpxchg.h>
> +
> =C2=A0#ifdef CONFIG_SMP
>
> =C2=A0#include <linux/linkage.h>
> diff --git a/arch/blackfin/include/asm/barrier.h b/arch/blackfin/incl=
ude/asm/barrier.h
> new file mode 100644
> index 0000000..ebb1895
> --- /dev/null
> +++ b/arch/blackfin/include/asm/barrier.h
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright 2004-2009 Analog Devices Inc.
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tony Kou (tonyko=
@lineo.ca)
> + *
> + * Licensed under the GPL-2 or later
> + */
> +
> +#ifndef _BLACKFIN_BARRIER_H
> +#define _BLACKFIN_BARRIER_H
> +
> +#include <asm/cache.h>
> +
> +#define nop() =C2=A0__asm__ __volatile__ ("nop;\n\t" : : )
> +
> +/*
> + * Force strict CPU ordering.
> + */
> +#ifdef CONFIG_SMP
> +
> +#ifdef __ARCH_SYNC_CORE_DCACHE
> +/* Force Core data cache coherence */
> +# define mb() =C2=A0do { barrier(); smp_check_barrier(); smp_mark_ba=
rrier(); } while (0)
> +# define rmb() do { barrier(); smp_check_barrier(); } while (0)
> +# define wmb() do { barrier(); smp_mark_barrier(); } while (0)
> +# define read_barrier_depends() =C2=A0 =C2=A0 =C2=A0 =C2=A0do { barr=
ier(); smp_check_barrier(); } while (0)
> +#else
> +# define mb() =C2=A0barrier()
> +# define rmb() barrier()
> +# define wmb() barrier()
> +# define read_barrier_depends() =C2=A0 =C2=A0 =C2=A0 =C2=A0do { } wh=
ile (0)
> +#endif
> +
> +#else /* !CONFIG_SMP */
> +
> +#define mb() =C2=A0 barrier()
> +#define rmb() =C2=A0barrier()
> +#define wmb() =C2=A0barrier()
> +#define read_barrier_depends() do { } while (0)
> +
> +#endif /* !CONFIG_SMP */
> +
> +#define smp_mb() =C2=A0mb()
> +#define smp_rmb() rmb()
> +#define smp_wmb() wmb()
> +#define set_mb(var, value) do { var =3D value; mb(); } while (0)
> +#define smp_read_barrier_depends() =C2=A0 =C2=A0 read_barrier_depend=
s()
> +
> +#endif /* _BLACKFIN_BARRIER_H */
> diff --git a/arch/blackfin/include/asm/cmpxchg.h b/arch/blackfin/incl=
ude/asm/cmpxchg.h
> new file mode 100644
> index 0000000..ba2484f
> --- /dev/null
> +++ b/arch/blackfin/include/asm/cmpxchg.h
> @@ -0,0 +1,132 @@
> +/*
> + * Copyright 2004-2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#ifndef __ARCH_BLACKFIN_CMPXCHG__
> +#define __ARCH_BLACKFIN_CMPXCHG__
> +
> +#ifdef CONFIG_SMP
> +
> +#include <linux/linkage.h>
> +
> +asmlinkage unsigned long __raw_xchg_1_asm(volatile void *ptr, unsign=
ed long value);
> +asmlinkage unsigned long __raw_xchg_2_asm(volatile void *ptr, unsign=
ed long value);
> +asmlinkage unsigned long __raw_xchg_4_asm(volatile void *ptr, unsign=
ed long value);
> +asmlinkage unsigned long __raw_cmpxchg_1_asm(volatile void *ptr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigne=
d long new, unsigned long old);
> +asmlinkage unsigned long __raw_cmpxchg_2_asm(volatile void *ptr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigne=
d long new, unsigned long old);
> +asmlinkage unsigned long __raw_cmpxchg_4_asm(volatile void *ptr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigne=
d long new, unsigned long old);
> +
> +static inline unsigned long __xchg(unsigned long x, volatile void *p=
tr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (size) {
> + =C2=A0 =C2=A0 =C2=A0 case 1:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_xchg=
_1_asm(ptr, x);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 2:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_xchg=
_2_asm(ptr, x);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 4:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_xchg=
_4_asm(ptr, x);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return tmp;
> +}
> +
> +/*
> + * Atomic compare and exchange. =C2=A0Compare OLD with MEM, if ident=
ical,
> + * store NEW in MEM. =C2=A0Return the initial value in MEM. =C2=A0Su=
ccess is
> + * indicated by comparing RETURN with OLD.
> + */
> +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned l=
ong old,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long =
new, int size)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (size) {
> + =C2=A0 =C2=A0 =C2=A0 case 1:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_cmpx=
chg_1_asm(ptr, new, old);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 2:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_cmpx=
chg_2_asm(ptr, new, old);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 4:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_cmpx=
chg_4_asm(ptr, new, old);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return tmp;
> +}
> +#define cmpxchg(ptr, o, n) \
> + =C2=A0 =C2=A0 =C2=A0 ((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigne=
d long)(o), \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long)(n)=
, sizeof(*(ptr))))
> +
> +#else /* !CONFIG_SMP */
> +
> +#include <mach/blackfin.h>
> +#include <asm/irqflags.h>
> +
> +struct __xchg_dummy {
> + =C2=A0 =C2=A0 =C2=A0 unsigned long a[100];
> +};
> +#define __xg(x) ((volatile struct __xchg_dummy *)(x))
> +
> +static inline unsigned long __xchg(unsigned long x, volatile void *p=
tr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long tmp =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 flags =3D hard_local_irq_save();
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (size) {
> + =C2=A0 =C2=A0 =C2=A0 case 1:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile=
__
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ("%0 =3D b%2 (z);\n\t"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"b%2 =3D %1;\n\t"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0: "=3D&d" (tmp) : "d" (x), "m" (*__xg(ptr)) : "memory");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 2:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile=
__
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ("%0 =3D w%2 (z);\n\t"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"w%2 =3D %1;\n\t"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0: "=3D&d" (tmp) : "d" (x), "m" (*__xg(ptr)) : "memory");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 4:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile=
__
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ("%0 =3D %2;\n\t"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"%2 =3D %1;\n\t"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0: "=3D&d" (tmp) : "d" (x), "m" (*__xg(ptr)) : "memory");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_restore(flags);
> + =C2=A0 =C2=A0 =C2=A0 return tmp;
> +}
> +
> +#include <asm-generic/cmpxchg-local.h>
> +
> +/*
> + * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Alw=
ays make
> + * them available.
> + */
> +#define cmpxchg_local(ptr, o, n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 ((__typeof__(*(ptr)))__cmpxchg_local_generic((=
ptr), (unsigned long)(o),\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (unsigned long)(n), sizeof(*(ptr))))
> +#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), =
(o), (n))
> +
> +#include <asm-generic/cmpxchg.h>
> +
> +#endif /* !CONFIG_SMP */
> +
> +#define xchg(ptr, x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),=
 (ptr), sizeof(*(ptr))))
> +#define tas(ptr) ((void)xchg((ptr), 1))
> +
> +#endif /* __ARCH_BLACKFIN_CMPXCHG__ */
> diff --git a/arch/blackfin/include/asm/exec.h b/arch/blackfin/include=
/asm/exec.h
> new file mode 100644
> index 0000000..54c2e1d
> --- /dev/null
> +++ b/arch/blackfin/include/asm/exec.h
> @@ -0,0 +1 @@
> +/* define arch_align_stack() here */
> diff --git a/arch/blackfin/include/asm/irq_handler.h b/arch/blackfin/=
include/asm/irq_handler.h
> index ee73f79..4fbf835 100644
> --- a/arch/blackfin/include/asm/irq_handler.h
> +++ b/arch/blackfin/include/asm/irq_handler.h
> @@ -9,6 +9,7 @@
>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/linkage.h>
> +#include <mach/irq.h>
>
> =C2=A0/* init functions only */
> =C2=A0extern int __init init_arch_irq(void);
> diff --git a/arch/blackfin/include/asm/switch_to.h b/arch/blackfin/in=
clude/asm/switch_to.h
> new file mode 100644
> index 0000000..aaf671b
> --- /dev/null
> +++ b/arch/blackfin/include/asm/switch_to.h
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright 2004-2009 Analog Devices Inc.
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tony Kou (tonyko=
@lineo.ca)
> + *
> + * Licensed under the GPL-2 or later
> + */
> +
> +#ifndef _BLACKFIN_SWITCH_TO_H
> +#define _BLACKFIN_SWITCH_TO_H
> +
> +#define prepare_to_switch() =C2=A0 =C2=A0 do { } while(0)
> +
> +/*
> + * switch_to(n) should switch tasks to task ptr, first checking that
> + * ptr isn't the current task, in which case it does nothing.
> + */
> +
> +#include <asm/l1layout.h>
> +#include <asm/mem_map.h>
> +
> +asmlinkage struct task_struct *resume(struct task_struct *prev, stru=
ct task_struct *next);
> +
> +#ifndef CONFIG_SMP
> +#define switch_to(prev,next,last) \
> +do { =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 memcpy (&task_thread_info(prev)->l1_task_info,=
 L1_SCRATCH_TASK_INFO, \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof *L1_SCRATCH=
_TASK_INFO); \
> + =C2=A0 =C2=A0 =C2=A0 memcpy (L1_SCRATCH_TASK_INFO, &task_thread_inf=
o(next)->l1_task_info, \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof *L1_SCRATCH=
_TASK_INFO); \
> + =C2=A0 =C2=A0 =C2=A0 (last) =3D resume (prev, next); =C2=A0 \
> +} while (0)
> +#else
> +#define switch_to(prev, next, last) \
> +do { =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 (last) =3D resume(prev, next); =C2=A0 \
> +} while (0)
> +#endif
> +
> +#endif /* _BLACKFIN_SWITCH_TO_H */
> diff --git a/arch/blackfin/include/asm/system.h b/arch/blackfin/inclu=
de/asm/system.h
> index 44bd0cc..a7f4057 100644
> --- a/arch/blackfin/include/asm/system.h
> +++ b/arch/blackfin/include/asm/system.h
> @@ -1,192 +1,5 @@
> -/*
> - * Copyright 2004-2009 Analog Devices Inc.
> - * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tony Kou (tonyko=
@lineo.ca)
> - *
> - * Licensed under the GPL-2 or later
> - */
> -
> -#ifndef _BLACKFIN_SYSTEM_H
> -#define _BLACKFIN_SYSTEM_H
> -
> -#include <linux/linkage.h>
> -#include <linux/irqflags.h>
> -#include <mach/anomaly.h>
> -#include <asm/cache.h>
> -#include <asm/pda.h>
> -#include <asm/irq.h>
> -
> -/*
> - * Force strict CPU ordering.
> - */
> -#define nop() =C2=A0__asm__ __volatile__ ("nop;\n\t" : : )
> -#define smp_mb() =C2=A0mb()
> -#define smp_rmb() rmb()
> -#define smp_wmb() wmb()
> -#define set_mb(var, value) do { var =3D value; mb(); } while (0)
> -#define smp_read_barrier_depends() =C2=A0 =C2=A0 read_barrier_depend=
s()
> -
> -#ifdef CONFIG_SMP
> -asmlinkage unsigned long __raw_xchg_1_asm(volatile void *ptr, unsign=
ed long value);
> -asmlinkage unsigned long __raw_xchg_2_asm(volatile void *ptr, unsign=
ed long value);
> -asmlinkage unsigned long __raw_xchg_4_asm(volatile void *ptr, unsign=
ed long value);
> -asmlinkage unsigned long __raw_cmpxchg_1_asm(volatile void *ptr,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigne=
d long new, unsigned long old);
> -asmlinkage unsigned long __raw_cmpxchg_2_asm(volatile void *ptr,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigne=
d long new, unsigned long old);
> -asmlinkage unsigned long __raw_cmpxchg_4_asm(volatile void *ptr,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigne=
d long new, unsigned long old);
> -
> -#ifdef __ARCH_SYNC_CORE_DCACHE
> -/* Force Core data cache coherence */
> -# define mb() =C2=A0do { barrier(); smp_check_barrier(); smp_mark_ba=
rrier(); } while (0)
> -# define rmb() do { barrier(); smp_check_barrier(); } while (0)
> -# define wmb() do { barrier(); smp_mark_barrier(); } while (0)
> -# define read_barrier_depends() =C2=A0 =C2=A0 =C2=A0 =C2=A0do { barr=
ier(); smp_check_barrier(); } while (0)
> -#else
> -# define mb() =C2=A0barrier()
> -# define rmb() barrier()
> -# define wmb() barrier()
> -# define read_barrier_depends() =C2=A0 =C2=A0 =C2=A0 =C2=A0do { } wh=
ile (0)
> -#endif
> -
> -static inline unsigned long __xchg(unsigned long x, volatile void *p=
tr,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size)
> -{
> - =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;
> -
> - =C2=A0 =C2=A0 =C2=A0 switch (size) {
> - =C2=A0 =C2=A0 =C2=A0 case 1:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_xchg=
_1_asm(ptr, x);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 2:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_xchg=
_2_asm(ptr, x);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 4:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_xchg=
_4_asm(ptr, x);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return tmp;
> -}
> -
> -/*
> - * Atomic compare and exchange. =C2=A0Compare OLD with MEM, if ident=
ical,
> - * store NEW in MEM. =C2=A0Return the initial value in MEM. =C2=A0Su=
ccess is
> - * indicated by comparing RETURN with OLD.
> - */
> -static inline unsigned long __cmpxchg(volatile void *ptr, unsigned l=
ong old,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long =
new, int size)
> -{
> - =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;
> -
> - =C2=A0 =C2=A0 =C2=A0 switch (size) {
> - =C2=A0 =C2=A0 =C2=A0 case 1:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_cmpx=
chg_1_asm(ptr, new, old);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 2:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_cmpx=
chg_2_asm(ptr, new, old);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 4:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_cmpx=
chg_4_asm(ptr, new, old);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return tmp;
> -}
> -#define cmpxchg(ptr, o, n) \
> - =C2=A0 =C2=A0 =C2=A0 ((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigne=
d long)(o), \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long)(n)=
, sizeof(*(ptr))))
> -
> -#else /* !CONFIG_SMP */
> -
> -#define mb() =C2=A0 barrier()
> -#define rmb() =C2=A0barrier()
> -#define wmb() =C2=A0barrier()
> -#define read_barrier_depends() do { } while (0)
> -
> -struct __xchg_dummy {
> - =C2=A0 =C2=A0 =C2=A0 unsigned long a[100];
> -};
> -#define __xg(x) ((volatile struct __xchg_dummy *)(x))
> -
> -#include <mach/blackfin.h>
> -
> -static inline unsigned long __xchg(unsigned long x, volatile void *p=
tr,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size)
> -{
> - =C2=A0 =C2=A0 =C2=A0 unsigned long tmp =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> -
> - =C2=A0 =C2=A0 =C2=A0 flags =3D hard_local_irq_save();
> -
> - =C2=A0 =C2=A0 =C2=A0 switch (size) {
> - =C2=A0 =C2=A0 =C2=A0 case 1:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile=
__
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ("%0 =3D b%2 (z);\n\t"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"b%2 =3D %1;\n\t"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0: "=3D&d" (tmp) : "d" (x), "m" (*__xg(ptr)) : "memory");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 2:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile=
__
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ("%0 =3D w%2 (z);\n\t"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"w%2 =3D %1;\n\t"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0: "=3D&d" (tmp) : "d" (x), "m" (*__xg(ptr)) : "memory");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 4:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__ __volatile=
__
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ("%0 =3D %2;\n\t"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"%2 =3D %1;\n\t"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0: "=3D&d" (tmp) : "d" (x), "m" (*__xg(ptr)) : "memory");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 hard_local_irq_restore(flags);
> - =C2=A0 =C2=A0 =C2=A0 return tmp;
> -}
> -
> -#include <asm-generic/cmpxchg-local.h>
> -
> -/*
> - * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Alw=
ays make
> - * them available.
> - */
> -#define cmpxchg_local(ptr, o, n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> - =C2=A0 =C2=A0 =C2=A0 ((__typeof__(*(ptr)))__cmpxchg_local_generic((=
ptr), (unsigned long)(o),\
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (unsigned long)(n), sizeof(*(ptr))))
> -#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), =
(o), (n))
> -
> -#include <asm-generic/cmpxchg.h>
> -
> -#endif /* !CONFIG_SMP */
> -
> -#define xchg(ptr, x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),=
 (ptr), sizeof(*(ptr))))
> -#define tas(ptr) ((void)xchg((ptr), 1))
> -
> -#define prepare_to_switch() =C2=A0 =C2=A0 do { } while(0)
> -
> -/*
> - * switch_to(n) should switch tasks to task ptr, first checking that
> - * ptr isn't the current task, in which case it does nothing.
> - */
> -
> -#include <asm/l1layout.h>
> -#include <asm/mem_map.h>
> -
> -asmlinkage struct task_struct *resume(struct task_struct *prev, stru=
ct task_struct *next);
> -
> -#ifndef CONFIG_SMP
> -#define switch_to(prev,next,last) \
> -do { =C2=A0 =C2=A0\
> - =C2=A0 =C2=A0 =C2=A0 memcpy (&task_thread_info(prev)->l1_task_info,=
 L1_SCRATCH_TASK_INFO, \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof *L1_SCRATCH=
_TASK_INFO); \
> - =C2=A0 =C2=A0 =C2=A0 memcpy (L1_SCRATCH_TASK_INFO, &task_thread_inf=
o(next)->l1_task_info, \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof *L1_SCRATCH=
_TASK_INFO); \
> - =C2=A0 =C2=A0 =C2=A0 (last) =3D resume (prev, next); =C2=A0 \
> -} while (0)
> -#else
> -#define switch_to(prev, next, last) \
> -do { =C2=A0 =C2=A0\
> - =C2=A0 =C2=A0 =C2=A0 (last) =3D resume(prev, next); =C2=A0 \
> -} while (0)
> -#endif
> -
> -#endif /* _BLACKFIN_SYSTEM_H */
> +/* FILE TO BE DELETED. DO NOT ADD STUFF HERE! */
> +#include <asm/barrier.h>
> +#include <asm/cmpxchg.h>
> +#include <asm/exec.h>
> +#include <asm/switch_to.h>
> diff --git a/arch/blackfin/kernel/asm-offsets.c b/arch/blackfin/kerne=
l/asm-offsets.c
> index 17e3546..37fcae9 100644
> --- a/arch/blackfin/kernel/asm-offsets.c
> +++ b/arch/blackfin/kernel/asm-offsets.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/irq.h>
> =C2=A0#include <linux/thread_info.h>
> =C2=A0#include <linux/kbuild.h>
> +#include <asm/pda.h>
>
> =C2=A0int main(void)
> =C2=A0{
> diff --git a/arch/blackfin/kernel/ipipe.c b/arch/blackfin/kernel/ipip=
e.c
> index dbe1122..f657b38 100644
> --- a/arch/blackfin/kernel/ipipe.c
> +++ b/arch/blackfin/kernel/ipipe.c
> @@ -31,7 +31,6 @@
> =C2=A0#include <linux/kthread.h>
> =C2=A0#include <linux/unistd.h>
> =C2=A0#include <linux/io.h>
> -#include <asm/system.h>
> =C2=A0#include <linux/atomic.h>
> =C2=A0#include <asm/irq_handler.h>
>
> diff --git a/arch/blackfin/kernel/kgdb_test.c b/arch/blackfin/kernel/=
kgdb_test.c
> index 4a7dcfe..18ab004 100644
> --- a/arch/blackfin/kernel/kgdb_test.c
> +++ b/arch/blackfin/kernel/kgdb_test.c
> @@ -13,7 +13,6 @@
>
> =C2=A0#include <asm/current.h>
> =C2=A0#include <asm/uaccess.h>
> -#include <asm/system.h>
>
> =C2=A0#include <asm/blackfin.h>
>
> diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/pr=
ocess.c
> index 8dd0416..8c5369c 100644
> --- a/arch/blackfin/kernel/process.c
> +++ b/arch/blackfin/kernel/process.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <asm/blackfin.h>
> =C2=A0#include <asm/fixed_code.h>
> =C2=A0#include <asm/mem_map.h>
> +#include <asm/irq.h>
>
> =C2=A0asmlinkage void ret_from_fork(void);
>
> diff --git a/arch/blackfin/kernel/ptrace.c b/arch/blackfin/kernel/ptr=
ace.c
> index 75089f8..e1f88e0 100644
> --- a/arch/blackfin/kernel/ptrace.c
> +++ b/arch/blackfin/kernel/ptrace.c
> @@ -20,7 +20,6 @@
>
> =C2=A0#include <asm/page.h>
> =C2=A0#include <asm/pgtable.h>
> -#include <asm/system.h>
> =C2=A0#include <asm/processor.h>
> =C2=A0#include <asm/asm-offsets.h>
> =C2=A0#include <asm/dma.h>
> diff --git a/arch/blackfin/kernel/reboot.c b/arch/blackfin/kernel/reb=
oot.c
> index c4c0081..b0434f8 100644
> --- a/arch/blackfin/kernel/reboot.c
> +++ b/arch/blackfin/kernel/reboot.c
> @@ -9,7 +9,6 @@
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <asm/bfin-global.h>
> =C2=A0#include <asm/reboot.h>
> -#include <asm/system.h>
> =C2=A0#include <asm/bfrom.h>
>
> =C2=A0/* A system soft reset makes external memory unusable so force
> diff --git a/arch/blackfin/kernel/setup.c b/arch/blackfin/kernel/setu=
p.c
> index d6102c8..2aa0193 100644
> --- a/arch/blackfin/kernel/setup.c
> +++ b/arch/blackfin/kernel/setup.c
> @@ -30,6 +30,7 @@
> =C2=A0#include <asm/fixed_code.h>
> =C2=A0#include <asm/early_printk.h>
> =C2=A0#include <asm/irq_handler.h>
> +#include <asm/pda.h>
>
> =C2=A0u16 _bfin_swrst;
> =C2=A0EXPORT_SYMBOL(_bfin_swrst);
> diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trac=
e.c
> index 050db44..44bbf2f 100644
> --- a/arch/blackfin/kernel/trace.c
> +++ b/arch/blackfin/kernel/trace.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <asm/fixed_code.h>
> =C2=A0#include <asm/traps.h>
> =C2=A0#include <asm/irq_handler.h>
> +#include <asm/pda.h>
>
> =C2=A0void decode_address(char *buf, unsigned long address)
> =C2=A0{
> diff --git a/arch/blackfin/kernel/traps.c b/arch/blackfin/kernel/trap=
s.c
> index 655f25d..de5c2c3 100644
> --- a/arch/blackfin/kernel/traps.c
> +++ b/arch/blackfin/kernel/traps.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <asm/trace.h>
> =C2=A0#include <asm/fixed_code.h>
> =C2=A0#include <asm/pseudo_instructions.h>
> +#include <asm/pda.h>
>
> =C2=A0#ifdef CONFIG_KGDB
> =C2=A0# include <linux/kgdb.h>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/



--=20
Regards,
--Bob
