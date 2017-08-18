From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 3/6] treewide: add missing trailing semicolons to initcall() invocations
Date: Fri, 18 Aug 2017 12:26:21 +0100
Message-ID: <20170818112624.24991-4-ard.biesheuvel@linaro.org>
References: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35724 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdHRL07 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 07:26:59 -0400
Received: by mail-wr0-f171.google.com with SMTP id 49so58876658wrw.2
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 04:26:58 -0700 (PDT)
In-Reply-To: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Nicolas Pitre <nico@linaro.org>, Steve

Before modifying the initcall() code to add support for relative
references in the initcall sections, fix the existing code that
lacks the required trailing semicolon so we can remove it from the
macros.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/perf_event.c           | 2 +-
 arch/s390/hypfs/inode.c                  | 2 +-
 arch/x86/events/intel/core.c             | 2 +-
 drivers/net/cris/eth_v10.c               | 2 +-
 drivers/net/dsa/dsa_loop_bdinfo.c        | 2 +-
 drivers/parport/procfs.c                 | 4 ++--
 drivers/perf/arm_pmu_acpi.c              | 2 +-
 drivers/platform/x86/intel_turbo_max_3.c | 2 +-
 fs/hugetlbfs/inode.c                     | 2 +-
 mm/compaction.c                          | 2 +-
 mm/oom_kill.c                            | 2 +-
 mm/page_alloc.c                          | 2 +-
 mm/page_owner.c                          | 2 +-
 net/core/lwt_bpf.c                       | 2 +-
 net/sched/sch_blackhole.c                | 2 +-
 sound/core/seq_device.c                  | 4 ++--
 16 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index b5798ba21189..b8e866f08d27 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1172,4 +1172,4 @@ static int __init armv8_pmu_driver_init(void)
 	else
 		return arm_pmu_acpi_probe(armv8_pmuv3_init);
 }
-device_initcall(armv8_pmu_driver_init)
+device_initcall(armv8_pmu_driver_init);
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index cf8a2d92467f..0876f49ff6e9 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -498,4 +498,4 @@ static int __init hypfs_init(void)
 	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 	return rc;
 }
-device_initcall(hypfs_init)
+device_initcall(hypfs_init);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 98b0f0729527..2510b00aa152 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4340,4 +4340,4 @@ static __init int fixup_ht_bug(void)
 	pr_info("PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off\n");
 	return 0;
 }
-subsys_initcall(fixup_ht_bug)
+subsys_initcall(fixup_ht_bug);
diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
index 017f48cdcab9..2494b2d47210 100644
--- a/drivers/net/cris/eth_v10.c
+++ b/drivers/net/cris/eth_v10.c
@@ -408,7 +408,7 @@ etrax_ethernet_init(void)
 	led_next_time = jiffies;
 	return 0;
 }
-device_initcall(etrax_ethernet_init)
+device_initcall(etrax_ethernet_init);
 
 /* set MAC address of the interface. called from the core after a
  * SIOCSIFADDR ioctl, and from the bootup above.
diff --git a/drivers/net/dsa/dsa_loop_bdinfo.c b/drivers/net/dsa/dsa_loop_bdinfo.c
index fb8d5dc71013..62c2c2d60752 100644
--- a/drivers/net/dsa/dsa_loop_bdinfo.c
+++ b/drivers/net/dsa/dsa_loop_bdinfo.c
@@ -29,6 +29,6 @@ static int __init dsa_loop_bdinfo_init(void)
 {
 	return mdiobus_register_board_info(&bdinfo, 1);
 }
-arch_initcall(dsa_loop_bdinfo_init)
+arch_initcall(dsa_loop_bdinfo_init);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 8ee44a104ac4..ae7ecc27da97 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -617,5 +617,5 @@ static void __exit parport_default_proc_unregister (void)
 }
 #endif
 
-subsys_initcall(parport_default_proc_register)
-module_exit(parport_default_proc_unregister)
+subsys_initcall(parport_default_proc_register);
+module_exit(parport_default_proc_unregister);
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0a9b78705ee8..3798bc2461f8 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -264,4 +264,4 @@ static int arm_pmu_acpi_init(void)
 
 	return ret;
 }
-subsys_initcall(arm_pmu_acpi_init)
+subsys_initcall(arm_pmu_acpi_init);
diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel_turbo_max_3.c
index 4f60d8e32a0a..fbcface26d94 100644
--- a/drivers/platform/x86/intel_turbo_max_3.c
+++ b/drivers/platform/x86/intel_turbo_max_3.c
@@ -148,4 +148,4 @@ static int __init itmt_legacy_init(void)
 
 	return 0;
 }
-late_initcall(itmt_legacy_init)
+late_initcall(itmt_legacy_init);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 28d2753be094..501481383ec7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1423,4 +1423,4 @@ static int __init init_hugetlbfs_fs(void)
  out2:
 	return error;
 }
-fs_initcall(init_hugetlbfs_fs)
+fs_initcall(init_hugetlbfs_fs);
diff --git a/mm/compaction.c b/mm/compaction.c
index fb548e4c7bd4..9d456d62c6ef 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2125,6 +2125,6 @@ static int __init kcompactd_init(void)
 		kcompactd_run(nid);
 	return 0;
 }
-subsys_initcall(kcompactd_init)
+subsys_initcall(kcompactd_init);
 
 #endif /* CONFIG_COMPACTION */
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9e8b4f030c1c..5e82359cb58f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -634,7 +634,7 @@ static int __init oom_init(void)
 	}
 	return 0;
 }
-subsys_initcall(oom_init)
+subsys_initcall(oom_init);
 #else
 static inline void wake_oom_reaper(struct task_struct *tsk)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d00f746c2fd..5fc71b3155dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7073,7 +7073,7 @@ int __meminit init_per_zone_wmark_min(void)
 
 	return 0;
 }
-core_initcall(init_per_zone_wmark_min)
+core_initcall(init_per_zone_wmark_min);
 
 /*
  * min_free_kbytes_sysctl_handler - just a wrapper around proc_dointvec() so
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 0fd9dcf2c5dc..dfc22d5e3dba 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -624,4 +624,4 @@ static int __init pageowner_init(void)
 
 	return 0;
 }
-late_initcall(pageowner_init)
+late_initcall(pageowner_init);
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 1307731ddfe4..6e416c781682 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -396,4 +396,4 @@ static int __init bpf_lwt_init(void)
 	return lwtunnel_encap_add_ops(&bpf_encap_ops, LWTUNNEL_ENCAP_BPF);
 }
 
-subsys_initcall(bpf_lwt_init)
+subsys_initcall(bpf_lwt_init);
diff --git a/net/sched/sch_blackhole.c b/net/sched/sch_blackhole.c
index c98a61e980ba..3fe322bd1e05 100644
--- a/net/sched/sch_blackhole.c
+++ b/net/sched/sch_blackhole.c
@@ -42,4 +42,4 @@ static int __init blackhole_init(void)
 {
 	return register_qdisc(&blackhole_qdisc_ops);
 }
-device_initcall(blackhole_init)
+device_initcall(blackhole_init);
diff --git a/sound/core/seq_device.c b/sound/core/seq_device.c
index c4acf17e9f5e..4e859e4a0356 100644
--- a/sound/core/seq_device.c
+++ b/sound/core/seq_device.c
@@ -311,5 +311,5 @@ static void __exit alsa_seq_device_exit(void)
 	bus_unregister(&snd_seq_bus_type);
 }
 
-subsys_initcall(alsa_seq_device_init)
-module_exit(alsa_seq_device_exit)
+subsys_initcall(alsa_seq_device_init);
+module_exit(alsa_seq_device_exit);
-- 
2.11.0
