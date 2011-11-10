From: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
Date: Thu, 10 Nov 2011 15:22:12 +0100
Message-ID: <1320934932.16425.14.camel@br98xy6r>
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
Reply-To: holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20111109160400.cc2d27d9.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Richard Henderson <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Haavard Skinnemoen <hskinnemoe>
Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Luck,
 Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2011-11-09 at 16:04 -0800, Andrew Morton wrote:
> On Thu, 03 Nov 2011 11:07:24 +0100
> Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:

[snip]

> Ho hum, I guess we stick with the original patch.  It *should* work, as
> long as all archtectures are doing the expected thing.  But in this
> situation it is bad of us to just hope that the architectures are doing
> this.  We should go and find out, rather than waiting for bug reports
> to come in.  Especially because in this case, bugs will take a very
> long time indeed to even be noticed.
> 
> One way to resolve this would be to ask the various arch maintainers!

Hello arch maintainers (from scripts/get_maintainer.pl),

Andrew asked me to contact you in this case.

The main concern of the patch below is that smp_send_stop() might not be
able to stop irq-disabled CPUs. So when two CPUs enter in parallel
panic() and the 2nd one has irqs disabled, with my patch below, perhaps
the 2nd CPU can't be stopped. On s390 and also on x86 (with a patch from
Don Zickus) this is not a problem.

Could you please look at the patch and tell me, if it will work on your
architecture or not. If not, perhaps you have a better idea to solve the
problem.

Michael
---
From: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

When two CPUs call panic at the same time there is a
possible race condition that can stop kdump. The first
CPU calls crash_kexec() and the second CPU calls
smp_send_stop() in panic() before crash_kexec() finished
on the first CPU. So the second CPU stops the first CPU
and therefore kdump fails:

1st CPU:
panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump

2nd CPU:
panic()->crash_kexec()->kexec_mutex already held by 1st CPU
       ->smp_send_stop()-> stop 1st CPU (stop kdump)

This patch fixes the problem by introducing a spinlock in
panic that allows only one CPU to process crash_kexec() and
the subsequent panic code.

Signed-off-by: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 kernel/panic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -59,6 +59,7 @@ EXPORT_SYMBOL(panic_blink);
  */
 NORET_TYPE void panic(const char * fmt, ...)
 {
+	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0;
@@ -82,6 +83,13 @@ NORET_TYPE void panic(const char * fmt,
 #endif
 
 	/*
+	 * Only one CPU is allowed to execute the panic code from here. For
+	 * multiple parallel invocations of panic all other CPUs will wait on
+	 * the panic_lock. They are stopped afterwards by smp_send_stop().
+	 */
+	spin_lock(&panic_lock);
+
+	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
 	 * Do we want to call this before we try to display a message?
