From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and
 alignment
Date: Mon, 9 Jul 2018 14:07:39 +0100
Message-ID: <20180709130738.GA28336@arm.com>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709124741.21037-1-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, David Laight <David.Laight@ACULAB.COM>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

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

Long long is 8-byte aligned per EABI ARM, and we use the generic atomic64
infrastructure for OABI, so we don't need to change anything here afaict.

Will
