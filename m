From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 17/76] ARC: Process-creation/scheduling/idle-loop
Date: Mon, 21 Jan 2013 16:49:14 +0530
Message-ID: <50FD2432.8010201@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-18-git-send-email-vgupta@synopsys.com> <201301181435.15491.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201301181435.15491.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Friday 18 January 2013 08:05 PM, Arnd Bergmann wrote:
> On Friday 18 January 2013, Vineet Gupta wrote:
>> +void cpu_idle(void)
>> +{
>> +       /* Since we SLEEP in idle loop, TIF_POLLING_NRFLAG can't be set */
>> +
>> +       /* endless idle loop with no priority at all */
>> +       while (1) {
>> +               tick_nohz_idle_enter();
>> +               rcu_idle_enter();
>> +
>> +               while (!need_resched())
>> +                       arch_idle();
>> +
>> +               rcu_idle_exit();
>> +               tick_nohz_idle_exit();
>> +
>> +               schedule_preempt_disabled();
>> +       }
>> +}
> Unless I'm mistaken, you have introduced the classic sleep race
> here, where an interrupt can happen between the check for
> need_resched() and the sleep instruction in arch_idle().

Hmm... there is indeed a race - so we could end up missing a reschedule
opportunity, for until next interrupt (so next tick, if NOHZ is not enabled, and
indefinitely if system has no other interrupting sources).


> To avoid that, you need to disable interrupts around
> the inner loop. The sleep instruction should return with
> interrupts implicitly enabled if ARC behaves like most
> other architectures doing this.
>
> 	Arnd

Indeed sleep has option to turn on interrupts before it commits - so this is
certainly doable.

 static inline void arch_idle(void)
 {
-       __asm__("sleep");
+       /* sleep, but enable all interrupts before committing */
+       __asm__("sleep 0x3");
 }


-               while (!need_resched())
+doze:
+               local_irq_disable();
+               if (!need_resched()) {
                        arch_idle();
+                       goto doze;
+               } else {
+                       local_irq_enable();
+               }


Thx,
-Vineet
