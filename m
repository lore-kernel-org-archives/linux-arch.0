Return-Path: <glauber@gmx.de>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6847 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S263992AbUDVMXH
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 08:23:07 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.12.10/8.12.10) with ESMTP id i3MCN4Mp038592
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2004 12:23:05 GMT
Subject: [Patch] SMP call function cleanup
From: Jan Glauber <glauber@gmx.de>
Reply-To: glauber@gmx.de
Content-Type: text/plain
Message-Id: <1082636511.1332.34.camel@halo>
Mime-Version: 1.0
Date: Thu, 22 Apr 2004 14:21:51 +0200
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

Hello,

I've been looking into the SMP call function stuff on different
archs and found many different functions...

In the common code part there are 2 functions:
smp_call_function()  	// call a function on all CPUs but my own
on_each_cpu()		// call a function on all CPUs

Many archs need an additional function to call a function on a 
specific CPU:

arch-s390:
smp_call_function_on()

arch-alpha:
smp_call_function_on_cpu()

arch-ia64:
smp_call_function_single()

On i386 there is no smp_call_function_single() so they have a workaround
with smp_call_function() and testing for smp_processor_id().
Finally the slab allocator has its own on_each_cpu() function:

mm:
smp_call_function_all_cpus()

This is somehow inconsistent.

Proposed cleanup:

there are 3 different kinds of SMP calls:
1. all CPUs
2. all CPUs but my own
3. one CPU

only _one_ basic function is needed to implement all variants:

This can be named on_cpu() and has as parameter a cpumask,
the function is called on all CPUs specified there:

void on_cpu(void (*func) (void *info), void *info, int retry,
            int wait, cpumask_t map);

Each architecture should implement this call. 

The 3 variants can then be implemented in common code as small inlines:

on_each_cpu      -> on_cpu( ... , cpu_online_map) 
on_other_cpus()  -> on_cpu( ... , cpu_online_map & ~smp_processor_id()) 
on_single_cpu()  -> on_cpu( ... , cpu_set(cpu, map))

Then each architecture needs only one function that implements smp calls. 
Beside the consistent naming this names are also shorter then the original.

I've built a patch for s390 & i386.

Jan

---
Jan Glauber
Linux on zSeries Development
IBM Deutschland Entwicklung GmbH
Phone: +49 7031 161911   Mail: jang@de.ibm.com


diff -urN linux-2.6.5/arch/i386/kernel/cpu/mtrr/main.c linux-2.6.5_smp/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.5/arch/i386/kernel/cpu/mtrr/main.c	2004-04-04 05:36:16.000000000 +0200
+++ linux-2.6.5_smp/arch/i386/kernel/cpu/mtrr/main.c	2004-04-14 14:31:18.000000000 +0200
@@ -223,9 +223,7 @@
 	atomic_set(&data.gate,0);
 
 	/*  Start the ball rolling on other CPUs  */
-	if (smp_call_function(ipi_handler, &data, 1, 0) != 0)
-		panic("mtrr: timed out waiting for other CPUs\n");
-
+	on_other_cpus(ipi_handler, &data, 1, 0);
 	local_irq_save(flags);
 
 	while(atomic_read(&data.count)) {
diff -urN linux-2.6.5/arch/i386/kernel/cpuid.c linux-2.6.5_smp/arch/i386/kernel/cpuid.c
--- linux-2.6.5/arch/i386/kernel/cpuid.c	2004-04-04 05:36:12.000000000 +0200
+++ linux-2.6.5_smp/arch/i386/kernel/cpuid.c	2004-04-14 14:52:12.000000000 +0200
@@ -55,8 +55,7 @@
 {
   struct cpuid_command *cmd = (struct cpuid_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
-    cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2], &cmd->data[3]);
+  cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2], &cmd->data[3]);
 }
 
 static inline void do_cpuid(int cpu, u32 reg, u32 *data)
@@ -71,7 +70,7 @@
     cmd.reg  = reg;
     cmd.data = data;
     
-    smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
+    on_single_cpu(cpuid_smp_cpuid, &cmd, 1, 1, cpu);
   }
   preempt_enable();
 }
diff -urN linux-2.6.5/arch/i386/kernel/i386_ksyms.c linux-2.6.5_smp/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.5/arch/i386/kernel/i386_ksyms.c	2004-04-04 05:38:23.000000000 +0200
+++ linux-2.6.5_smp/arch/i386/kernel/i386_ksyms.c	2004-04-14 16:21:47.000000000 +0200
@@ -148,7 +148,6 @@
 
 /* Global SMP stuff */
 EXPORT_SYMBOL(synchronize_irq);
-EXPORT_SYMBOL(smp_call_function);
 
 /* TLB flushing */
 EXPORT_SYMBOL(flush_tlb_page);
diff -urN linux-2.6.5/arch/i386/kernel/ldt.c linux-2.6.5_smp/arch/i386/kernel/ldt.c
--- linux-2.6.5/arch/i386/kernel/ldt.c	2004-04-04 05:37:37.000000000 +0200
+++ linux-2.6.5_smp/arch/i386/kernel/ldt.c	2004-04-14 14:53:18.000000000 +0200
@@ -61,7 +61,7 @@
 		load_LDT(pc);
 		mask = cpumask_of_cpu(smp_processor_id());
 		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
-			smp_call_function(flush_ldt, 0, 1, 1);
+			on_other_cpus(flush_ldt, 0, 1, 1);
 		preempt_enable();
 #else
 		load_LDT(pc);
diff -urN linux-2.6.5/arch/i386/kernel/msr.c linux-2.6.5_smp/arch/i386/kernel/msr.c
--- linux-2.6.5/arch/i386/kernel/msr.c	2004-04-04 05:36:57.000000000 +0200
+++ linux-2.6.5_smp/arch/i386/kernel/msr.c	2004-04-14 15:15:15.000000000 +0200
@@ -99,16 +99,14 @@
 {
   struct msr_command *cmd = (struct msr_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
-    cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
+  cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
 }
 
 static void msr_smp_rdmsr(void *cmd_block)
 {
   struct msr_command *cmd = (struct msr_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
-    cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
+  cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
 }
 
 static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
@@ -125,7 +123,7 @@
     cmd.data[0] = eax;
     cmd.data[1] = edx;
     
-    smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
+    on_single_cpu(msr_smp_wrmsr, &cmd, 1, 1, cpu);
     ret = cmd.err;
   }
   preempt_enable();
@@ -144,7 +142,7 @@
     cmd.cpu = cpu;
     cmd.reg = reg;
 
-    smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
+    on_single_cpu(msr_smp_rdmsr, &cmd, 1, 1, cpu);
     
     *eax = cmd.data[0];
     *edx = cmd.data[1];
diff -urN linux-2.6.5/arch/i386/kernel/reboot.c linux-2.6.5_smp/arch/i386/kernel/reboot.c
--- linux-2.6.5/arch/i386/kernel/reboot.c	2004-04-04 05:36:54.000000000 +0200
+++ linux-2.6.5_smp/arch/i386/kernel/reboot.c	2004-04-14 15:20:35.000000000 +0200
@@ -239,7 +239,7 @@
 		   cleared reboot_smp, and do the reboot if it is the
 		   correct CPU, otherwise it halts. */
 		if (reboot_cpu != cpuid)
-			smp_call_function((void *)machine_restart , NULL, 1, 0);
+			on_other_cpus((void *)machine_restart , NULL, 1, 0);
 	}
 
 	/* if reboot_cpu is still -1, then we want a tradional reboot, 
diff -urN linux-2.6.5/arch/i386/kernel/smp.c linux-2.6.5_smp/arch/i386/kernel/smp.c
--- linux-2.6.5/arch/i386/kernel/smp.c	2004-04-04 05:36:18.000000000 +0200
+++ linux-2.6.5_smp/arch/i386/kernel/smp.c	2004-04-22 13:26:58.000000000 +0200
@@ -478,7 +478,7 @@
 }
 
 /*
- * Structure and data for smp_call_function(). This is designed to minimise
+ * Structure and data for on_cpu(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
  */
 static spinlock_t call_lock = SPIN_LOCK_UNLOCKED;
@@ -486,64 +486,77 @@
 struct call_data_struct {
 	void (*func) (void *info);
 	void *info;
-	atomic_t started;
-	atomic_t finished;
+	cpumask_t started;
+	cpumask_t finished;
 	int wait;
 };
 
 static struct call_data_struct * call_data;
 
 /*
- * this function sends a 'generic call function' IPI to all other CPUs
- * in the system.
- */
-
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-			int wait)
-/*
- * [SUMMARY] Run a function on all other CPUs.
- * <func> The function to run. This must be fast and non-blocking.
- * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
- * <wait> If true, wait (atomically) until function has completed on other CPUs.
- * [RETURNS] 0 on success, else a negative status code. Does not return until
- * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ * [Summary]    Run a function on all specified CPUs.
+ * <func>       The function to run. This must be fast and non-blocking.
+ * <info>       An arbitrary pointer to pass to the function.
+ * <nonatomic>  currently unused.
+ * <wait>       If true, wait atomically until function has completed on
+ * 		other CPUs.
+ * <map>        All CPUs where the function should run.
  *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.
+ * Does not return until remote CPUs are nearly ready to execute <func> 
+ * or are or have executed.
+ *
+ * You must not call this function with disabled interrupts or from a hardware
+ * interrupt handler. You must call this function with preemption disabled.
  */
+void on_cpu(void (*func) (void *info), void *info, int nonatomic,
+	    int wait, cpumask_t map)
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	int local = 0;
+
+	/*
+	 * Check for local function call.
+	 * The local call comes after the remote call,
+	 * otherwise machine_restart_smp() doesn't work.
+	 */
+	if (cpu_isset(smp_processor_id(), map)) {
+		local = 1;
+		cpu_clear(smp_processor_id(), map);
+	}
 
-	if (!cpus)
-		return 0;
+	cpus_and(map, map, cpu_online_map);
+
+	if (cpus_empty(map))
+		goto out;
 
 	data.func = func;
-	data.info = info;
-	atomic_set(&data.started, 0);
+        data.info = info;
+	cpus_clear(data.started);
 	data.wait = wait;
 	if (wait)
-		atomic_set(&data.finished, 0);
+		cpus_clear(data.finished);
 
-	spin_lock(&call_lock);
+	spin_lock_bh(&call_lock);
 	call_data = &data;
 	mb();
-	
-	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+
+	/* call the cross CPU functions */
+	send_IPI_mask(map, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
+	while (!cpus_equal(map, data.started))
 		barrier();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (!cpus_equal(map, data.finished))
 			barrier();
-	spin_unlock(&call_lock);
 
-	return 0;
+	spin_unlock_bh(&call_lock);
+ out:
+	if (local)
+		func(info);
 }
+EXPORT_SYMBOL(on_cpu);
 
 static void stop_this_cpu (void * dummy)
 {
@@ -564,7 +577,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	on_other_cpus(stop_this_cpu, NULL, 1, 0);
 
 	local_irq_disable();
 	disable_local_APIC();
@@ -593,7 +606,7 @@
 	 * about to execute the function
 	 */
 	mb();
-	atomic_inc(&call_data->started);
+	cpu_set(smp_processor_id(), call_data->started);
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
@@ -603,7 +616,7 @@
 
 	if (wait) {
 		mb();
-		atomic_inc(&call_data->finished);
+		cpu_set(smp_processor_id(), call_data->finished);
 	}
 }
 
diff -urN linux-2.6.5/arch/s390/appldata/appldata_base.c linux-2.6.5_smp/arch/s390/appldata/appldata_base.c
--- linux-2.6.5/arch/s390/appldata/appldata_base.c	2004-04-04 05:36:48.000000000 +0200
+++ linux-2.6.5_smp/arch/s390/appldata/appldata_base.c	2004-04-14 15:41:24.000000000 +0200
@@ -189,7 +189,7 @@
 /*
  * appldata_mod_vtimer_wrap()
  *
- * wrapper function for mod_virt_timer(), because smp_call_function_on()
+ * wrapper function for mod_virt_timer(), because on_single_cpu()
  * accepts only one parameter.
  */
 static void appldata_mod_vtimer_wrap(struct appldata_mod_vtimer_args *args) {
@@ -281,9 +281,8 @@
 	if ((buf[0] == '1') && (!appldata_timer_active)) {
 		for (i = 0; i < num_online_cpus(); i++) {
 			per_cpu(appldata_timer, i).expires = per_cpu_interval;
-			smp_call_function_on(add_virt_timer_periodic,
-						&per_cpu(appldata_timer, i),
-						0, 1, i);
+			on_single_cpu(add_virt_timer_periodic,
+				      &per_cpu(appldata_timer, i), 0, 1, i);
 		}
 		appldata_timer_active = 1;
 		P_INFO("Monitoring timer started.\n");
@@ -346,10 +345,8 @@
 					&per_cpu(appldata_timer, i);
 			appldata_mod_vtimer_args.expires =
 					per_cpu_interval;
-			smp_call_function_on(
-				(void *) appldata_mod_vtimer_wrap,
-				&appldata_mod_vtimer_args,
-				0, 1, i);
+			on_single_cpu((void *) appldata_mod_vtimer_wrap,
+				      &appldata_mod_vtimer_args, 0, 1, i);
 		}
 	}
 	spin_unlock(&appldata_timer_lock);
diff -urN linux-2.6.5/arch/s390/kernel/smp.c linux-2.6.5_smp/arch/s390/kernel/smp.c
--- linux-2.6.5/arch/s390/kernel/smp.c	2004-04-04 05:36:13.000000000 +0200
+++ linux-2.6.5_smp/arch/s390/kernel/smp.c	2004-04-22 13:25:44.000000000 +0200
@@ -66,11 +66,10 @@
 
 extern void do_reipl(unsigned long devno);
 
-static void smp_ext_bitcall(int, ec_bit_sig);
-static void smp_ext_bitcall_others(ec_bit_sig);
+static inline void smp_ext_bitcall(int, ec_bit_sig);
 
 /*
- * Structure and data for smp_call_function(). This is designed to minimise
+ * Structure and data for on_cpu(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
  */
 static spinlock_t call_lock = SPIN_LOCK_UNLOCKED;
@@ -78,8 +77,8 @@
 struct call_data_struct {
 	void (*func) (void *info);
 	void *info;
-	atomic_t started;
-	atomic_t finished;
+	cpumask_t started;
+	cpumask_t finished;
 	int wait;
 };
 
@@ -94,116 +93,78 @@
 	void *info = call_data->info;
 	int wait = call_data->wait;
 
-	atomic_inc(&call_data->started);
+	cpu_set(smp_processor_id(), call_data->started);
 	(*func)(info);
 	if (wait)
-		atomic_inc(&call_data->finished);
+		cpu_set(smp_processor_id(), call_data->finished);
 }
 
 /*
- * this function sends a 'generic call function' IPI to all other CPUs
- * in the system.
- */
-
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-			int wait)
-/*
- * [SUMMARY] Run a function on all other CPUs.
- * <func> The function to run. This must be fast and non-blocking.
- * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
- * <wait> If true, wait (atomically) until function has completed on other CPUs.
- * [RETURNS] 0 on success, else a negative status code. Does not return until
- * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ * [Summary]    Run a function on all specified CPUs.
+ * <func>       The function to run. This must be fast and non-blocking.
+ * <info>       An arbitrary pointer to pass to the function.
+ * <nonatomic>  currently unused.
+ * <wait>       If true, wait atomically until function has completed on
+ * 		other CPUs.
+ * <map>        All CPUs where the function should run.
  *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.
- */
-{
-	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
-
-	/* FIXME: get cpu lock -hc */
-	if (cpus <= 0)
-		return 0;
-
-	data.func = func;
-	data.info = info;
-	atomic_set(&data.started, 0);
-	data.wait = wait;
-	if (wait)
-		atomic_set(&data.finished, 0);
-
-	spin_lock(&call_lock);
-	call_data = &data;
-	/* Send a message to all other CPUs and wait for them to respond */
-        smp_ext_bitcall_others(ec_call_function);
-
-	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
-		cpu_relax();
-
-	if (wait)
-		while (atomic_read(&data.finished) != cpus)
-			cpu_relax();
-	spin_unlock(&call_lock);
-
-	return 0;
-}
-
-/*
- * Call a function on one CPU
- * cpu : the CPU the function should be executed on
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler. You may call it from a bottom half.
+ * Does not return until remote CPUs are nearly ready to execute <func> 
+ * or are or have executed.
  *
- * It is guaranteed that the called function runs on the specified CPU,
- * preemption is disabled.
+ * You must not call this function with disabled interrupts or from a hardware
+ * interrupt handler. You must call this function with preemption disabled.
+ * XXX You may call it from a bottom half handler.
  */
-int smp_call_function_on(void (*func) (void *info), void *info,
-			 int nonatomic, int wait, int cpu)
+void on_cpu(void (*func) (void *info), void *info, int nonatomic,
+	    int wait, cpumask_t map)
 {
 	struct call_data_struct data;
-	int curr_cpu;
+	int cpu, local = 0;
 
-	if (!cpu_online(cpu))
-		return -EINVAL;
+	/*
+	 * Check for local function call.
+	 * In on_each_cpu() the local call comes after the remote call,
+	 * we have to call it in the same order, else machine_restart_smp()
+	 * doesn't work.
+	 */
+	if (cpu_isset(smp_processor_id(), map)) {
+		local = 1;
+		cpu_clear(smp_processor_id(), map);
+	}
 
-	/* disable preemption for local function call */
-	curr_cpu = get_cpu();
+	cpus_and(map, map, cpu_online_map);
 
-	if (curr_cpu == cpu) {
-		/* direct call to function */
-		func(info);
-		put_cpu();
-		return 0;
-	}
+	if (cpus_empty(map))
+		goto out;
 
 	data.func = func;
 	data.info = info;
-	atomic_set(&data.started, 0);
+	cpus_clear(data.started);
 	data.wait = wait;
 	if (wait)
-		atomic_set(&data.finished, 0);
+		cpus_clear(data.finished);
 
 	spin_lock_bh(&call_lock);
 	call_data = &data;
-	smp_ext_bitcall(cpu, ec_call_function);
+
+	/* call the cross CPU functions */
+	for_each_cpu_mask(cpu, map)
+		smp_ext_bitcall(cpu, ec_call_function);
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != 1)
+	while (!cpus_equal(map, data.started))
 		cpu_relax();
 
 	if (wait)
-		while (atomic_read(&data.finished) != 1)
+		while (!cpus_equal(map, data.finished))
 			cpu_relax();
 
 	spin_unlock_bh(&call_lock);
-	put_cpu();
-	return 0;
+ out:
+	if (local)
+		func(info);
 }
-EXPORT_SYMBOL(smp_call_function_on);
+EXPORT_SYMBOL(on_cpu);
 
 static inline void do_send_stop(void)
 {
@@ -357,10 +318,9 @@
 }
 
 /*
- * Send an external call sigp to another cpu and return without waiting
- * for its completion.
+ * Send an external call sigp to another cpu and wait for its completion.
  */
-static void smp_ext_bitcall(int cpu, ec_bit_sig sig)
+static inline void smp_ext_bitcall(int cpu, ec_bit_sig sig)
 {
         /*
          * Set signaling bit in lowcore of target cpu and kick it
@@ -370,26 +330,6 @@
 		udelay(10);
 }
 
-/*
- * Send an external call sigp to every other cpu in the system and
- * return without waiting for its completion.
- */
-static void smp_ext_bitcall_others(ec_bit_sig sig)
-{
-        int i;
-
-        for (i = 0; i < NR_CPUS; i++) {
-                if (!cpu_online(i) || smp_processor_id() == i)
-                        continue;
-                /*
-                 * Set signaling bit in lowcore of target cpu and kick it
-                 */
-		set_bit(sig, (unsigned long *) &lowcore_ptr[i]->ext_call_fast);
-                while (signal_processor(i, sigp_external_call) == sigp_busy)
-			udelay(10);
-        }
-}
-
 #ifndef CONFIG_ARCH_S390X
 /*
  * this function sends a 'purge tlb' signal to another CPU.
@@ -453,7 +393,7 @@
 	parms.orvals[cr] = 1 << bit;
 	parms.andvals[cr] = -1L;
 	preempt_disable();
-	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
+	on_other_cpus(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_set_bit(cr, bit);
 	preempt_enable();
 }
@@ -469,7 +409,7 @@
 	parms.orvals[cr] = 0;
 	parms.andvals[cr] = ~(1L << bit);
 	preempt_disable();
-	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
+	on_other_cpus(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_clear_bit(cr, bit);
 	preempt_enable();
 }
@@ -652,4 +592,4 @@
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
-EXPORT_SYMBOL(smp_call_function);
+
diff -urN linux-2.6.5/drivers/s390/net/iucv.c linux-2.6.5_smp/drivers/s390/net/iucv.c
--- linux-2.6.5/drivers/s390/net/iucv.c	2004-04-04 05:36:18.000000000 +0200
+++ linux-2.6.5_smp/drivers/s390/net/iucv.c	2004-04-14 16:11:17.000000000 +0200
@@ -670,12 +670,7 @@
 	ulong b2f0_result = 0x0deadbeef;
 
 	iucv_debug(1, "entering");
-	preempt_disable();
-	if (smp_processor_id() == 0)
-		iucv_declare_buffer_cpu0(&b2f0_result);
-	else
-		smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1);
-	preempt_enable();
+	on_single_cpu(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1, 0);
 	iucv_debug(1, "Address of EIB = %p", iucv_external_int_buffer);
 	if (b2f0_result == 0x0deadbeef)
 	    b2f0_result = 0xaa;
@@ -694,13 +689,8 @@
 {
 	iucv_debug(1, "entering");
 	if (declare_flag) {
-		preempt_disable();
-		if (smp_processor_id() == 0)
-			iucv_retrieve_buffer_cpu0(0);
-		else
-			smp_call_function(iucv_retrieve_buffer_cpu0, 0, 0, 1);
+		on_single_cpu(iucv_retrieve_buffer_cpu0, 0, 0, 1, 0);
 		declare_flag = 0;
-		preempt_enable();
 	}
 	iucv_debug(1, "exiting");
 	return 0;
@@ -2220,13 +2210,7 @@
 	} u;
 
 	u.param = SetMaskFlag;
-	preempt_disable();
-	if (smp_processor_id() == 0)
-		iucv_setmask_cpu0(&u);
-	else
-		smp_call_function(iucv_setmask_cpu0, &u, 0, 1);
-	preempt_enable();
-
+	on_single_cpu(iucv_setmask_cpu0, &u, 0, 1, 0);
 	return u.result;
 }
 
diff -urN linux-2.6.5/include/linux/smp.h linux-2.6.5_smp/include/linux/smp.h
--- linux-2.6.5/include/linux/smp.h	2004-04-04 05:37:23.000000000 +0200
+++ linux-2.6.5_smp/include/linux/smp.h	2004-04-14 13:54:35.000000000 +0200
@@ -49,10 +49,40 @@
 extern void smp_cpus_done(unsigned int max_cpus);
 
 /*
- * Call a function on all other processors
+ * Call a function on the specified processors
  */
-extern int smp_call_function (void (*func) (void *info), void *info,
-			      int retry, int wait);
+extern void on_cpu(void (*func) (void *info), void *info, int retry,
+		   int wait, cpumask_t map);
+
+/*
+ * Call a function on one processor.
+ */
+static inline void on_single_cpu(void (*func) (void *info), void *info,
+				 int nonatomic, int wait, int cpu)
+{
+	cpumask_t map;
+
+	preempt_disable();
+	cpus_clear(map);
+	cpu_set(cpu, map);
+	on_cpu(func, info, nonatomic, wait, map);
+	preempt_enable();
+}
+
+/*
+ * Call a function on all other processors.
+ */
+static inline void on_other_cpus(void (*func) (void *info), void *info, 
+				 int nonatomic, int wait)
+{
+	cpumask_t map;
+
+	preempt_disable();
+	map = cpu_online_map;
+	cpu_clear(smp_processor_id(), map);
+	on_cpu(func, info, nonatomic, wait, map);
+	preempt_enable();
+}
 
 /*
  * Call a function on all processors
@@ -60,13 +90,10 @@
 static inline int on_each_cpu(void (*func) (void *info), void *info,
 			      int retry, int wait)
 {
-	int ret = 0;
-
 	preempt_disable();
-	ret = smp_call_function(func, info, retry, wait);
-	func(info);
+	on_cpu(func, info, retry, wait, cpu_online_map);
 	preempt_enable();
-	return ret;
+	return 0;
 }
 
 /*
@@ -99,8 +126,10 @@
 #define smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
-#define smp_call_function(func,info,retry,wait)	({ 0; })
-#define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
+#define on_cpu(func,info,retry,wait,map)        ({ func(info); 0; })
+#define on_single_cpu(func,info,retry,wait,cpu) ({ func(info); 0; })
+#define on_other_cpus(func,info,retry,wait)     ({ 0; })
+#define on_each_cpu(func,info,retry,wait)       ({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)
diff -urN linux-2.6.5/mm/slab.c linux-2.6.5_smp/mm/slab.c
--- linux-2.6.5/mm/slab.c	2004-04-04 05:37:41.000000000 +0200
+++ linux-2.6.5_smp/mm/slab.c	2004-04-14 14:03:39.000000000 +0200
@@ -51,7 +51,7 @@
  * On SMP, it additionally reduces the spinlock operations.
  *
  * The c_cpuarray may not be read with enabled local interrupts - 
- * it's changed with a smp_call_function().
+ * it's changed with a on_cpu().
  *
  * SMP synchronization:
  *  constructors and destructors are called without any locking.
@@ -1375,6 +1375,7 @@
  */
 static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
 {
+	// XXX if order doesn't matter use on_each_cpu()
 	check_irq_on();
 	preempt_disable();
 
@@ -1382,9 +1383,7 @@
 	func(arg);
 	local_irq_enable();
 
-	if (smp_call_function(func, arg, 1, 1))
-		BUG();
-
+	on_other_cpus(func, arg, 1, 1);
 	preempt_enable();
 }
 
diff -urN linux-2.6.5/net/core/flow.c linux-2.6.5_smp/net/core/flow.c
--- linux-2.6.5/net/core/flow.c	2004-04-04 05:36:15.000000000 +0200
+++ linux-2.6.5_smp/net/core/flow.c	2004-04-14 14:06:19.000000000 +0200
@@ -292,7 +292,7 @@
 	init_completion(&info.completion);
 
 	local_bh_disable();
-	smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
+	on_other_cpus(flow_cache_flush_per_cpu, &info, 1, 0);
 	flow_cache_flush_tasklet((unsigned long)&info);
 	local_bh_enable();
 
