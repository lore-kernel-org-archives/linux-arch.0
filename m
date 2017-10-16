From: Brijesh Singh <brijesh.singh@amd.com>
Subject: [Part1 PATCH v6 15/17] percpu: Introduce DEFINE_PER_CPU_DECRYPTED
Date: Mon, 16 Oct 2017 10:34:21 -0500
Message-ID: <20171016153423.2980-16-brijesh.singh@amd.com>
References: <20171016153423.2980-1-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:10176
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754195AbdJPPfN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Oct 2017 11:35:13 -0400
In-Reply-To: <20171016153423.2980-1-brijesh.singh@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org
Cc: bp@alien8.de, Brijesh Singh <brijesh.singh@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>

KVM guest defines three per-CPU variables (steal-time, apf_reason, and
avic_eio) which are shared between a guest and a hypervisor. When SEV
is active, memory is encrypted with a guest-specific key, and if the
guest OS wants to share the memory region with the hypervisor then it
must clear the C-bit (i.e set decrypted) before sharing it.

DEFINE_PER_CPU_DECRYPTED can be used to define the per-CPU variables
which will be shared between a guest and a hypervisor.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-arch@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 include/asm-generic/vmlinux.lds.h | 19 +++++++++++++++++++
 include/linux/percpu-defs.h       | 15 +++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 353f52fdc35e..bdcd1caae092 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -779,6 +779,24 @@
 #endif
 
 /*
+ * Memory encryption operates on a page basis. Since we need to clear
+ * the memory encryption mask for this section, it needs to be aligned
+ * on a page boundary and be a page-size multiple in length.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#define PERCPU_DECRYPTED_SECTION					\
+	. = ALIGN(PAGE_SIZE);						\
+	*(.data..percpu..decrypted)					\
+	. = ALIGN(PAGE_SIZE);
+#else
+#define PERCPU_DECRYPTED_SECTION
+#endif
+
+
+/*
  * Default discarded sections.
  *
  * Some archs want to discard exit text/data at runtime rather than
@@ -816,6 +834,7 @@
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\
 	*(.data..percpu..shared_aligned)				\
+	PERCPU_DECRYPTED_SECTION					\
 	VMLINUX_SYMBOL(__per_cpu_end) = .;
 
 /**
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8f16299ca068..2d2096ba1cfe 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -173,6 +173,21 @@
 	DEFINE_PER_CPU_SECTION(type, name, "..read_mostly")
 
 /*
+ * Declaration/definition used for per-CPU variables that should be accessed
+ * as decrypted when memory encryption is enabled in the guest.
+ */
+#if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
+
+#define DECLARE_PER_CPU_DECRYPTED(type, name)				\
+	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
+
+#define DEFINE_PER_CPU_DECRYPTED(type, name)				\
+	DEFINE_PER_CPU_SECTION(type, name, "..decrypted")
+#else
+#define DEFINE_PER_CPU_DECRYPTED(type, name)	DEFINE_PER_CPU(type, name)
+#endif
+
+/*
  * Intermodule exports for per-CPU variables.  sparse forgets about
  * address space across EXPORT_SYMBOL(), change EXPORT_SYMBOL() to
  * noop if __CHECKER__.
-- 
2.9.5
