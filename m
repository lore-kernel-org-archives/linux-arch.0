Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188881;
	b=hdzj4Z1RRr0Kgf0Qim/Ve3JM50VTgDEU+Mshv8ql1Uix/GVLBfX2e+Jrj+5sENPpnCSB
	 DJ0VFETZRb0d8mFOwmEH92Vi1B5bT5AGvKxXKN6pGR884tTFr0U+22jdyfGX2uaLUXJQM
	 K97jrCnpi0whAYbwCd+1jCsIQFteNx53hbRCncpPH7iM59VzJWuDzGfl4U9smmHRR4mX+
	 V9PddgnTebaVs+8hc8R/wHMbAwTeZprAkg4WkSj+zPz4DGiekptf0QwiLSzW+ZhHkOhtV
	 neqtfxI7WhM5f3ISsyfsx8ce94mTNmPQ0GA3/sOKuTdRxBv1jtutUKu8rQXqpylF1RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QVjVdSdFbNyhp1BDStovaWMWKE0PVM4cKgBjAoaMF1g=;
	b=k/e+EkQ7tlj83eor1sJSRi8EpOG7hepwT0lAVLZZx+XuN2jAmk+7plm1RiklVRr6e7/X
	 2eWY9dpdKOT/ZLqdajI2k039S3yOLOFyvNKQTfTuTQXLjzSZFIiluzXDF1og/qHUz4RZ0
	 fXN6LIUkCrOArGAqwOFtbRXHZJKeynW/4uAKr9ohdc59/hYUo1Qs/BpxlZfttcH0d0Mrw
	 2GL0DUPWaZ8Ouao7+xFPwq1ctcpwbJkO7FWAuaNXePYyMFVW1+GdptzLLVAuDKdro4mln
	 Q0qiy4BxC9i1VXuzrLUK+CIaICKYTPvAHlJEMA9zA233wyxrYB9W1Wb/5ydo78Xndrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwepM9YX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A19606A327;
	Wed, 28 Oct 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwepM9YX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A8A1F01829;
	Wed, 28 Oct 2026 12:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188880;
	bh=QVjVdSdFbNyhp1BDStovaWMWKE0PVM4cKgBjAoaMF1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FwepM9YXx3IEaTCoUE7zf3pQMgY7Q+Jj+4Ao/qqEAknDmQ1rkLZ86hhC+Eej9cefr
	 ya8wu2MeDMP1pV4Umy7OJbexN0X6PcqLxQeDSXtb69E789dmHchYnR2Op8CcBm71G1
	 rGVTSlAclpq2kH8VpyQbRca4vklrl0AoYAs8v8J2YbWT6759ju/O0dv74bGfmZRGXo
	 WB3qqffXABOX/RgIZf71N07Zx8W4S0W3/3u8JrUCafY7PQm7Jx9ODs8D5KIlqCbEfs
	 GcXXSzQVlmhoYCOiYboUmGHHvdt2Jn+30bblckEwaTPFopPPwOUO54Xa0VhIRs0qMg
	 Ri6ZZad8y+tww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Wentao Zhang <wentaoz5@illinois.edu>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>,
	Chuck Wolber <chuck@wolber.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	Marco Elver <elver@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH 14/20] coverage: add Clang's source-based code coverage
Date: Wed, 28 Oct 2026 07:59:38 -0400
Message-ID: <20261028120034.871983-15-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028120034.871983-1-sashal@kernel.org>
References: <20261028120034.871983-1-sashal@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Clang's Source-based Code Coverage [1] as a second code coverage
measurement implementation, next to gcov.

gcov works at the object code level, which may better reflect actual
execution, but its measurements can lose source level precision when
compiler optimizations are enabled, as they always are for the kernel.
In the following example from drivers/firmware/dmi_scan.c, measured on
v6.11, gcov reports six branch outcomes for an expression with four
conditions:

        5: 1068:	if (s == e || *e != '/' || !month || month > 12) {
branch  0 taken 5 (fallthrough)
branch  1 taken 0
branch  2 taken 5 (fallthrough)
branch  3 taken 0
branch  4 taken 0 (fallthrough)
branch  5 taken 5

Clang's Source-based Code Coverage instruments the code in the compiler
front end, so the coverage data maps back to the source code exactly,
regardless of optimizations, and reports each condition:

 1068|      5|	if (s == e || *e != '/' || !month || month > 12) {
  ------------------
  |  Branch (1068:6): [True: 0, False: 5]
  |  Branch (1068:16): [True: 0, False: 5]
  |  Branch (1068:29): [True: 0, False: 5]
  |  Branch (1068:39): [True: 0, False: 5]
  ------------------

It is selected with CONFIG_LLVM_COV_KERNEL in the "Code coverage
measurement" choice, uses the common COVERAGE_PROFILE annotations,
noinstr handling and reset, and exports the raw profile of the kernel
image in /sys/kernel/debug/coverage/llvm/profraw. The raw profile
formats of Clang 19 to 22 (version 10) and of Clang 23 and later
(version 11) are supported. Counters are updated atomically, like gcov
does when the compiler allows it.

The data is exported from sections that the architecture's linker script
places with LLVM_COV_DATA, so only code built into the kernel image is
instrumented; modules are left alone.

This reuses the debugfs interface and raw profile serialization of
earlier work by Sami Tolvanen et al. [2], without the parts specific to
profile guided optimization.

Link: https://clang.llvm.org/docs/SourceBasedCodeCoverage.html [1]
Link: https://lore.kernel.org/lkml/20210407211704.367039-1-morbo@google.com/ [2]
Originally-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                       |   2 +
 Makefile                          |   1 +
 include/asm-generic/vmlinux.lds.h |  36 ++++++
 kernel/coverage/Kconfig           |  33 ++++-
 kernel/coverage/Makefile          |   1 +
 kernel/coverage/llvm/Makefile     |   4 +
 kernel/coverage/llvm/fs.c         | 201 ++++++++++++++++++++++++++++++
 kernel/coverage/llvm/llvm-cov.h   | 139 +++++++++++++++++++++
 scripts/Makefile.lib              |   7 +-
 scripts/Makefile.llvm-cov         |   6 +
 10 files changed, 427 insertions(+), 3 deletions(-)
 create mode 100644 kernel/coverage/llvm/Makefile
 create mode 100644 kernel/coverage/llvm/fs.c
 create mode 100644 kernel/coverage/llvm/llvm-cov.h
 create mode 100644 scripts/Makefile.llvm-cov

diff --git a/MAINTAINERS b/MAINTAINERS
index 573ac65304f7c..506f25cfc3e85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6596,6 +6596,8 @@ F:	kernel/coverage/Kconfig
 F:	kernel/coverage/Makefile
 F:	kernel/coverage/core.c
 F:	kernel/coverage/coverage.h
+F:	kernel/coverage/llvm/
+F:	scripts/Makefile.llvm-cov
 
 CODE OF CONDUCT
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/Makefile b/Makefile
index cb34eb7e1b790..8f60f7b99b67a 100644
--- a/Makefile
+++ b/Makefile
@@ -1203,6 +1203,7 @@ include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
 include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
 include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
 include-$(CONFIG_GCOV_KERNEL)	+= scripts/Makefile.gcov
+include-$(CONFIG_LLVM_COV_KERNEL) += scripts/Makefile.llvm-cov
 include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+= scripts/Makefile.randstruct
 include-$(CONFIG_KSTACK_ERASE)	+= scripts/Makefile.kstack_erase
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d699..840899b604336 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -359,6 +359,42 @@
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_LLVM_COV_KERNEL
+#define LLVM_COV_DATA							\
+	__llvm_prf_data : AT(ADDR(__llvm_prf_data) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_data,		\
+					   __llvm_prf_data,		\
+					   _start, _end)		\
+	}								\
+	__llvm_prf_cnts : AT(ADDR(__llvm_prf_cnts) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_cnts,		\
+					   __llvm_prf_cnts,		\
+					   _start, _end)		\
+	}								\
+	__llvm_prf_names : AT(ADDR(__llvm_prf_names) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_names,		\
+					   __llvm_prf_names,		\
+					   _start, _end)		\
+	}								\
+	__llvm_prf_bits : AT(ADDR(__llvm_prf_bits) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_bits,		\
+					   __llvm_prf_bits,		\
+					   _start, _end)		\
+	}								\
+	__llvm_covfun : AT(ADDR(__llvm_covfun) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_POST_LABEL(__llvm_covfun,		\
+					   __llvm_covfun,		\
+					   _start, _end)		\
+	}								\
+	__llvm_covmap : AT(ADDR(__llvm_covmap) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_POST_LABEL(__llvm_covmap,		\
+					   __llvm_covmap,		\
+					   _start, _end)		\
+	}
+#else
+#define LLVM_COV_DATA
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
diff --git a/kernel/coverage/Kconfig b/kernel/coverage/Kconfig
index 62a6fa94bd308..acfcce23e4c97 100644
--- a/kernel/coverage/Kconfig
+++ b/kernel/coverage/Kconfig
@@ -4,6 +4,15 @@ menu "Code coverage"
 config ARCH_HAS_GCOV_PROFILE_ALL
 	def_bool n
 
+config ARCH_HAS_LLVM_COV
+	bool
+	help
+	  An architecture should select this when its linker script places
+	  the sections of Clang's source-based code coverage (LLVM_COV_DATA).
+
+config ARCH_HAS_LLVM_COV_PROFILE_ALL
+	bool
+
 choice
 	prompt "Code coverage measurement"
 	default GCOV_KERNEL if COMPILE_TEST
@@ -49,9 +58,30 @@ config GCOV_KERNEL
 	  and its modules is exported in gcov's format in /sys/kernel/debug/gcov,
 	  see Documentation/dev-tools/gcov.rst.
 
+config LLVM_COV_KERNEL
+	bool "Clang's source-based code coverage"
+	depends on CC_IS_CLANG && CLANG_VERSION >= 190000
+	depends on DEBUG_FS
+	depends on ARCH_HAS_LLVM_COV
+	depends on !ARCH_WANTS_NO_INSTR || CC_HAS_NO_PROFILE_FN_ATTR
+	help
+	  This option enables Clang's Source-based Code Coverage. It
+	  instruments the code in the compiler's front end, so that coverage
+	  data maps back to the source code exactly, regardless of the
+	  optimizations applied.
+
+	  The raw profile is exported in /sys/kernel/debug/coverage/llvm/profraw.
+	  Convert it with "llvm-profdata merge" and analyze it with "llvm-cov"
+	  against vmlinux, using the LLVM version that built the kernel.
+
+	  Only code built into the kernel image is instrumented.
+
 endchoice
 
 config COVERAGE_KERNEL
+	def_bool GCOV_KERNEL || LLVM_COV_KERNEL
+
+config COVERAGE_MODULES
 	def_bool GCOV_KERNEL
 
 config GCOV_PROFILE_ALL
@@ -64,7 +94,8 @@ config GCOV_PROFILE_ALL
 config COVERAGE_PROFILE_ALL
 	bool "Profile entire kernel"
 	depends on !COMPILE_TEST
-	depends on GCOV_KERNEL && ARCH_HAS_GCOV_PROFILE_ALL
+	depends on (GCOV_KERNEL && ARCH_HAS_GCOV_PROFILE_ALL) || \
+		   (LLVM_COV_KERNEL && ARCH_HAS_LLVM_COV_PROFILE_ALL)
 	default GCOV_PROFILE_ALL
 	help
 	  This option activates coverage instrumentation for the entire kernel.
diff --git a/kernel/coverage/Makefile b/kernel/coverage/Makefile
index 881fada442bd1..d783272d9974d 100644
--- a/kernel/coverage/Makefile
+++ b/kernel/coverage/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(or $(CONFIG_COVERAGE_KERNEL),$(CONFIG_KCOV)) += core.o
 obj-$(CONFIG_GCOV_KERNEL) += gcov/
+obj-$(CONFIG_LLVM_COV_KERNEL) += llvm/
 obj-$(CONFIG_KCOV) += kcov.o
 
 # Don't self-instrument.
diff --git a/kernel/coverage/llvm/Makefile b/kernel/coverage/llvm/Makefile
new file mode 100644
index 0000000000000..7090171b070eb
--- /dev/null
+++ b/kernel/coverage/llvm/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+COVERAGE_PROFILE := n
+
+obj-y := fs.o
diff --git a/kernel/coverage/llvm/fs.c b/kernel/coverage/llvm/fs.c
new file mode 100644
index 0000000000000..e90c325daeba3
--- /dev/null
+++ b/kernel/coverage/llvm/fs.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019	Sami Tolvanen <samitolvanen@google.com>, Google, Inc.
+ * Copyright (C) 2024	Jinghao Jia   <jinghao7@illinois.edu>,   UIUC
+ * Copyright (C) 2024	Wentao Zhang  <wentaoz5@illinois.edu>,   UIUC
+ */
+
+#define pr_fmt(fmt)	"llvm-cov: " fmt
+
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+
+#include "../coverage.h"
+#include "llvm-cov.h"
+
+/*
+ * Serializes taking a snapshot of the profile data against resetting it. The
+ * instrumented code updates the counters and bitmaps without taking it, so a
+ * snapshot is not atomic with respect to code running on other CPUs.
+ */
+static DEFINE_MUTEX(llvm_cov_mutex);
+
+struct llvm_cov_private_data {
+	char *buffer;
+	unsigned long size;
+};
+
+/*
+ * Raw profile data format:
+ * https://llvm.org/docs/InstrProfileFormat.html#raw-profile-format. Only the
+ * information relevant to Source-based Code Coverage is populated. Binary IDs,
+ * continuous mode, single-byte mode, value profiling, type profiling and
+ * uniform counters are not implemented.
+ */
+
+static void llvm_cov_fill_raw_profile_header(void **buffer)
+{
+	struct __llvm_profile_header *header = *buffer;
+
+	header->magic = INSTR_PROF_RAW_MAGIC_64;
+	header->version = INSTR_PROF_RAW_VERSION;
+	header->binary_ids_size = 0;
+	header->num_data = __llvm_prf_data_count();
+	header->padding_bytes_before_counters = 0;
+	header->num_counters = __llvm_prf_cnts_count();
+	header->padding_bytes_after_counters =
+		__llvm_prf_get_padding(__llvm_prf_cnts_size());
+	header->num_bitmap_bytes = __llvm_prf_bits_size();
+	header->padding_bytes_after_bitmap_bytes =
+		__llvm_prf_get_padding(__llvm_prf_bits_size());
+#if CONFIG_CLANG_VERSION >= 230000
+	header->num_uniform_counters = 0;
+	header->padding_bytes_after_uniform_counters = 0;
+	header->uniform_counters_delta = 0;
+#endif
+	header->names_size = __llvm_prf_names_size();
+	header->counters_delta = (u64)__llvm_prf_cnts_start -
+				 (u64)__llvm_prf_data_start;
+	header->bitmap_delta   = (u64)__llvm_prf_bits_start -
+				 (u64)__llvm_prf_data_start;
+	header->names_delta    = (u64)__llvm_prf_names_start;
+	header->num_v_tables = 0;
+	header->v_names_size = 0;
+	header->value_kind_last = IPVK_LAST;
+
+	*buffer += sizeof(*header);
+}
+
+/*
+ * Copy the source into the buffer, incrementing the pointer into buffer in the
+ * process.
+ */
+static void llvm_cov_copy_section_to_buffer(void **buffer, void *src,
+					    unsigned long size)
+{
+	memcpy(*buffer, src, size);
+	*buffer += size;
+}
+
+static unsigned long llvm_cov_get_raw_profile_size(void)
+{
+	return sizeof(struct __llvm_profile_header) +
+	       __llvm_prf_data_size() +
+	       __llvm_prf_cnts_size() +
+	       __llvm_prf_get_padding(__llvm_prf_cnts_size()) +
+	       __llvm_prf_bits_size() +
+	       __llvm_prf_get_padding(__llvm_prf_bits_size()) +
+	       __llvm_prf_names_size() +
+	       __llvm_prf_get_padding(__llvm_prf_names_size());
+}
+
+/*
+ * Serialize in-memory data into a format LLVM tools can understand
+ * (https://llvm.org/docs/InstrProfileFormat.html#raw-profile-format)
+ */
+static int llvm_cov_serialize_raw_profile(struct llvm_cov_private_data *p)
+{
+	void *buffer;
+
+	p->size = llvm_cov_get_raw_profile_size();
+	p->buffer = vzalloc(p->size);
+	if (!p->buffer)
+		return -ENOMEM;
+
+	buffer = p->buffer;
+
+	llvm_cov_fill_raw_profile_header(&buffer);
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_data_start,
+					__llvm_prf_data_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_cnts_start,
+					__llvm_prf_cnts_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_cnts_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_bits_start,
+					__llvm_prf_bits_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_bits_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_names_start,
+					__llvm_prf_names_size());
+
+	return 0;
+}
+
+/* open() implementation for llvm-cov data file. */
+static int llvm_cov_open(struct inode *inode, struct file *file)
+{
+	struct llvm_cov_private_data *data;
+	int err;
+
+	data = kzalloc_obj(*data);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_lock(&llvm_cov_mutex);
+	err = llvm_cov_serialize_raw_profile(data);
+	mutex_unlock(&llvm_cov_mutex);
+
+	if (err) {
+		kfree(data);
+		return err;
+	}
+
+	file->private_data = data;
+	return 0;
+}
+
+/* read() implementation for llvm-cov data file. */
+static ssize_t llvm_cov_read(struct file *file, char __user *buf, size_t count,
+			     loff_t *ppos)
+{
+	struct llvm_cov_private_data *data = file->private_data;
+
+	return simple_read_from_buffer(buf, count, ppos, data->buffer,
+				       data->size);
+}
+
+/* release() implementation for llvm-cov data file. */
+static int llvm_cov_release(struct inode *inode, struct file *file)
+{
+	struct llvm_cov_private_data *data = file->private_data;
+
+	vfree(data->buffer);
+	kfree(data);
+	return 0;
+}
+
+static const struct file_operations llvm_cov_data_fops = {
+	.owner		= THIS_MODULE,
+	.open		= llvm_cov_open,
+	.read		= llvm_cov_read,
+	.llseek		= default_llseek,
+	.release	= llvm_cov_release,
+};
+
+static void llvm_cov_reset(void)
+{
+	mutex_lock(&llvm_cov_mutex);
+	memset(__llvm_prf_cnts_start, 0, __llvm_prf_cnts_size());
+	memset(__llvm_prf_bits_start, 0, __llvm_prf_bits_size());
+	mutex_unlock(&llvm_cov_mutex);
+}
+
+static const struct coverage_backend llvm_cov_backend = {
+	.name	= "llvm",
+	.reset	= llvm_cov_reset,
+};
+
+static int __init llvm_cov_init(void)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("llvm", coverage_debugfs_root());
+	debugfs_create_file("profraw", 0400, dir, NULL, &llvm_cov_data_fops);
+	coverage_register_backend(&llvm_cov_backend);
+
+	return 0;
+}
+device_initcall(llvm_cov_init);
diff --git a/kernel/coverage/llvm/llvm-cov.h b/kernel/coverage/llvm/llvm-cov.h
new file mode 100644
index 0000000000000..61c76e803f88b
--- /dev/null
+++ b/kernel/coverage/llvm/llvm-cov.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019	Sami Tolvanen <samitolvanen@google.com>, Google, Inc.
+ * Copyright (C) 2024	Jinghao Jia   <jinghao7@illinois.edu>,   UIUC
+ * Copyright (C) 2024	Wentao Zhang  <wentaoz5@illinois.edu>,   UIUC
+ */
+
+#ifndef _LLVM_COV_H
+#define _LLVM_COV_H
+
+#include <linux/types.h>
+
+/*
+ * These internal LLVM definitions must match the compiler version. See
+ * llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
+ */
+
+#define INSTR_PROF_RAW_MAGIC_64		\
+		((u64)255 << 56 |	\
+		 (u64)'l' << 48 |	\
+		 (u64)'p' << 40 |	\
+		 (u64)'r' << 32 |	\
+		 (u64)'o' << 24 |	\
+		 (u64)'f' << 16 |	\
+		 (u64)'r' << 8  |	\
+		 (u64)129)
+
+#if CONFIG_CLANG_VERSION >= 230000
+#define INSTR_PROF_RAW_VERSION		11
+#else
+#define INSTR_PROF_RAW_VERSION		10
+#endif
+#define INSTR_PROF_DATA_ALIGNMENT	8
+#define IPVK_LAST			2
+
+/**
+ * struct __llvm_profile_header - represents the raw profile header data
+ * structure. Description of each member can be found here:
+ * https://llvm.org/docs/InstrProfileFormat.html#header.
+ */
+struct __llvm_profile_header {
+	u64 magic;
+	u64 version;
+	u64 binary_ids_size;
+	u64 num_data;
+	u64 padding_bytes_before_counters;
+	u64 num_counters;
+	u64 padding_bytes_after_counters;
+	u64 num_bitmap_bytes;
+	u64 padding_bytes_after_bitmap_bytes;
+#if CONFIG_CLANG_VERSION >= 230000
+	u64 num_uniform_counters;
+	u64 padding_bytes_after_uniform_counters;
+	u64 uniform_counters_delta;
+#endif
+	u64 names_size;
+	u64 counters_delta;
+	u64 bitmap_delta;
+	u64 names_delta;
+	u64 num_v_tables;
+	u64 v_names_size;
+	u64 value_kind_last;
+};
+
+/**
+ * struct __llvm_profile_data - represents the per-function control structure.
+ * Description of each member can be found here:
+ * https://llvm.org/docs/InstrProfileFormat.html#profile-metadata. To measure
+ * Source-based Code Coverage, the internals of this struct don't matter at run
+ * time. The only purpose of the definition below is to run sizeof() against it
+ * so that we can calculate the "num_data" field in header.
+ */
+struct __llvm_profile_data {
+	const u64 name_ref;
+	const u64 func_hash;
+	const void *counter_ptr;
+#if CONFIG_CLANG_VERSION >= 230000
+	const void *uniform_counter_ptr;
+#endif
+	const void *bitmap_ptr;
+	const void *function_pointer;
+	void *values;
+	const u32 num_counters;
+	const u16 num_value_sites[IPVK_LAST + 1];
+#if CONFIG_CLANG_VERSION >= 230000
+	const u16 offload_device_wave_size;
+#endif
+	const u32 num_bitmap_bytes;
+} __aligned(INSTR_PROF_DATA_ALIGNMENT);
+
+/* Payload sections */
+
+extern struct __llvm_profile_data __llvm_prf_data_start[];
+extern struct __llvm_profile_data __llvm_prf_data_end[];
+
+extern u64 __llvm_prf_cnts_start[];
+extern u64 __llvm_prf_cnts_end[];
+
+extern char __llvm_prf_names_start[];
+extern char __llvm_prf_names_end[];
+
+extern char __llvm_prf_bits_start[];
+extern char __llvm_prf_bits_end[];
+
+#define __DEFINE_SECTION_SIZE(s)					\
+	static inline unsigned long __llvm_prf_ ## s ## _size(void)	\
+	{								\
+		unsigned long start =					\
+			(unsigned long)__llvm_prf_ ## s ## _start;	\
+		unsigned long end =					\
+			(unsigned long)__llvm_prf_ ## s ## _end;	\
+		return end - start;					\
+	}
+#define __DEFINE_SECTION_COUNT(s)					\
+	static inline unsigned long __llvm_prf_ ## s ## _count(void)	\
+	{								\
+		return __llvm_prf_ ## s ## _size() /			\
+			sizeof(__llvm_prf_ ## s ## _start[0]);		\
+	}
+
+__DEFINE_SECTION_SIZE(data)
+__DEFINE_SECTION_SIZE(cnts)
+__DEFINE_SECTION_SIZE(names)
+__DEFINE_SECTION_SIZE(bits)
+
+__DEFINE_SECTION_COUNT(data)
+__DEFINE_SECTION_COUNT(cnts)
+__DEFINE_SECTION_COUNT(names)
+__DEFINE_SECTION_COUNT(bits)
+
+#undef __DEFINE_SECTION_SIZE
+#undef __DEFINE_SECTION_COUNT
+
+static inline unsigned long __llvm_prf_get_padding(unsigned long size)
+{
+	return 7 & (sizeof(u64) - size % sizeof(u64));
+}
+
+#endif /* _LLVM_COV_H */
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e0dc21e009522..77d1ab47125be 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -42,10 +42,13 @@ _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(target-stem).lds)
 # depending on variables COVERAGE_PROFILE_obj.o, COVERAGE_PROFILE and
 # CONFIG_COVERAGE_PROFILE_ALL (in this order)
 #
+# Modules are only instrumented if the coverage implementation supports them.
+#
 ifeq ($(CONFIG_COVERAGE_KERNEL),y)
-_c_flags += $(if $(patsubst n%,, \
+_c_flags += $(if $(if $(part-of-module),$(CONFIG_COVERAGE_MODULES),y), \
+		$(if $(patsubst n%,, \
 		$(COVERAGE_PROFILE_$(target-stem).o)$(COVERAGE_PROFILE)$(if $(is-kernel-object),$(CONFIG_COVERAGE_PROFILE_ALL))), \
-		$(CFLAGS_COVERAGE))
+		$(CFLAGS_COVERAGE)))
 endif
 
 #
diff --git a/scripts/Makefile.llvm-cov b/scripts/Makefile.llvm-cov
new file mode 100644
index 0000000000000..5babb09b6d3e6
--- /dev/null
+++ b/scripts/Makefile.llvm-cov
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS_COVERAGE	:= -fprofile-instr-generate -fcoverage-mapping \
+		   -fprofile-update=atomic
+
+export CFLAGS_COVERAGE
-- 
2.53.0

