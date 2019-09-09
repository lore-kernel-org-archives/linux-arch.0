Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34080 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfIIOay (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Sep 2019 10:30:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so3642673qth.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Sep 2019 07:30:53 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH v3] powerpc/lockdep: fix a false positive warning
Date: Mon,  9 Sep 2019 10:30:33 -0400
Message-ID: <1568039433-10176-1-git-send-email-cai@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, mingo@kernel.org, peterz@infradead.org, bvanassche@acm.org, arnd@arndb.de, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Message-ID: <20190909143033.8ejjnNq2jWeB7ODvj7Z-SJ88Xsi15e2vZgwjbGm_CGk@z>

The commit 108c14858b9e ("locking/lockdep: Add support for dynamic
keys") introduced a boot warning on powerpc below, because since the
commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
kvm_tmp[] into the .bss section and then free the rest of unused spaces
back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

Later, alloc_workqueue() happens to allocate some pages from there and
trigger the warning at,

if (WARN_ON_ONCE(static_obj(key)))

Fix it by adding a generic helper arch_is_bss_hole() to skip those areas
in static_obj(). Since kvm_free_tmp() is only done early during the
boot, just go lockless to make the implementation simple for now.

WARNING: CPU: 0 PID: 13 at kernel/locking/lockdep.c:1120
Workqueue: events work_for_cpu_fn
Call Trace:
  lockdep_register_key+0x68/0x200
  wq_init_lockdep+0x40/0xc0
  trunc_msg+0x385f9/0x4c30f (unreliable)
  wq_init_lockdep+0x40/0xc0
  alloc_workqueue+0x1e0/0x620
  scsi_host_alloc+0x3d8/0x490
  ata_scsi_add_hosts+0xd0/0x220 [libata]
  ata_host_register+0x178/0x400 [libata]
  ata_host_activate+0x17c/0x210 [libata]
  ahci_host_activate+0x84/0x250 [libahci]
  ahci_init_one+0xc74/0xdc0 [ahci]
  local_pci_probe+0x78/0x100
  work_for_cpu_fn+0x40/0x70
  process_one_work+0x388/0x750
  process_scheduled_works+0x50/0x90
  worker_thread+0x3d0/0x570
  kthread+0x1b8/0x1e0
  ret_from_kernel_thread+0x5c/0x7c

Fixes: 108c14858b9e ("locking/lockdep: Add support for dynamic keys")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Change arch_is_bss_hole() to return a "bool".
    Rearrange variables in kvm.c a bit.
v2: No need to actually define arch_is_bss_hole() powerpc64 only.

 arch/powerpc/include/asm/sections.h | 11 +++++++++++
 arch/powerpc/kernel/kvm.c           |  8 +++++++-
 include/asm-generic/sections.h      |  7 +++++++
 kernel/locking/lockdep.c            |  3 +++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 4a1664a8658d..6e9e39ebbb27 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -5,8 +5,19 @@
 
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+
+#define arch_is_bss_hole arch_is_bss_hole
+
 #include <asm-generic/sections.h>
 
+extern void *bss_hole_start, *bss_hole_end;
+
+static inline bool arch_is_bss_hole(unsigned long addr)
+{
+	return addr >= (unsigned long)bss_hole_start &&
+	       addr < (unsigned long)bss_hole_end;
+}
+
 extern char __head_end[];
 
 #ifdef __powerpc64__
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index b7b3a5e4e224..e3c3b076ff07 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -64,9 +64,11 @@
 #define KVM_INST_MTSRIN		0x7c0001e4
 
 static bool kvm_patching_worked = true;
-char kvm_tmp[1024 * 1024];
 static int kvm_tmp_index;
 
+char kvm_tmp[1024 * 1024];
+void *bss_hole_start, *bss_hole_end;
+
 static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
 {
 	*inst = new_inst;
@@ -707,6 +709,10 @@ static __init void kvm_free_tmp(void)
 	 */
 	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
 			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
+
+	bss_hole_start = &kvm_tmp[kvm_tmp_index];
+	bss_hole_end = &kvm_tmp[ARRAY_SIZE(kvm_tmp)];
+
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d1779d442aa5..28a7a56e7c8a 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -91,6 +91,13 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 }
 #endif
 
+#ifndef arch_is_bss_hole
+static inline bool arch_is_bss_hole(unsigned long addr)
+{
+	return false;
+}
+#endif
+
 /**
  * memory_contains - checks if an object is contained within a memory region
  * @begin: virtual address of the beginning of the memory region
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4861cf8e274b..cd75b51f15ce 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -675,6 +675,9 @@ static int static_obj(const void *obj)
 	if (arch_is_kernel_initmem_freed(addr))
 		return 0;
 
+	if (arch_is_bss_hole(addr))
+		return 0;
+
 	/*
 	 * static variable?
 	 */
-- 
1.8.3.1
