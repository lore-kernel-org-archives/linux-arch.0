Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:60188 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760409AbcALQkI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2016 11:40:08 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 12 Jan 2016 09:40:07 -0700
Date: Tue, 12 Jan 2016 08:31:02 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 05/41] powerpc: reuse asm-generic/barrier.h
Message-ID: <20160112163102.GE3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-6-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-6-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Message-ID: <20160112163102.2JL3n4Hz2xY0QfkdHvm9jTclyVQlcavnaMWczBkVK_g@z>

On Sun, Jan 10, 2016 at 04:17:09PM +0200, Michael S. Tsirkin wrote:
> On powerpc read_barrier_depends, smp_read_barrier_depends
> smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
> asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks sane to me.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/barrier.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index a7af5fb..980ad0c 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -34,8 +34,6 @@
>  #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> 
> -#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
> -
>  #ifdef __SUBARCH_HAS_LWSYNC
>  #    define SMPWMB      LWSYNC
>  #else
> @@ -60,9 +58,6 @@
>  #define smp_wmb()	barrier()
>  #endif /* CONFIG_SMP */
> 
> -#define read_barrier_depends()		do { } while (0)
> -#define smp_read_barrier_depends()	do { } while (0)
> -
>  /*
>   * This is a barrier which prevents following instructions from being
>   * started until the value of the argument x is known.  For example, if
> @@ -87,8 +82,8 @@ do {									\
>  	___p1;								\
>  })
> 
> -#define smp_mb__before_atomic()     smp_mb()
> -#define smp_mb__after_atomic()      smp_mb()
>  #define smp_mb__before_spinlock()   smp_mb()
> 
> +#include <asm-generic/barrier.h>
> +
>  #endif /* _ASM_POWERPC_BARRIER_H */
> -- 
> MST
> 

