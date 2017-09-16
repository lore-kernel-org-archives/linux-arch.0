From: Brijesh Singh <brijesh.singh@amd.com>
Subject: [Part1 PATCH v4 15/17] percpu: introduce DEFINE_PER_CPU_UNENCRYPTED
Date: Sat, 16 Sep 2017 07:34:16 -0500
Message-ID: <20170916123418.37807-16-brijesh.singh@amd.com>
References: <20170916123418.37807-1-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170916123418.37807-1-brijesh.singh@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

When SEV is active, memory is encrypted with guest-specific key, and if
guest OS wants to share the memory region with hypervisor then it must
clear the C-bit (i.e set unencrypted) before sharing it.

DEFINE_PER_CPU_UNENCRYPTED can be used to define the per-cpu variables
which will be shared between guest and hypervisor. Currently, KVM defines
three variables (steal-time, apf_reason, and avic_eio) which are shared
with hypervisor.

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
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 include/linux/percpu-defs.h       | 15 +++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8acfc1e099e1..363858f43cbc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -777,6 +777,16 @@
 #define INIT_RAM_FS
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#define PERCPU_UNENCRYPTED_SECTION					\
+	. = ALIGN(PAGE_SIZE);						\
+	*(.data..percpu..unencrypted)					\
+	. = ALIGN(PAGE_SIZE);
+#else
+#define PERCPU_UNENCRYPTED_SECTION
+#endif
+
+
 /*
  * Default discarded sections.
  *
@@ -815,6 +825,7 @@
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\
 	*(.data..percpu..shared_aligned)				\
+	PERCPU_UNENCRYPTED_SECTION					\
 	VMLINUX_SYMBOL(__per_cpu_end) = .;
 
 /**
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8f16299ca068..b2b99ad4b31d 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -173,6 +173,21 @@
 	DEFINE_PER_CPU_SECTION(type, name, "..read_mostly")
 
 /*
+ * Declaration/definition used for per-CPU variables that should be accessed
+ * as unencrypted when memory encryption is enabled in the guest.
+ */
+#if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
+
+#define DECLARE_PER_CPU_UNENCRYPTED(type, name)				\
+	DECLARE_PER_CPU_SECTION(type, name, "..unencrypted")
+
+#define DEFINE_PER_CPU_UNENCRYPTED(type, name)				\
+	DEFINE_PER_CPU_SECTION(type, name, "..unencrypted")
+#else
+#define DEFINE_PER_CPU_UNENCRYPTED(type, name)	DEFINE_PER_CPU(type, name)
+#endif
+
+/*
  * Intermodule exports for per-CPU variables.  sparse forgets about
  * address space across EXPORT_SYMBOL(), change EXPORT_SYMBOL() to
  * noop if __CHECKER__.
-- 
2.9.5
