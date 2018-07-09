From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and
 alignment
Date: Mon, 9 Jul 2018 15:35:42 +0200
Message-ID: <20180709133542.GP2476@hirez.programming.kicks-ass.net>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180709124741.21037-1-abrodkin@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>, Arnd Bergmann <arnd@arndb.de>, Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-snps-arc@lists.infradead.org, Shuah Khan <shuah@kernel.org>, Josh Triplett <josh@joshtriplett.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 09, 2018 at 03:47:41PM +0300, Alexey Brodkin wrote:
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 8d28eb010d0d..b94b749b5952 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -13,7 +13,7 @@
>  #define _ASM_GENERIC_ATOMIC64_H
>  
>  typedef struct {
> -	long long counter;
> +	u64 __aligned(8) counter;
>  } atomic64_t;

The type is wrong, atomic is signed, the alignment also really doesn't
matter, generic atomic64 is utter crap.

>  #define ATOMIC64_INIT(i)	{ (i) }
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 9834e90aa010..e2f631782621 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -174,12 +174,12 @@ typedef phys_addr_t resource_size_t;
>  typedef unsigned long irq_hw_number_t;
>  
>  typedef struct {
> -	int counter;
> +	u32 __aligned(4) counter;
>  } atomic_t;

u32 is wrong, the atomic type is signed.

Also, if an architecture doesn't properly align its native machine word
size but requires alignment for atomics it's a broken architecture.

>  
>  #ifdef CONFIG_64BIT
>  typedef struct {
> -	long counter;
> +	u64 __aligned(8) counter;
>  } atomic64_t;
>  #endif
>  

Similar for this one, on 64bit archs that support atomics the native
64bit types (long included) had better already imply this alignment.
