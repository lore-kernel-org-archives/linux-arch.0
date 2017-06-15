From: Babu Moger <babu.moger@oracle.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Wed, 14 Jun 2017 21:16:04 -0500
Message-ID: <fc41c166-7db1-79d2-da01-cbcb412952c9@oracle.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170530012659.16791-4-npiggin@gmail.com>
 <20170602201500.urllmug33bjtuzen@redhat.com>
 <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
 <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
 <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
 <20170608160502.uzp7vmr7s4fj6hjm@redhat.com>
 <20170612180739.1aa4b123@roar.ozlabs.ibm.com>
 <20170612204156.ov7ka2765t4gdakl@redhat.com>
 <20170614021118.4bbfd00f@roar.ozlabs.ibm.com>
 <20170614140937.qrkajknqxldwdkv2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:50630 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdFOCQQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2017 22:16:16 -0400
In-Reply-To: <20170614140937.qrkajknqxldwdkv2@redhat.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Don,

On 6/14/2017 9:09 AM, Don Zickus wrote:
> On Wed, Jun 14, 2017 at 02:11:18AM +1000, Nicholas Piggin wrote:
>>> Yeah, if you wouldn't mind.  Sorry for dragging this out, but I feel like we
>>> are getting close to have this defined properly which would allow us to
>>> split the code up correctly in the future.
>> How's this for a replacement patch 3? I think the Kconfig works out much
>> better now.
> Hi Nick,
>
> I think you made this much clearer, thank you!  I am good with this.
>
>
> Hi Babu,
>
> Can you give this patchset (and particularly this version of patch 3) a try
> on sparc to make sure we didn't break anything?  I believe this should
> resolve the start nmi watchdog on boot issue you noticed.  Thanks!

There is still one problem with the patch.

# cat /proc/sys/kernel/watchdog
1
# cat /proc/sys/kernel/nmi_watchdog
0

Problem is setting the initial value for  "nmi_watchdog"

We need something(or similar) patch on top to address this.
============================================
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5397c63..0105856 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -34,9 +34,13 @@

  int __read_mostly nmi_watchdog_enabled;

-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || 
defined(CONFIG_HAVE_NMI_WATCHDOG)
  unsigned long __read_mostly watchdog_enabled = 
SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
+#else
+unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
+#endif

+#ifdef CONFIG_HARDLOCKUP_DETECTOR
  /* boot commands */
  /*
   * Should we panic when a soft-lockup or hard-lockup occurs:
@@ -69,9 +73,6 @@ static int __init hardlockup_panic_setup(char *str)
         return 1;
  }
  __setup("nmi_watchdog=", hardlockup_panic_setup);
-
-#else
-unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
  #endif

  #ifdef CONFIG_SOFTLOCKUP_DETECTOR


>
> Cheers,
> Don
>
>> --
>>
>> Split SOFTLOCKUP_DETECTOR from LOCKUP_DETECTOR, and split
>> HARDLOCKUP_DETECTOR_PERF from HARDLOCKUP_DETECTOR.
>>
>> LOCKUP_DETECTOR implies the general boot, sysctl, and programming
>> interfaces for the lockup detectors.
>>
>> An architecture that wants to use a hard lockup detector must define
>> HAVE_HARDLOCKUP_DETECTOR_PERF or HAVE_HARDLOCKUP_DETECTOR_ARCH.
>>
>> Alternatively an arch can define HAVE_NMI_WATCHDOG, which provides
>> the minimum arch_touch_nmi_watchdog, and it otherwise does its own
>> thing and does not implement the LOCKUP_DETECTOR interfaces.
>>
>> sparc is unusual in that it has started to implement some of the
>> interfaces, but not fully yet. It should probably be converted to
>> a full HAVE_HARDLOCKUP_DETECTOR_ARCH.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/Kconfig                   |  23 ++++
>>   arch/powerpc/Kconfig           |   1 +
>>   arch/powerpc/kernel/setup_64.c |   2 +-
>>   arch/x86/Kconfig               |   1 +
>>   arch/x86/kernel/apic/hw_nmi.c  |   2 +-
>>   include/linux/nmi.h            |  29 +++--
>>   kernel/Makefile                |   2 +-
>>   kernel/sysctl.c                |  16 +--
>>   kernel/watchdog.c              | 238 ++++++++++++++++++++++++++---------------
>>   kernel/watchdog_hld.c          |  32 ------
>>   lib/Kconfig.debug              |  26 +++--
>>   11 files changed, 231 insertions(+), 141 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 6c00e5b00f8b..878addc6f141 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -288,6 +288,29 @@ config HAVE_PERF_EVENTS_NMI
>>   	  subsystem.  Also has support for calculating CPU cycle events
>>   	  to determine how many clock cycles in a given period.
>>   
>> +
>> +config HAVE_HARDLOCKUP_DETECTOR_PERF
>> +	bool
>> +	depends on HAVE_PERF_EVENTS_NMI
>> +	help
>> +	  The arch chooses to use the generic perf-NMI-based hardlockup
>> +	  detector. Must define HAVE_PERF_EVENTS_NMI.
>> +
>> +config HAVE_NMI_WATCHDOG
>> +	bool
>> +	help
>> +	  The arch provides a low level NMI watchdog. It provides
>> +	  asm/nmi.h, and defines its own arch_touch_nmi_watchdog().
>> +
>> +config HAVE_HARDLOCKUP_DETECTOR_ARCH
>> +	bool
>> +	select HAVE_NMI_WATCHDOG
>> +	help
>> +	  The arch chooses to provide its own hardlockup detector, which is
>> +	  a superset of the HAVE_NMI_WATCHDOG. It also conforms to config
>> +	  interfaces and parameters provided by hardlockup detector subsystem.
>> +
>> +
>>   config HAVE_PERF_REGS
>>   	bool
>>   	help
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index f7c8f9972f61..7aba96ec3378 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -202,6 +202,7 @@ config PPC
>>   	select HAVE_OPTPROBES			if PPC64
>>   	select HAVE_PERF_EVENTS
>>   	select HAVE_PERF_EVENTS_NMI		if PPC64
>> +	select HAVE_HARDLOCKUP_DETECTOR_PERF	if HAVE_PERF_EVENTS_NMI
>>   	select HAVE_PERF_REGS
>>   	select HAVE_PERF_USER_STACK_DUMP
>>   	select HAVE_RCU_TABLE_FREE		if SMP
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>> index f35ff9dea4fb..ab650905f75a 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -727,7 +727,7 @@ struct ppc_pci_io ppc_pci_io;
>>   EXPORT_SYMBOL(ppc_pci_io);
>>   #endif
>>   
>> -#ifdef CONFIG_HARDLOCKUP_DETECTOR
>> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
>>   u64 hw_nmi_get_sample_period(int watchdog_thresh)
>>   {
>>   	return ppc_proc_freq * watchdog_thresh;
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 4ccfacc7232a..3c084149b5d1 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -157,6 +157,7 @@ config X86
>>   	select HAVE_PCSPKR_PLATFORM
>>   	select HAVE_PERF_EVENTS
>>   	select HAVE_PERF_EVENTS_NMI
>> +	select HAVE_HARDLOCKUP_DETECTOR_PERF	if HAVE_PERF_EVENTS_NMI
>>   	select HAVE_PERF_REGS
>>   	select HAVE_PERF_USER_STACK_DUMP
>>   	select HAVE_REGS_AND_STACK_ACCESS_API
>> diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
>> index c73c9fb281e1..d6f387780849 100644
>> --- a/arch/x86/kernel/apic/hw_nmi.c
>> +++ b/arch/x86/kernel/apic/hw_nmi.c
>> @@ -19,7 +19,7 @@
>>   #include <linux/init.h>
>>   #include <linux/delay.h>
>>   
>> -#ifdef CONFIG_HARDLOCKUP_DETECTOR
>> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
>>   u64 hw_nmi_get_sample_period(int watchdog_thresh)
>>   {
>>   	return (u64)(cpu_khz) * 1000 * watchdog_thresh;
>> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
>> index bd387ef8bccd..8aa01fd859fb 100644
>> --- a/include/linux/nmi.h
>> +++ b/include/linux/nmi.h
>> @@ -11,13 +11,21 @@
>>   #endif
>>   
>>   #ifdef CONFIG_LOCKUP_DETECTOR
>> +void lockup_detector_init(void);
>> +#else
>> +static inline void lockup_detector_init(void)
>> +{
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
>>   extern void touch_softlockup_watchdog_sched(void);
>>   extern void touch_softlockup_watchdog(void);
>>   extern void touch_softlockup_watchdog_sync(void);
>>   extern void touch_all_softlockup_watchdogs(void);
>>   extern unsigned int  softlockup_panic;
>> -extern unsigned int  hardlockup_panic;
>> -void lockup_detector_init(void);
>> +extern int soft_watchdog_enabled;
>> +extern atomic_t watchdog_park_in_progress;
>>   #else
>>   static inline void touch_softlockup_watchdog_sched(void)
>>   {
>> @@ -31,9 +39,6 @@ static inline void touch_softlockup_watchdog_sync(void)
>>   static inline void touch_all_softlockup_watchdogs(void)
>>   {
>>   }
>> -static inline void lockup_detector_init(void)
>> -{
>> -}
>>   #endif
>>   
>>   #ifdef CONFIG_DETECT_HUNG_TASK
>> @@ -63,15 +68,18 @@ static inline void reset_hung_task_detector(void)
>>   
>>   #if defined(CONFIG_HARDLOCKUP_DETECTOR)
>>   extern void hardlockup_detector_disable(void);
>> +extern unsigned int hardlockup_panic;
>>   #else
>>   static inline void hardlockup_detector_disable(void) {}
>>   #endif
>>   
>> -#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
>> +#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
>>   extern void arch_touch_nmi_watchdog(void);
>>   #else
>> +#if !defined(CONFIG_HAVE_NMI_WATCHDOG)
>>   static inline void arch_touch_nmi_watchdog(void) {}
>>   #endif
>> +#endif
>>   
>>   /**
>>    * touch_nmi_watchdog - restart NMI watchdog timeout.
>> @@ -141,15 +149,18 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
>>   }
>>   #endif
>>   
>> -#ifdef CONFIG_LOCKUP_DETECTOR
>> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
>>   u64 hw_nmi_get_sample_period(int watchdog_thresh);
>> +#endif
>> +
>> +#ifdef CONFIG_LOCKUP_DETECTOR
>>   extern int nmi_watchdog_enabled;
>> -extern int soft_watchdog_enabled;
>>   extern int watchdog_user_enabled;
>>   extern int watchdog_thresh;
>>   extern unsigned long watchdog_enabled;
>> +extern struct cpumask watchdog_cpumask;
>>   extern unsigned long *watchdog_cpumask_bits;
>> -extern atomic_t watchdog_park_in_progress;
>> +extern int __read_mostly watchdog_suspended;
>>   #ifdef CONFIG_SMP
>>   extern int sysctl_softlockup_all_cpu_backtrace;
>>   extern int sysctl_hardlockup_all_cpu_backtrace;
>> diff --git a/kernel/Makefile b/kernel/Makefile
>> index 72aa080f91f0..4cb8e8b23c6e 100644
>> --- a/kernel/Makefile
>> +++ b/kernel/Makefile
>> @@ -82,7 +82,7 @@ obj-$(CONFIG_KPROBES) += kprobes.o
>>   obj-$(CONFIG_KGDB) += debug/
>>   obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
>>   obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
>> -obj-$(CONFIG_HARDLOCKUP_DETECTOR) += watchdog_hld.o
>> +obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
>>   obj-$(CONFIG_SECCOMP) += seccomp.o
>>   obj-$(CONFIG_RELAY) += relay.o
>>   obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 4dfba1a76cc3..46b189fd865b 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -880,6 +880,14 @@ static struct ctl_table kern_table[] = {
>>   #endif
>>   	},
>>   	{
>> +		.procname	= "watchdog_cpumask",
>> +		.data		= &watchdog_cpumask_bits,
>> +		.maxlen		= NR_CPUS,
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_watchdog_cpumask,
>> +	},
>> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
>> +	{
>>   		.procname       = "soft_watchdog",
>>   		.data           = &soft_watchdog_enabled,
>>   		.maxlen         = sizeof (int),
>> @@ -889,13 +897,6 @@ static struct ctl_table kern_table[] = {
>>   		.extra2		= &one,
>>   	},
>>   	{
>> -		.procname	= "watchdog_cpumask",
>> -		.data		= &watchdog_cpumask_bits,
>> -		.maxlen		= NR_CPUS,
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_watchdog_cpumask,
>> -	},
>> -	{
>>   		.procname	= "softlockup_panic",
>>   		.data		= &softlockup_panic,
>>   		.maxlen		= sizeof(int),
>> @@ -904,6 +905,7 @@ static struct ctl_table kern_table[] = {
>>   		.extra1		= &zero,
>>   		.extra2		= &one,
>>   	},
>> +#endif
>>   #ifdef CONFIG_HARDLOCKUP_DETECTOR
>>   	{
>>   		.procname	= "hardlockup_panic",
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 03e0b69bb5bf..deb010505646 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -29,15 +29,55 @@
>>   #include <linux/kvm_para.h>
>>   #include <linux/kthread.h>
>>   
>> +/* Watchdog configuration */
>>   static DEFINE_MUTEX(watchdog_proc_mutex);
>>   
>> -#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
>> +int __read_mostly nmi_watchdog_enabled;
>> +
>> +#ifdef CONFIG_HARDLOCKUP_DETECTOR
>>   unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
>> +
>> +/* boot commands */
>> +/*
>> + * Should we panic when a soft-lockup or hard-lockup occurs:
>> + */
>> +unsigned int __read_mostly hardlockup_panic =
>> +			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
>> +/*
>> + * We may not want to enable hard lockup detection by default in all cases,
>> + * for example when running the kernel as a guest on a hypervisor. In these
>> + * cases this function can be called to disable hard lockup detection. This
>> + * function should only be executed once by the boot processor before the
>> + * kernel command line parameters are parsed, because otherwise it is not
>> + * possible to override this in hardlockup_panic_setup().
>> + */
>> +void hardlockup_detector_disable(void)
>> +{
>> +	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
>> +}
>> +
>> +static int __init hardlockup_panic_setup(char *str)
>> +{
>> +	if (!strncmp(str, "panic", 5))
>> +		hardlockup_panic = 1;
>> +	else if (!strncmp(str, "nopanic", 7))
>> +		hardlockup_panic = 0;
>> +	else if (!strncmp(str, "0", 1))
>> +		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
>> +	else if (!strncmp(str, "1", 1))
>> +		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
>> +	return 1;
>> +}
>> +__setup("nmi_watchdog=", hardlockup_panic_setup);
>> +
>>   #else
>>   unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
>>   #endif
>> -int __read_mostly nmi_watchdog_enabled;
>> +
>> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
>>   int __read_mostly soft_watchdog_enabled;
>> +#endif
>> +
>>   int __read_mostly watchdog_user_enabled;
>>   int __read_mostly watchdog_thresh = 10;
>>   
>> @@ -45,15 +85,9 @@ int __read_mostly watchdog_thresh = 10;
>>   int __read_mostly sysctl_softlockup_all_cpu_backtrace;
>>   int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
>>   #endif
>> -static struct cpumask watchdog_cpumask __read_mostly;
>> +struct cpumask watchdog_cpumask __read_mostly;
>>   unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
>>   
>> -/* Helper for online, unparked cpus. */
>> -#define for_each_watchdog_cpu(cpu) \
>> -	for_each_cpu_and((cpu), cpu_online_mask, &watchdog_cpumask)
>> -
>> -atomic_t watchdog_park_in_progress = ATOMIC_INIT(0);
>> -
>>   /*
>>    * The 'watchdog_running' variable is set to 1 when the watchdog threads
>>    * are registered/started and is set to 0 when the watchdog threads are
>> @@ -72,7 +106,27 @@ static int __read_mostly watchdog_running;
>>    * of 'watchdog_running' cannot change while the watchdog is deactivated
>>    * temporarily (see related code in 'proc' handlers).
>>    */
>> -static int __read_mostly watchdog_suspended;
>> +int __read_mostly watchdog_suspended;
>> +
>> +/*
>> + * These functions can be overridden if an architecture implements its
>> + * own hardlockup detector.
>> + */
>> +int __weak watchdog_nmi_enable(unsigned int cpu)
>> +{
>> +	return 0;
>> +}
>> +void __weak watchdog_nmi_disable(unsigned int cpu)
>> +{
>> +}
>> +
>> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
>> +
>> +/* Helper for online, unparked cpus. */
>> +#define for_each_watchdog_cpu(cpu) \
>> +	for_each_cpu_and((cpu), cpu_online_mask, &watchdog_cpumask)
>> +
>> +atomic_t watchdog_park_in_progress = ATOMIC_INIT(0);
>>   
>>   static u64 __read_mostly sample_period;
>>   
>> @@ -120,6 +174,7 @@ static int __init softlockup_all_cpu_backtrace_setup(char *str)
>>   	return 1;
>>   }
>>   __setup("softlockup_all_cpu_backtrace=", softlockup_all_cpu_backtrace_setup);
>> +#ifdef CONFIG_HARDLOCKUP_DETECTOR
>>   static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>>   {
>>   	sysctl_hardlockup_all_cpu_backtrace =
>> @@ -128,6 +183,7 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>>   }
>>   __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
>>   #endif
>> +#endif
>>   
>>   /*
>>    * Hard-lockup warnings should be triggered after just a few seconds. Soft-
>> @@ -213,18 +269,6 @@ void touch_softlockup_watchdog_sync(void)
>>   	__this_cpu_write(watchdog_touch_ts, 0);
>>   }
>>   
>> -/* watchdog detector functions */
>> -bool is_hardlockup(void)
>> -{
>> -	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
>> -
>> -	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
>> -		return true;
>> -
>> -	__this_cpu_write(hrtimer_interrupts_saved, hrint);
>> -	return false;
>> -}
>> -
>>   static int is_softlockup(unsigned long touch_ts)
>>   {
>>   	unsigned long now = get_timestamp();
>> @@ -237,21 +281,21 @@ static int is_softlockup(unsigned long touch_ts)
>>   	return 0;
>>   }
>>   
>> -static void watchdog_interrupt_count(void)
>> +/* watchdog detector functions */
>> +bool is_hardlockup(void)
>>   {
>> -	__this_cpu_inc(hrtimer_interrupts);
>> -}
>> +	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
>>   
>> -/*
>> - * These two functions are mostly architecture specific
>> - * defining them as weak here.
>> - */
>> -int __weak watchdog_nmi_enable(unsigned int cpu)
>> -{
>> -	return 0;
>> +	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
>> +		return true;
>> +
>> +	__this_cpu_write(hrtimer_interrupts_saved, hrint);
>> +	return false;
>>   }
>> -void __weak watchdog_nmi_disable(unsigned int cpu)
>> +
>> +static void watchdog_interrupt_count(void)
>>   {
>> +	__this_cpu_inc(hrtimer_interrupts);
>>   }
>>   
>>   static int watchdog_enable_all_cpus(void);
>> @@ -502,57 +546,6 @@ static void watchdog_unpark_threads(void)
>>   		kthread_unpark(per_cpu(softlockup_watchdog, cpu));
>>   }
>>   
>> -/*
>> - * Suspend the hard and soft lockup detector by parking the watchdog threads.
>> - */
>> -int lockup_detector_suspend(void)
>> -{
>> -	int ret = 0;
>> -
>> -	get_online_cpus();
>> -	mutex_lock(&watchdog_proc_mutex);
>> -	/*
>> -	 * Multiple suspend requests can be active in parallel (counted by
>> -	 * the 'watchdog_suspended' variable). If the watchdog threads are
>> -	 * running, the first caller takes care that they will be parked.
>> -	 * The state of 'watchdog_running' cannot change while a suspend
>> -	 * request is active (see related code in 'proc' handlers).
>> -	 */
>> -	if (watchdog_running && !watchdog_suspended)
>> -		ret = watchdog_park_threads();
>> -
>> -	if (ret == 0)
>> -		watchdog_suspended++;
>> -	else {
>> -		watchdog_disable_all_cpus();
>> -		pr_err("Failed to suspend lockup detectors, disabled\n");
>> -		watchdog_enabled = 0;
>> -	}
>> -
>> -	mutex_unlock(&watchdog_proc_mutex);
>> -
>> -	return ret;
>> -}
>> -
>> -/*
>> - * Resume the hard and soft lockup detector by unparking the watchdog threads.
>> - */
>> -void lockup_detector_resume(void)
>> -{
>> -	mutex_lock(&watchdog_proc_mutex);
>> -
>> -	watchdog_suspended--;
>> -	/*
>> -	 * The watchdog threads are unparked if they were previously running
>> -	 * and if there is no more active suspend request.
>> -	 */
>> -	if (watchdog_running && !watchdog_suspended)
>> -		watchdog_unpark_threads();
>> -
>> -	mutex_unlock(&watchdog_proc_mutex);
>> -	put_online_cpus();
>> -}
>> -
>>   static int update_watchdog_all_cpus(void)
>>   {
>>   	int ret;
>> @@ -604,6 +597,81 @@ static void watchdog_disable_all_cpus(void)
>>   	}
>>   }
>>   
>> +#else /* SOFTLOCKUP */
>> +static int watchdog_park_threads(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void watchdog_unpark_threads(void)
>> +{
>> +}
>> +
>> +static int watchdog_enable_all_cpus(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void watchdog_disable_all_cpus(void)
>> +{
>> +}
>> +
>> +static void set_sample_period(void)
>> +{
>> +}
>> +#endif /* SOFTLOCKUP */
>> +
>> +/*
>> + * Suspend the hard and soft lockup detector by parking the watchdog threads.
>> + */
>> +int lockup_detector_suspend(void)
>> +{
>> +	int ret = 0;
>> +
>> +	get_online_cpus();
>> +	mutex_lock(&watchdog_proc_mutex);
>> +	/*
>> +	 * Multiple suspend requests can be active in parallel (counted by
>> +	 * the 'watchdog_suspended' variable). If the watchdog threads are
>> +	 * running, the first caller takes care that they will be parked.
>> +	 * The state of 'watchdog_running' cannot change while a suspend
>> +	 * request is active (see related code in 'proc' handlers).
>> +	 */
>> +	if (watchdog_running && !watchdog_suspended)
>> +		ret = watchdog_park_threads();
>> +
>> +	if (ret == 0)
>> +		watchdog_suspended++;
>> +	else {
>> +		watchdog_disable_all_cpus();
>> +		pr_err("Failed to suspend lockup detectors, disabled\n");
>> +		watchdog_enabled = 0;
>> +	}
>> +
>> +	mutex_unlock(&watchdog_proc_mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Resume the hard and soft lockup detector by unparking the watchdog threads.
>> + */
>> +void lockup_detector_resume(void)
>> +{
>> +	mutex_lock(&watchdog_proc_mutex);
>> +
>> +	watchdog_suspended--;
>> +	/*
>> +	 * The watchdog threads are unparked if they were previously running
>> +	 * and if there is no more active suspend request.
>> +	 */
>> +	if (watchdog_running && !watchdog_suspended)
>> +		watchdog_unpark_threads();
>> +
>> +	mutex_unlock(&watchdog_proc_mutex);
>> +	put_online_cpus();
>> +}
>> +
>>   #ifdef CONFIG_SYSCTL
>>   
>>   /*
>> @@ -810,9 +878,11 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
>>   			 * a temporary cpumask, so we are likely not in a
>>   			 * position to do much else to make things better.
>>   			 */
>> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
>>   			if (smpboot_update_cpumask_percpu_thread(
>>   				    &watchdog_threads, &watchdog_cpumask) != 0)
>>   				pr_err("cpumask update failed\n");
>> +#endif
>>   		}
>>   	}
>>   out:
>> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
>> index 90d688df6ce1..295a0d84934c 100644
>> --- a/kernel/watchdog_hld.c
>> +++ b/kernel/watchdog_hld.c
>> @@ -22,39 +22,7 @@ static DEFINE_PER_CPU(bool, hard_watchdog_warn);
>>   static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
>>   static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
>>   
>> -/* boot commands */
>> -/*
>> - * Should we panic when a soft-lockup or hard-lockup occurs:
>> - */
>> -unsigned int __read_mostly hardlockup_panic =
>> -			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
>>   static unsigned long hardlockup_allcpu_dumped;
>> -/*
>> - * We may not want to enable hard lockup detection by default in all cases,
>> - * for example when running the kernel as a guest on a hypervisor. In these
>> - * cases this function can be called to disable hard lockup detection. This
>> - * function should only be executed once by the boot processor before the
>> - * kernel command line parameters are parsed, because otherwise it is not
>> - * possible to override this in hardlockup_panic_setup().
>> - */
>> -void hardlockup_detector_disable(void)
>> -{
>> -	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
>> -}
>> -
>> -static int __init hardlockup_panic_setup(char *str)
>> -{
>> -	if (!strncmp(str, "panic", 5))
>> -		hardlockup_panic = 1;
>> -	else if (!strncmp(str, "nopanic", 7))
>> -		hardlockup_panic = 0;
>> -	else if (!strncmp(str, "0", 1))
>> -		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
>> -	else if (!strncmp(str, "1", 1))
>> -		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
>> -	return 1;
>> -}
>> -__setup("nmi_watchdog=", hardlockup_panic_setup);
>>   
>>   void arch_touch_nmi_watchdog(void)
>>   {
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index e4587ebe52c7..f87a559dd178 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -801,10 +801,24 @@ config LOCKUP_DETECTOR
>>   	  The frequency of hrtimer and NMI events and the soft and hard lockup
>>   	  thresholds can be controlled through the sysctl watchdog_thresh.
>>   
>> +config SOFTLOCKUP_DETECTOR
>> +	bool "Detect Soft Lockups"
>> +	depends on LOCKUP_DETECTOR
>> +
>> +config HARDLOCKUP_DETECTOR_PERF
>> +	bool
>> +	select SOFTLOCKUP_DETECTOR
>> +
>> +#
>> +# arch/ can define HAVE_HARDLOCKUP_DETECTOR_ARCH to provide their own hard
>> +# lockup detector rather than the perf based detector.
>> +#
>>   config HARDLOCKUP_DETECTOR
>> -	def_bool y
>> -	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
>> -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>> +	bool "Detect Hard Lockups"
>> +	depends on LOCKUP_DETECTOR
>> +	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_ARCH
>> +	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF
>> +	select HARDLOCKUP_DETECTOR_ARCH if HAVE_HARDLOCKUP_DETECTOR_ARCH
>>   
>>   config BOOTPARAM_HARDLOCKUP_PANIC
>>   	bool "Panic (Reboot) On Hard Lockups"
>> @@ -826,7 +840,7 @@ config BOOTPARAM_HARDLOCKUP_PANIC_VALUE
>>   
>>   config BOOTPARAM_SOFTLOCKUP_PANIC
>>   	bool "Panic (Reboot) On Soft Lockups"
>> -	depends on LOCKUP_DETECTOR
>> +	depends on SOFTLOCKUP_DETECTOR
>>   	help
>>   	  Say Y here to enable the kernel to panic on "soft lockups",
>>   	  which are bugs that cause the kernel to loop in kernel
>> @@ -843,7 +857,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
>>   
>>   config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
>>   	int
>> -	depends on LOCKUP_DETECTOR
>> +	depends on SOFTLOCKUP_DETECTOR
>>   	range 0 1
>>   	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
>>   	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
>> @@ -851,7 +865,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
>>   config DETECT_HUNG_TASK
>>   	bool "Detect Hung Tasks"
>>   	depends on DEBUG_KERNEL
>> -	default LOCKUP_DETECTOR
>> +	default SOFTLOCKUP_DETECTOR
>>   	help
>>   	  Say Y here to enable the kernel to detect "hung tasks",
>>   	  which are bugs that cause the task to be stuck in
>> -- 
>> 2.11.0
>>
