From: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
Date: Fri, 11 Nov 2011 13:28:14 +0100
Message-ID: <1321014494.2745.7.camel@br98xy6r>
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
 <1320934932.16425.14.camel@br98xy6r> <4EBBE9B4.3040009@tilera.com>
Reply-To: holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <4EBBE9B4.3040009-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chen Liqin <liqin.chen-+XGAvkf1AAHby3iVrkZq2A@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hello Chris,

On Thu, 2011-11-10 at 10:11 -0500, Chris Metcalf wrote:
> On 11/10/2011 9:22 AM, Michael Holzheu wrote:

[snip]

> If a cleaner API seems useful (either for power reasons or restartability 
> or whatever), I suppose a standard global function name could be specified 
> that's the thing you execute when you get an smp_send_stop IPI (in tile's 
> case it's "smp_stop_cpu_interrupt()") and the panic() code could instead 
> just do an atomic_inc_return() of a global panic counter, and if it wasn't 
> the first panicking cpu, call directly into the smp_stop handler routine to 
> quiesce itself.  Then the panicking cpu could finish whatever it needs to 
> do and then halt, reboot, etc., all the cpus.

Thanks for the info. So introducing a "weak" function that can stop the
CPU it is running on could solve the problem. Every architecture can
override the function with something appropriate. E.g. "tile" can use
the lower-power "nap" instruction there.

What about the following patch.

Michael
---
From: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: kdump: fix crash_kexec()/smp_send_stop() race in panic

When two CPUs call panic at the same time there is a possible race
condition that can stop kdump.  The first CPU calls crash_kexec() and the
second CPU calls smp_send_stop() in panic() before crash_kexec() finished
on the first CPU.  So the second CPU stops the first CPU and therefore
kdump fails:

1st CPU:
panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump

2nd CPU:
panic()->crash_kexec()->kexec_mutex already held by 1st CPU
       ->smp_send_stop()-> stop 1st CPU (stop kdump)

This patch fixes the problem by introducing a spinlock in panic that
allows only one CPU to process crash_kexec() and the subsequent panic
code.

Signed-off-by: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 kernel/panic.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -49,6 +49,15 @@ static long no_blink(int state)
 long (*panic_blink)(int state);
 EXPORT_SYMBOL(panic_blink);
 
+/*
+ * Stop ourself in panic -- architecture code may override this
+ */
+void __attribute__ ((weak)) panic_smp_self_stop(void)
+{
+	while (1)
+		cpu_relax();
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -59,6 +68,7 @@ EXPORT_SYMBOL(panic_blink);
  */
 NORET_TYPE void panic(const char * fmt, ...)
 {
+	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0;
@@ -68,8 +78,14 @@ NORET_TYPE void panic(const char * fmt,
 	 * It's possible to come here directly from a panic-assertion and
 	 * not have preempt disabled. Some functions called from here want
 	 * preempt to be disabled. No point enabling it later though...
+	 *
+	 * Only one CPU is allowed to execute the panic code from here. For
+	 * multiple parallel invocations of panic, all other CPUs either
+	 * stop themself or will wait until they are stopped by the 1st CPU
+	 * with smp_send_stop().
 	 */
-	preempt_disable();
+	if (!spin_trylock(&panic_lock))
+		panic_smp_self_stop();
 
 	console_verbose();
 	bust_spinlocks(1);
