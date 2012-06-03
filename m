From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 17/27] mn10300, smpboot: Use generic SMP booting infrastructure
Date: Sun, 03 Jun 2012 17:20:34 +0530
Message-ID: <4FCB4F8A.5000307@linux.vnet.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091403.31979.12717.stgit@srivatsabhat.in.ibm.com> <20120603083346.GB16829@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:45626 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab2FCLv1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jun 2012 07:51:27 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sun, 3 Jun 2012 17:21:25 +0530
In-Reply-To: <20120603083346.GB16829@zhy>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com

On 06/03/2012 02:03 PM, Yong Zhang wrote:

> On Fri, Jun 01, 2012 at 02:44:08PM +0530, Srivatsa S. Bhat wrote:
>> From: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>
>>
>> Convert mn10300 to use the generic framework to boot secondary CPUs.
>>
>> Notes:
>> 1. In order to avoid enabling interrupts very early during secondary CPU
>> bringup (in smp_cpu_init()), use arch_local_save_flags() instead of
>> arch_local_cli_save().
> 
> We can just remove arch_local_cli_save()/arch_local_irq_restore() IMHO.
>


Ok, will update the patch. Thanks!

Regards,
Srivatsa S. Bhat

> 
>>
>> Signed-off-by: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Yong Zhang <yong.zhang0@gmail.com>
>> Cc: linux-am33-list@redhat.com
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
>>
>>  arch/mn10300/kernel/smp.c |   32 +++++++++++---------------------
>>  1 files changed, 11 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/mn10300/kernel/smp.c b/arch/mn10300/kernel/smp.c
>> index b19e75d2..9c4e35e 100644
>> --- a/arch/mn10300/kernel/smp.c
>> +++ b/arch/mn10300/kernel/smp.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/profile.h>
>>  #include <linux/smp.h>
>>  #include <linux/cpu.h>
>> +#include <linux/smpboot.h>
>>  #include <asm/tlbflush.h>
>>  #include <asm/bitops.h>
>>  #include <asm/processor.h>
>> @@ -100,7 +101,6 @@ cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
>>  static int do_boot_cpu(int);
>>  static void smp_show_cpu_info(int cpu_id);
>>  static void smp_callin(void);
>> -static void smp_online(void);
>>  static void smp_store_cpu_info(int);
>>  static void smp_cpu_init(void);
>>  static void smp_tune_scheduling(void);
>> @@ -607,7 +607,7 @@ static void __init smp_cpu_init(void)
>>  	mn10300_ipi_shutdown(SMP_BOOT_IRQ);
>>  
>>  	/* Set up the non-maskable call function IPI */
>> -	flags = arch_local_cli_save();
>> +	flags = arch_local_save_flags();
>>  	GxICR(CALL_FUNCTION_NMI_IPI) = GxICR_NMI | GxICR_ENABLE | GxICR_DETECT;
>>  	tmp16 = GxICR(CALL_FUNCTION_NMI_IPI);
>>  	arch_local_irq_restore(flags);
>> @@ -655,20 +655,25 @@ void smp_prepare_cpu_init(void)
>>   */
>>  int __init start_secondary(void *unused)
>>  {
>> +	smpboot_start_secondary(unused);
>> +	return 0;
>> +}
>> +
>> +void __cpuinit __cpu_pre_starting(void *unused)
>> +{
>>  	smp_cpu_init();
>>  	smp_callin();
>>  	while (!cpumask_test_cpu(smp_processor_id(), &smp_commenced_mask))
>>  		cpu_relax();
>>  
>>  	local_flush_tlb();
>> -	preempt_disable();
>> -	smp_online();
>> +}
>>  
>> +void __cpuinit __cpu_post_online(void *unused)
>> +{
>>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>>  	init_clockevents();
>>  #endif
>> -	cpu_idle();
>> -	return 0;
>>  }
>>  
>>  /**
>> @@ -865,21 +870,6 @@ static void __init smp_callin(void)
>>  	cpumask_set_cpu(cpu, &cpu_callin_map);
>>  }
>>  
>> -/**
>> - * smp_online - Set cpu_online_mask
>> - */
>> -static void __init smp_online(void)
>> -{
>> -	int cpu;
>> -
>> -	cpu = smp_processor_id();
>> -
>> -	notify_cpu_starting(cpu);
>> -
>> -	set_cpu_online(cpu, true);
>> -
>> -	local_irq_enable();
>> -}
>>  
>>  /**
>>   * smp_cpus_done -
>>
