From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 27/28] atomic: Replace atomic_{set,clear}_mask() usage
Date: Thu, 16 Jul 2015 19:21:37 +0200
Message-ID: <20150716172926.571899873@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-mask-remove.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Replace the deprecated atomic_{set,clear}_mask() usage with the now
ubiquous atomic_{or,andnot}() functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/blackfin/mach-common/smp.c |    2 -
 arch/m32r/kernel/smp.c          |    4 +-
 arch/mn10300/mm/tlb-smp.c       |    2 -
 arch/s390/kernel/time.c         |    4 +-
 arch/s390/kvm/interrupt.c       |   30 +++++++++----------
 arch/s390/kvm/kvm-s390.c        |   32 ++++++++++----------
 drivers/gpu/drm/i915/i915_drv.c |    2 -
 drivers/gpu/drm/i915/i915_gem.c |    2 -
 drivers/gpu/drm/i915/i915_irq.c |    4 +-
 drivers/s390/scsi/zfcp_aux.c    |    2 -
 drivers/s390/scsi/zfcp_erp.c    |   62 ++++++++++++++++++++--------------------
 drivers/s390/scsi/zfcp_fc.c     |    8 ++---
 drivers/s390/scsi/zfcp_fsf.c    |   26 ++++++++--------
 drivers/s390/scsi/zfcp_qdio.c   |   14 ++++-----
 14 files changed, 97 insertions(+), 97 deletions(-)

--- a/arch/blackfin/mach-common/smp.c
+++ b/arch/blackfin/mach-common/smp.c
@@ -195,7 +195,7 @@ void send_ipi(const struct cpumask *cpum
 	local_irq_save(flags);
 	for_each_cpu(cpu, cpumask) {
 		bfin_ipi_data = &per_cpu(bfin_ipi, cpu);
-		atomic_set_mask((1 << msg), &bfin_ipi_data->bits);
+		atomic_or((1 << msg), &bfin_ipi_data->bits);
 		atomic_inc(&bfin_ipi_data->count);
 	}
 	local_irq_restore(flags);
--- a/arch/m32r/kernel/smp.c
+++ b/arch/m32r/kernel/smp.c
@@ -156,7 +156,7 @@ void smp_flush_cache_all(void)
 	cpumask_clear_cpu(smp_processor_id(), &cpumask);
 	spin_lock(&flushcache_lock);
 	mask=cpumask_bits(&cpumask);
-	atomic_set_mask(*mask, (atomic_t *)&flushcache_cpumask);
+	atomic_or(*mask, (atomic_t *)&flushcache_cpumask);
 	send_IPI_mask(&cpumask, INVALIDATE_CACHE_IPI, 0);
 	_flush_cache_copyback_all();
 	while (flushcache_cpumask)
@@ -407,7 +407,7 @@ static void flush_tlb_others(cpumask_t c
 	flush_vma = vma;
 	flush_va = va;
 	mask=cpumask_bits(&cpumask);
-	atomic_set_mask(*mask, (atomic_t *)&flush_cpumask);
+	atomic_or(*mask, (atomic_t *)&flush_cpumask);
 
 	/*
 	 * We have to send the IPI only to
--- a/arch/mn10300/mm/tlb-smp.c
+++ b/arch/mn10300/mm/tlb-smp.c
@@ -119,7 +119,7 @@ static void flush_tlb_others(cpumask_t c
 	flush_mm = mm;
 	flush_va = va;
 #if NR_CPUS <= BITS_PER_LONG
-	atomic_set_mask(cpumask.bits[0], &flush_cpumask.bits[0]);
+	atomic_or(cpumask.bits[0], (atomic_t *)&flush_cpumask.bits[0]);
 #else
 #error Not supported.
 #endif
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -381,7 +381,7 @@ static void disable_sync_clock(void *dum
 	 * increase the "sequence" counter to avoid the race of an
 	 * etr event and the complete recovery against get_sync_clock.
 	 */
-	atomic_clear_mask(0x80000000, sw_ptr);
+	atomic_andnot(0x80000000, sw_ptr);
 	atomic_inc(sw_ptr);
 }
 
@@ -392,7 +392,7 @@ static void disable_sync_clock(void *dum
 static void enable_sync_clock(void)
 {
 	atomic_t *sw_ptr = this_cpu_ptr(&clock_sync_word);
-	atomic_set_mask(0x80000000, sw_ptr);
+	atomic_or(0x80000000, sw_ptr);
 }
 
 /*
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -170,20 +170,20 @@ static unsigned long deliverable_irqs(st
 
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
-	atomic_set_mask(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	atomic_or(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
 	set_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
 }
 
 static void __unset_cpu_idle(struct kvm_vcpu *vcpu)
 {
-	atomic_clear_mask(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	atomic_andnot(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
 	clear_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
 }
 
 static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 {
-	atomic_clear_mask(CPUSTAT_IO_INT | CPUSTAT_EXT_INT | CPUSTAT_STOP_INT,
-			  &vcpu->arch.sie_block->cpuflags);
+	atomic_andnot(CPUSTAT_IO_INT | CPUSTAT_EXT_INT | CPUSTAT_STOP_INT,
+		    &vcpu->arch.sie_block->cpuflags);
 	vcpu->arch.sie_block->lctl = 0x0000;
 	vcpu->arch.sie_block->ictl &= ~(ICTL_LPSW | ICTL_STCTL | ICTL_PINT);
 
@@ -196,7 +196,7 @@ static void __reset_intercept_indicators
 
 static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
 {
-	atomic_set_mask(flag, &vcpu->arch.sie_block->cpuflags);
+	atomic_or(flag, &vcpu->arch.sie_block->cpuflags);
 }
 
 static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
@@ -919,7 +919,7 @@ void kvm_s390_clear_local_irqs(struct kv
 	spin_unlock(&li->lock);
 
 	/* clear pending external calls set by sigp interpretation facility */
-	atomic_clear_mask(CPUSTAT_ECALL_PEND, li->cpuflags);
+	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
 	vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl = 0;
 }
 
@@ -1020,7 +1020,7 @@ static int __inject_pfault_init(struct k
 
 	li->irq.ext = irq->u.ext;
 	set_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
@@ -1035,7 +1035,7 @@ static int __inject_extcall_sigpif(struc
 		/* another external call is pending */
 		return -EBUSY;
 	}
-	atomic_set_mask(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
+	atomic_or(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
 	return 0;
 }
 
@@ -1061,7 +1061,7 @@ static int __inject_extcall(struct kvm_v
 	if (test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
 		return -EBUSY;
 	*extcall = irq->u.extcall;
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
@@ -1133,7 +1133,7 @@ static int __inject_sigp_emergency(struc
 
 	set_bit(irq->u.emerg.code, li->sigp_emerg_pending);
 	set_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
@@ -1177,7 +1177,7 @@ static int __inject_ckc(struct kvm_vcpu
 				   0, 0, 2);
 
 	set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
@@ -1190,7 +1190,7 @@ static int __inject_cpu_timer(struct kvm
 				   0, 0, 2);
 
 	set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+	atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
@@ -1369,13 +1369,13 @@ static void __floating_irq_kick(struct k
 	spin_lock(&li->lock);
 	switch (type) {
 	case KVM_S390_MCHK:
-		atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
+		atomic_or(CPUSTAT_STOP_INT, li->cpuflags);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		atomic_set_mask(CPUSTAT_IO_INT, li->cpuflags);
+		atomic_or(CPUSTAT_IO_INT, li->cpuflags);
 		break;
 	default:
-		atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+		atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
 		break;
 	}
 	spin_unlock(&li->lock);
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1215,12 +1215,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
 	}
 	restore_access_regs(vcpu->run->s.regs.acrs);
 	gmap_enable(vcpu->arch.gmap);
-	atomic_set_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	atomic_clear_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	atomic_andnot(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	gmap_disable(vcpu->arch.gmap);
 	if (test_kvm_facility(vcpu->kvm, 129)) {
 		save_fp_ctl(&vcpu->run->s.regs.fpc);
@@ -1320,9 +1320,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu
 						    CPUSTAT_STOPPED);
 
 	if (test_kvm_facility(vcpu->kvm, 78))
-		atomic_set_mask(CPUSTAT_GED2, &vcpu->arch.sie_block->cpuflags);
+		atomic_or(CPUSTAT_GED2, &vcpu->arch.sie_block->cpuflags);
 	else if (test_kvm_facility(vcpu->kvm, 8))
-		atomic_set_mask(CPUSTAT_GED, &vcpu->arch.sie_block->cpuflags);
+		atomic_or(CPUSTAT_GED, &vcpu->arch.sie_block->cpuflags);
 
 	kvm_s390_vcpu_setup_model(vcpu);
 
@@ -1422,24 +1422,24 @@ int kvm_arch_vcpu_runnable(struct kvm_vc
 
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu)
 {
-	atomic_set_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
+	atomic_or(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
 	exit_sie(vcpu);
 }
 
 void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu)
 {
-	atomic_clear_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
+	atomic_andnot(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
 }
 
 static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
 {
-	atomic_set_mask(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
+	atomic_or(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
 	exit_sie(vcpu);
 }
 
 static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
 {
-	atomic_clear_mask(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
+	atomic_or(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
 }
 
 /*
@@ -1448,7 +1448,7 @@ static void kvm_s390_vcpu_request_handle
  * return immediately. */
 void exit_sie(struct kvm_vcpu *vcpu)
 {
-	atomic_set_mask(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
+	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
 	while (vcpu->arch.sie_block->prog0c & PROG_IN_SIE)
 		cpu_relax();
 }
@@ -1672,19 +1672,19 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
 		/* enforce guest PER */
-		atomic_set_mask(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+		atomic_or(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
 
 		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
 			rc = kvm_s390_import_bp_data(vcpu, dbg);
 	} else {
-		atomic_clear_mask(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
 		vcpu->arch.guestdbg.last_bp = 0;
 	}
 
 	if (rc) {
 		vcpu->guest_debug = 0;
 		kvm_s390_clear_bp_data(vcpu);
-		atomic_clear_mask(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
 	}
 
 	return rc;
@@ -1771,7 +1771,7 @@ static int kvm_s390_handle_requests(stru
 	if (kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu)) {
 		if (!ibs_enabled(vcpu)) {
 			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 1);
-			atomic_set_mask(CPUSTAT_IBS,
+			atomic_or(CPUSTAT_IBS,
 					&vcpu->arch.sie_block->cpuflags);
 		}
 		goto retry;
@@ -1780,7 +1780,7 @@ static int kvm_s390_handle_requests(stru
 	if (kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu)) {
 		if (ibs_enabled(vcpu)) {
 			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 0);
-			atomic_clear_mask(CPUSTAT_IBS,
+			atomic_andnot(CPUSTAT_IBS,
 					  &vcpu->arch.sie_block->cpuflags);
 		}
 		goto retry;
@@ -2280,7 +2280,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu
 		__disable_ibs_on_all_vcpus(vcpu->kvm);
 	}
 
-	atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	atomic_andnot(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 	/*
 	 * Another VCPU might have used IBS while we were offline.
 	 * Let's play safe and flush the VCPU at startup.
@@ -2306,7 +2306,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu
 	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
 	kvm_s390_clear_stop_irq(vcpu);
 
-	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	atomic_or(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 	__disable_ibs_on_vcpu(vcpu);
 
 	for (i = 0; i < online_vcpus; i++) {
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -748,7 +748,7 @@ static int i915_drm_resume(struct drm_de
 	mutex_lock(&dev->struct_mutex);
 	if (i915_gem_init_hw(dev)) {
 		DRM_ERROR("failed to re-initialize GPU, declaring wedged!\n");
-		atomic_set_mask(I915_WEDGED, &dev_priv->gpu_error.reset_counter);
+			atomic_or(I915_WEDGED, &dev_priv->gpu_error.reset_counter);
 	}
 	mutex_unlock(&dev->struct_mutex);
 
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -5092,7 +5092,7 @@ int i915_gem_init(struct drm_device *dev
 		 * for all other failure, such as an allocation failure, bail.
 		 */
 		DRM_ERROR("Failed to initialize GPU, declaring it wedged\n");
-		atomic_set_mask(I915_WEDGED, &dev_priv->gpu_error.reset_counter);
+		atomic_or(I915_WEDGED, &dev_priv->gpu_error.reset_counter);
 		ret = 0;
 	}
 
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -2446,7 +2446,7 @@ static void i915_reset_and_wakeup(struct
 			kobject_uevent_env(&dev->primary->kdev->kobj,
 					   KOBJ_CHANGE, reset_done_event);
 		} else {
-			atomic_set_mask(I915_WEDGED, &error->reset_counter);
+			atomic_or(I915_WEDGED, &error->reset_counter);
 		}
 
 		/*
@@ -2574,7 +2574,7 @@ void i915_handle_error(struct drm_device
 	i915_report_and_clear_eir(dev);
 
 	if (wedged) {
-		atomic_set_mask(I915_RESET_IN_PROGRESS_FLAG,
+		atomic_or(I915_RESET_IN_PROGRESS_FLAG,
 				&dev_priv->gpu_error.reset_counter);
 
 		/*
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -529,7 +529,7 @@ struct zfcp_port *zfcp_port_enqueue(stru
 	list_add_tail(&port->list, &adapter->port_list);
 	write_unlock_irq(&adapter->port_list_lock);
 
-	atomic_set_mask(status | ZFCP_STATUS_COMMON_RUNNING, &port->status);
+	atomic_or(status | ZFCP_STATUS_COMMON_RUNNING, &port->status);
 
 	return port;
 
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -190,7 +190,7 @@ static struct zfcp_erp_action *zfcp_erp_
 		if (!(act_status & ZFCP_STATUS_ERP_NO_REF))
 			if (scsi_device_get(sdev))
 				return NULL;
-		atomic_set_mask(ZFCP_STATUS_COMMON_ERP_INUSE,
+		atomic_or(ZFCP_STATUS_COMMON_ERP_INUSE,
 				&zfcp_sdev->status);
 		erp_action = &zfcp_sdev->erp_action;
 		memset(erp_action, 0, sizeof(struct zfcp_erp_action));
@@ -206,7 +206,7 @@ static struct zfcp_erp_action *zfcp_erp_
 		if (!get_device(&port->dev))
 			return NULL;
 		zfcp_erp_action_dismiss_port(port);
-		atomic_set_mask(ZFCP_STATUS_COMMON_ERP_INUSE, &port->status);
+		atomic_or(ZFCP_STATUS_COMMON_ERP_INUSE, &port->status);
 		erp_action = &port->erp_action;
 		memset(erp_action, 0, sizeof(struct zfcp_erp_action));
 		erp_action->port = port;
@@ -217,7 +217,7 @@ static struct zfcp_erp_action *zfcp_erp_
 	case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
 		kref_get(&adapter->ref);
 		zfcp_erp_action_dismiss_adapter(adapter);
-		atomic_set_mask(ZFCP_STATUS_COMMON_ERP_INUSE, &adapter->status);
+		atomic_or(ZFCP_STATUS_COMMON_ERP_INUSE, &adapter->status);
 		erp_action = &adapter->erp_action;
 		memset(erp_action, 0, sizeof(struct zfcp_erp_action));
 		if (!(atomic_read(&adapter->status) &
@@ -254,7 +254,7 @@ static int zfcp_erp_action_enqueue(int w
 	act = zfcp_erp_setup_act(need, act_status, adapter, port, sdev);
 	if (!act)
 		goto out;
-	atomic_set_mask(ZFCP_STATUS_ADAPTER_ERP_PENDING, &adapter->status);
+	atomic_or(ZFCP_STATUS_ADAPTER_ERP_PENDING, &adapter->status);
 	++adapter->erp_total_count;
 	list_add_tail(&act->list, &adapter->erp_ready_head);
 	wake_up(&adapter->erp_ready_wq);
@@ -486,14 +486,14 @@ static void zfcp_erp_adapter_unblock(str
 {
 	if (status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED, &adapter->status))
 		zfcp_dbf_rec_run("eraubl1", &adapter->erp_action);
-	atomic_set_mask(ZFCP_STATUS_COMMON_UNBLOCKED, &adapter->status);
+	atomic_or(ZFCP_STATUS_COMMON_UNBLOCKED, &adapter->status);
 }
 
 static void zfcp_erp_port_unblock(struct zfcp_port *port)
 {
 	if (status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED, &port->status))
 		zfcp_dbf_rec_run("erpubl1", &port->erp_action);
-	atomic_set_mask(ZFCP_STATUS_COMMON_UNBLOCKED, &port->status);
+	atomic_or(ZFCP_STATUS_COMMON_UNBLOCKED, &port->status);
 }
 
 static void zfcp_erp_lun_unblock(struct scsi_device *sdev)
@@ -502,7 +502,7 @@ static void zfcp_erp_lun_unblock(struct
 
 	if (status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED, &zfcp_sdev->status))
 		zfcp_dbf_rec_run("erlubl1", &sdev_to_zfcp(sdev)->erp_action);
-	atomic_set_mask(ZFCP_STATUS_COMMON_UNBLOCKED, &zfcp_sdev->status);
+	atomic_or(ZFCP_STATUS_COMMON_UNBLOCKED, &zfcp_sdev->status);
 }
 
 static void zfcp_erp_action_to_running(struct zfcp_erp_action *erp_action)
@@ -642,7 +642,7 @@ static void zfcp_erp_wakeup(struct zfcp_
 	read_lock_irqsave(&adapter->erp_lock, flags);
 	if (list_empty(&adapter->erp_ready_head) &&
 	    list_empty(&adapter->erp_running_head)) {
-			atomic_clear_mask(ZFCP_STATUS_ADAPTER_ERP_PENDING,
+			atomic_andnot(ZFCP_STATUS_ADAPTER_ERP_PENDING,
 					  &adapter->status);
 			wake_up(&adapter->erp_done_wqh);
 	}
@@ -665,16 +665,16 @@ static int zfcp_erp_adapter_strat_fsf_xc
 	int sleep = 1;
 	struct zfcp_adapter *adapter = erp_action->adapter;
 
-	atomic_clear_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK, &adapter->status);
+	atomic_andnot(ZFCP_STATUS_ADAPTER_XCONFIG_OK, &adapter->status);
 
 	for (retries = 7; retries; retries--) {
-		atomic_clear_mask(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
+		atomic_andnot(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
 				  &adapter->status);
 		write_lock_irq(&adapter->erp_lock);
 		zfcp_erp_action_to_running(erp_action);
 		write_unlock_irq(&adapter->erp_lock);
 		if (zfcp_fsf_exchange_config_data(erp_action)) {
-			atomic_clear_mask(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
+			atomic_andnot(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
 					  &adapter->status);
 			return ZFCP_ERP_FAILED;
 		}
@@ -692,7 +692,7 @@ static int zfcp_erp_adapter_strat_fsf_xc
 		sleep *= 2;
 	}
 
-	atomic_clear_mask(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
+	atomic_andnot(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
 			  &adapter->status);
 
 	if (!(atomic_read(&adapter->status) & ZFCP_STATUS_ADAPTER_XCONFIG_OK))
@@ -764,7 +764,7 @@ static void zfcp_erp_adapter_strategy_cl
 	/* all ports and LUNs are closed */
 	zfcp_erp_clear_adapter_status(adapter, ZFCP_STATUS_COMMON_OPEN);
 
-	atomic_clear_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK |
+	atomic_andnot(ZFCP_STATUS_ADAPTER_XCONFIG_OK |
 			  ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED, &adapter->status);
 }
 
@@ -773,7 +773,7 @@ static int zfcp_erp_adapter_strategy_ope
 	struct zfcp_adapter *adapter = act->adapter;
 
 	if (zfcp_qdio_open(adapter->qdio)) {
-		atomic_clear_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK |
+		atomic_andnot(ZFCP_STATUS_ADAPTER_XCONFIG_OK |
 				  ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED,
 				  &adapter->status);
 		return ZFCP_ERP_FAILED;
@@ -784,7 +784,7 @@ static int zfcp_erp_adapter_strategy_ope
 		return ZFCP_ERP_FAILED;
 	}
 
-	atomic_set_mask(ZFCP_STATUS_COMMON_OPEN, &adapter->status);
+	atomic_or(ZFCP_STATUS_COMMON_OPEN, &adapter->status);
 
 	return ZFCP_ERP_SUCCEEDED;
 }
@@ -948,7 +948,7 @@ static void zfcp_erp_lun_strategy_clears
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 
-	atomic_clear_mask(ZFCP_STATUS_COMMON_ACCESS_DENIED,
+	atomic_andnot(ZFCP_STATUS_COMMON_ACCESS_DENIED,
 			  &zfcp_sdev->status);
 }
 
@@ -1187,18 +1187,18 @@ static void zfcp_erp_action_dequeue(stru
 	switch (erp_action->action) {
 	case ZFCP_ERP_ACTION_REOPEN_LUN:
 		zfcp_sdev = sdev_to_zfcp(erp_action->sdev);
-		atomic_clear_mask(ZFCP_STATUS_COMMON_ERP_INUSE,
+		atomic_andnot(ZFCP_STATUS_COMMON_ERP_INUSE,
 				  &zfcp_sdev->status);
 		break;
 
 	case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
 	case ZFCP_ERP_ACTION_REOPEN_PORT:
-		atomic_clear_mask(ZFCP_STATUS_COMMON_ERP_INUSE,
+		atomic_andnot(ZFCP_STATUS_COMMON_ERP_INUSE,
 				  &erp_action->port->status);
 		break;
 
 	case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
-		atomic_clear_mask(ZFCP_STATUS_COMMON_ERP_INUSE,
+		atomic_andnot(ZFCP_STATUS_COMMON_ERP_INUSE,
 				  &erp_action->adapter->status);
 		break;
 	}
@@ -1422,19 +1422,19 @@ void zfcp_erp_set_adapter_status(struct
 	unsigned long flags;
 	u32 common_mask = mask & ZFCP_COMMON_FLAGS;
 
-	atomic_set_mask(mask, &adapter->status);
+	atomic_or(mask, &adapter->status);
 
 	if (!common_mask)
 		return;
 
 	read_lock_irqsave(&adapter->port_list_lock, flags);
 	list_for_each_entry(port, &adapter->port_list, list)
-		atomic_set_mask(common_mask, &port->status);
+		atomic_or(common_mask, &port->status);
 	read_unlock_irqrestore(&adapter->port_list_lock, flags);
 
 	spin_lock_irqsave(adapter->scsi_host->host_lock, flags);
 	__shost_for_each_device(sdev, adapter->scsi_host)
-		atomic_set_mask(common_mask, &sdev_to_zfcp(sdev)->status);
+		atomic_or(common_mask, &sdev_to_zfcp(sdev)->status);
 	spin_unlock_irqrestore(adapter->scsi_host->host_lock, flags);
 }
 
@@ -1453,7 +1453,7 @@ void zfcp_erp_clear_adapter_status(struc
 	u32 common_mask = mask & ZFCP_COMMON_FLAGS;
 	u32 clear_counter = mask & ZFCP_STATUS_COMMON_ERP_FAILED;
 
-	atomic_clear_mask(mask, &adapter->status);
+	atomic_andnot(mask, &adapter->status);
 
 	if (!common_mask)
 		return;
@@ -1463,7 +1463,7 @@ void zfcp_erp_clear_adapter_status(struc
 
 	read_lock_irqsave(&adapter->port_list_lock, flags);
 	list_for_each_entry(port, &adapter->port_list, list) {
-		atomic_clear_mask(common_mask, &port->status);
+		atomic_andnot(common_mask, &port->status);
 		if (clear_counter)
 			atomic_set(&port->erp_counter, 0);
 	}
@@ -1471,7 +1471,7 @@ void zfcp_erp_clear_adapter_status(struc
 
 	spin_lock_irqsave(adapter->scsi_host->host_lock, flags);
 	__shost_for_each_device(sdev, adapter->scsi_host) {
-		atomic_clear_mask(common_mask, &sdev_to_zfcp(sdev)->status);
+		atomic_andnot(common_mask, &sdev_to_zfcp(sdev)->status);
 		if (clear_counter)
 			atomic_set(&sdev_to_zfcp(sdev)->erp_counter, 0);
 	}
@@ -1491,7 +1491,7 @@ void zfcp_erp_set_port_status(struct zfc
 	u32 common_mask = mask & ZFCP_COMMON_FLAGS;
 	unsigned long flags;
 
-	atomic_set_mask(mask, &port->status);
+	atomic_or(mask, &port->status);
 
 	if (!common_mask)
 		return;
@@ -1499,7 +1499,7 @@ void zfcp_erp_set_port_status(struct zfc
 	spin_lock_irqsave(port->adapter->scsi_host->host_lock, flags);
 	__shost_for_each_device(sdev, port->adapter->scsi_host)
 		if (sdev_to_zfcp(sdev)->port == port)
-			atomic_set_mask(common_mask,
+			atomic_or(common_mask,
 					&sdev_to_zfcp(sdev)->status);
 	spin_unlock_irqrestore(port->adapter->scsi_host->host_lock, flags);
 }
@@ -1518,7 +1518,7 @@ void zfcp_erp_clear_port_status(struct z
 	u32 clear_counter = mask & ZFCP_STATUS_COMMON_ERP_FAILED;
 	unsigned long flags;
 
-	atomic_clear_mask(mask, &port->status);
+	atomic_andnot(mask, &port->status);
 
 	if (!common_mask)
 		return;
@@ -1529,7 +1529,7 @@ void zfcp_erp_clear_port_status(struct z
 	spin_lock_irqsave(port->adapter->scsi_host->host_lock, flags);
 	__shost_for_each_device(sdev, port->adapter->scsi_host)
 		if (sdev_to_zfcp(sdev)->port == port) {
-			atomic_clear_mask(common_mask,
+			atomic_andnot(common_mask,
 					  &sdev_to_zfcp(sdev)->status);
 			if (clear_counter)
 				atomic_set(&sdev_to_zfcp(sdev)->erp_counter, 0);
@@ -1546,7 +1546,7 @@ void zfcp_erp_set_lun_status(struct scsi
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 
-	atomic_set_mask(mask, &zfcp_sdev->status);
+	atomic_or(mask, &zfcp_sdev->status);
 }
 
 /**
@@ -1558,7 +1558,7 @@ void zfcp_erp_clear_lun_status(struct sc
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 
-	atomic_clear_mask(mask, &zfcp_sdev->status);
+	atomic_andnot(mask, &zfcp_sdev->status);
 
 	if (mask & ZFCP_STATUS_COMMON_ERP_FAILED)
 		atomic_set(&zfcp_sdev->erp_counter, 0);
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -508,7 +508,7 @@ static void zfcp_fc_adisc_handler(void *
 	/* port is good, unblock rport without going through erp */
 	zfcp_scsi_schedule_rport_register(port);
  out:
-	atomic_clear_mask(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
+	atomic_andnot(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
 	put_device(&port->dev);
 	kmem_cache_free(zfcp_fc_req_cache, fc_req);
 }
@@ -564,14 +564,14 @@ void zfcp_fc_link_test_work(struct work_
 	if (atomic_read(&port->status) & ZFCP_STATUS_PORT_LINK_TEST)
 		goto out;
 
-	atomic_set_mask(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
+	atomic_or(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
 
 	retval = zfcp_fc_adisc(port);
 	if (retval == 0)
 		return;
 
 	/* send of ADISC was not possible */
-	atomic_clear_mask(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
+	atomic_andnot(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
 	zfcp_erp_port_forced_reopen(port, 0, "fcltwk1");
 
 out:
@@ -640,7 +640,7 @@ static void zfcp_fc_validate_port(struct
 	if (!(atomic_read(&port->status) & ZFCP_STATUS_COMMON_NOESC))
 		return;
 
-	atomic_clear_mask(ZFCP_STATUS_COMMON_NOESC, &port->status);
+	atomic_andnot(ZFCP_STATUS_COMMON_NOESC, &port->status);
 
 	if ((port->supported_classes != 0) ||
 	    !list_empty(&port->unit_list))
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -114,7 +114,7 @@ static void zfcp_fsf_link_down_info_eval
 	if (atomic_read(&adapter->status) & ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED)
 		return;
 
-	atomic_set_mask(ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED, &adapter->status);
+	atomic_or(ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED, &adapter->status);
 
 	zfcp_scsi_schedule_rports_block(adapter);
 
@@ -345,7 +345,7 @@ static void zfcp_fsf_protstatus_eval(str
 		zfcp_erp_adapter_shutdown(adapter, 0, "fspse_3");
 		break;
 	case FSF_PROT_HOST_CONNECTION_INITIALIZING:
-		atomic_set_mask(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
+		atomic_or(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
 				&adapter->status);
 		break;
 	case FSF_PROT_DUPLICATE_REQUEST_ID:
@@ -554,7 +554,7 @@ static void zfcp_fsf_exchange_config_dat
 			zfcp_erp_adapter_shutdown(adapter, 0, "fsecdh1");
 			return;
 		}
-		atomic_set_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
+		atomic_or(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
 				&adapter->status);
 		break;
 	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
@@ -567,7 +567,7 @@ static void zfcp_fsf_exchange_config_dat
 
 		/* avoids adapter shutdown to be able to recognize
 		 * events such as LINK UP */
-		atomic_set_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
+		atomic_or(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
 				&adapter->status);
 		zfcp_fsf_link_down_info_eval(req,
 			&qtcb->header.fsf_status_qual.link_down_info);
@@ -1394,9 +1394,9 @@ static void zfcp_fsf_open_port_handler(s
 		break;
 	case FSF_GOOD:
 		port->handle = header->port_handle;
-		atomic_set_mask(ZFCP_STATUS_COMMON_OPEN |
+		atomic_or(ZFCP_STATUS_COMMON_OPEN |
 				ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
-		atomic_clear_mask(ZFCP_STATUS_COMMON_ACCESS_BOXED,
+		atomic_andnot(ZFCP_STATUS_COMMON_ACCESS_BOXED,
 		                  &port->status);
 		/* check whether D_ID has changed during open */
 		/*
@@ -1677,10 +1677,10 @@ static void zfcp_fsf_close_physical_port
 	case FSF_PORT_BOXED:
 		/* can't use generic zfcp_erp_modify_port_status because
 		 * ZFCP_STATUS_COMMON_OPEN must not be reset for the port */
-		atomic_clear_mask(ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
+		atomic_andnot(ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
 		shost_for_each_device(sdev, port->adapter->scsi_host)
 			if (sdev_to_zfcp(sdev)->port == port)
-				atomic_clear_mask(ZFCP_STATUS_COMMON_OPEN,
+				atomic_andnot(ZFCP_STATUS_COMMON_OPEN,
 						  &sdev_to_zfcp(sdev)->status);
 		zfcp_erp_set_port_status(port, ZFCP_STATUS_COMMON_ACCESS_BOXED);
 		zfcp_erp_port_reopen(port, ZFCP_STATUS_COMMON_ERP_FAILED,
@@ -1700,10 +1700,10 @@ static void zfcp_fsf_close_physical_port
 		/* can't use generic zfcp_erp_modify_port_status because
 		 * ZFCP_STATUS_COMMON_OPEN must not be reset for the port
 		 */
-		atomic_clear_mask(ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
+		atomic_andnot(ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
 		shost_for_each_device(sdev, port->adapter->scsi_host)
 			if (sdev_to_zfcp(sdev)->port == port)
-				atomic_clear_mask(ZFCP_STATUS_COMMON_OPEN,
+				atomic_andnot(ZFCP_STATUS_COMMON_OPEN,
 						  &sdev_to_zfcp(sdev)->status);
 		break;
 	}
@@ -1766,7 +1766,7 @@ static void zfcp_fsf_open_lun_handler(st
 
 	zfcp_sdev = sdev_to_zfcp(sdev);
 
-	atomic_clear_mask(ZFCP_STATUS_COMMON_ACCESS_DENIED |
+	atomic_andnot(ZFCP_STATUS_COMMON_ACCESS_DENIED |
 			  ZFCP_STATUS_COMMON_ACCESS_BOXED,
 			  &zfcp_sdev->status);
 
@@ -1822,7 +1822,7 @@ static void zfcp_fsf_open_lun_handler(st
 
 	case FSF_GOOD:
 		zfcp_sdev->lun_handle = header->lun_handle;
-		atomic_set_mask(ZFCP_STATUS_COMMON_OPEN, &zfcp_sdev->status);
+		atomic_or(ZFCP_STATUS_COMMON_OPEN, &zfcp_sdev->status);
 		break;
 	}
 }
@@ -1913,7 +1913,7 @@ static void zfcp_fsf_close_lun_handler(s
 		}
 		break;
 	case FSF_GOOD:
-		atomic_clear_mask(ZFCP_STATUS_COMMON_OPEN, &zfcp_sdev->status);
+		atomic_andnot(ZFCP_STATUS_COMMON_OPEN, &zfcp_sdev->status);
 		break;
 	}
 }
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -349,7 +349,7 @@ void zfcp_qdio_close(struct zfcp_qdio *q
 
 	/* clear QDIOUP flag, thus do_QDIO is not called during qdio_shutdown */
 	spin_lock_irq(&qdio->req_q_lock);
-	atomic_clear_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
+	atomic_andnot(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
 	spin_unlock_irq(&qdio->req_q_lock);
 
 	wake_up(&qdio->req_q_wq);
@@ -384,7 +384,7 @@ int zfcp_qdio_open(struct zfcp_qdio *qdi
 	if (atomic_read(&adapter->status) & ZFCP_STATUS_ADAPTER_QDIOUP)
 		return -EIO;
 
-	atomic_clear_mask(ZFCP_STATUS_ADAPTER_SIOSL_ISSUED,
+	atomic_andnot(ZFCP_STATUS_ADAPTER_SIOSL_ISSUED,
 			  &qdio->adapter->status);
 
 	zfcp_qdio_setup_init_data(&init_data, qdio);
@@ -396,14 +396,14 @@ int zfcp_qdio_open(struct zfcp_qdio *qdi
 		goto failed_qdio;
 
 	if (ssqd.qdioac2 & CHSC_AC2_DATA_DIV_ENABLED)
-		atomic_set_mask(ZFCP_STATUS_ADAPTER_DATA_DIV_ENABLED,
+		atomic_or(ZFCP_STATUS_ADAPTER_DATA_DIV_ENABLED,
 				&qdio->adapter->status);
 
 	if (ssqd.qdioac2 & CHSC_AC2_MULTI_BUFFER_ENABLED) {
-		atomic_set_mask(ZFCP_STATUS_ADAPTER_MB_ACT, &adapter->status);
+		atomic_or(ZFCP_STATUS_ADAPTER_MB_ACT, &adapter->status);
 		qdio->max_sbale_per_sbal = QDIO_MAX_ELEMENTS_PER_BUFFER;
 	} else {
-		atomic_clear_mask(ZFCP_STATUS_ADAPTER_MB_ACT, &adapter->status);
+		atomic_andnot(ZFCP_STATUS_ADAPTER_MB_ACT, &adapter->status);
 		qdio->max_sbale_per_sbal = QDIO_MAX_ELEMENTS_PER_BUFFER - 1;
 	}
 
@@ -427,7 +427,7 @@ int zfcp_qdio_open(struct zfcp_qdio *qdi
 	/* set index of first available SBALS / number of available SBALS */
 	qdio->req_q_idx = 0;
 	atomic_set(&qdio->req_q_free, QDIO_MAX_BUFFERS_PER_Q);
-	atomic_set_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &qdio->adapter->status);
+	atomic_or(ZFCP_STATUS_ADAPTER_QDIOUP, &qdio->adapter->status);
 
 	if (adapter->scsi_host) {
 		adapter->scsi_host->sg_tablesize = qdio->max_sbale_per_req;
@@ -499,6 +499,6 @@ void zfcp_qdio_siosl(struct zfcp_adapter
 
 	rc = ccw_device_siosl(adapter->ccw_device);
 	if (!rc)
-		atomic_set_mask(ZFCP_STATUS_ADAPTER_SIOSL_ISSUED,
+		atomic_or(ZFCP_STATUS_ADAPTER_SIOSL_ISSUED,
 				&adapter->status);
 }
