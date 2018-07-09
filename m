Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34038 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbeGIOEi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 10:04:38 -0400
Date: Mon, 9 Jul 2018 15:04:21 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and
 alignment
Message-ID: <20180709140421.GF17271@n2100.armlinux.org.uk>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709124741.21037-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, David Laight <David.Laight@ACULAB.COM>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <20180709140421.8_FUaD-APFNIOAbJQaZSdRyBdbbRmBfcJ7IYC2gNaeY@z>

On Mon, Jul 09, 2018 at 03:47:41PM +0300, Alexey Brodkin wrote:
> Atomic instructions require data they operate on to be aligned
> according to data size. I.e. 32-bit atomic values must be 32-bit
> aligned while 64-bit values must be 64-bit aligned.
> 
> Otherwise even if CPU may handle not-aligend normal data access,
> still atomic instructions fail and typically raise an exception
> leaving us dead in the water.
> 
> This came-up during lengthly discussion here:
> http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004022.html
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm/include/asm/atomic.h                                 | 2 +-
>  include/asm-generic/atomic64.h                                | 2 +-
>  include/linux/types.h                                         | 4 ++--
>  tools/include/linux/types.h                                   | 2 +-
>  tools/testing/selftests/futex/include/atomic.h                | 2 +-
>  .../rcutorture/formal/srcu-cbmc/include/linux/types.h         | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index 66d0e215a773..2ed6d7cf1407 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -267,7 +267,7 @@ ATOMIC_OPS(xor, ^=, eor)
>  
>  #ifndef CONFIG_GENERIC_ATOMIC64
>  typedef struct {
> -	long long counter;
> +	u64 __aligned(8) counter;
>  } atomic64_t;

ARM doesn't need or require this change, and you're changing the type
from signed to unsigned, which is likely to break stuff.  So, NAK on
this from the ARM point of view.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
