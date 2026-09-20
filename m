Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE347532E
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933084; cv=none; b=mBmi3oq+VgoIdTjXmPOmFp3hexE2pFt7lLGj/CCmkK23nFNGoMq+vgG7dUsTQd5MIXUGRqOHDj1EswTiNun1iuQshD83GkwEd4+ZLv9R6qztHALl/7x69MXLVGG8ucILW8fRaCrQyf+dCtljwdBmUgNoZ/DyGhSvZfSGrK6AuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933084; c=relaxed/simple;
	bh=imCJBTRWC29jkMd/LmPmOa+lPJP7kW1KilAUtySFuZw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtmaeJn3awTq4tZ7MUqke7+V4ZE+UEuKScV0HOHHdkl4W2ZvlNLXlXCmL3llLZrOraAhLCWdD7EYnANOsOcLr4+kidpeWMG+vWPZonIY/oNXFTCMpRqD6uRyRTaQo4554eZyMIqWsDz8RQQY1SYS4w59kYXVLu0xxSNP2NY0l2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZlqWWOAL; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZlqWWOAL"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac8d1fso15034107b3.0
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933081; x=1790537881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H+SlWroSdaGxZWUb4GAQgkH+PVdX8bfzP0oz7opOlFk=;
        b=ZlqWWOAL743qYYu5tDI12Xv2eemUd4mR4Cb8/Ihj2ZDMOhy/ILAgI18PJfuDHl2Dbs
         ko8ybku1oSGpf8LuiiKRcBeZAFK4OWLPd5tjnik9aVBB8i0sgbN8qnIoaTxetIO5395e
         3UAraUO/G32OOQF97+mQUpsNLrXtbw4AvbDo44YvI5jmxdaPcIBQ3mJ6uT4hgXhEQYb4
         CIiTu9x0uUjLoh7VNwbXD+syK1lqo1HK3FxVReSniUhHbKClfv1ProsK3jxXyCitDUUX
         VsPnWeAOZnwpxOB6feFiWB/KboaIFM2MQL38z6S3+WYVnham6FzoSCXSiW7oSteB8GKI
         f+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933081; x=1790537881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H+SlWroSdaGxZWUb4GAQgkH+PVdX8bfzP0oz7opOlFk=;
        b=jf4EgJTXhcYFNNu/X/AoSeEwd/mKi7N83zuPY+klbS2Ij6SLH33Dqzl6BmvBuwCVez
         OZ/hNx8r3VQtJM07MOetY51EeiKIfBbg9bp71gVsyGefsTl3PVZLtOCydogpXoMFdwqy
         oDN3UHglXideQ2gLIeld8e3y4TZIXmKtxy+CpIvxlOhPTbQuIcN5nKUONiZqFSP/ZWA+
         g+VfxHgvn5nVBOGso6HXT/MB+E+r2Y0U7fb9UH/1VPufvVMAgl8fGeIQsUfydW5gHJZz
         4c5t/KyMF9Qn9wkStpcHWy3l50D+rsRfuA8kY85Gk08NLRLqHqmltvRasrT3v9KVIHwP
         o2Jw==
X-Forwarded-Encrypted: i=1; AKwUvBwwdyyMQRru/Gt4Qwlq3SLeAgGfUMl9FQjSdkB2VcqABxhYqJlxtQgFKGpp1jNlEK4vf01C1LsrCbRx@vger.kernel.org
X-Gm-Message-State: AFuF++nhRIZWPYu1uyLhr1lQSQyHdG0ybSe0Jywghl7oJuDydM9CvAWK
	ItVflRUy8YpwFa2bdZ7fIHi9neJtyBFZ3e/zkL2hSrhF9MASGHUXPDLIosD6MPDxjoQ=
X-Gm-Gg: AYBFou2ih4bOMjW974EvSIxLkup5XNVwm8A44YCIjAjynUYycKSFta5ZEpndjfFCKVe
	PPvTaHczjrjJqOIaOZZLGpGMhBXZf+0P9wDmbHreTbCEpTjkiwuotpra3I0MaGDfmpwLJuDNzTU
	iIFCFPsBtworCifOQ3skXDu8C2fiaq7JUsDuT9TlUrl6PjqlXAlNg8+UJMLiIvEsmvY39i+EwW2
	uogmf8FsIU8pH0XpmKqhVBo/u7GcRUJg9z6Nl24oajxyajjiR2RXu6YCsw8wY43N73QhR1LSSHn
	oGHRCzxzTOUTnwE7Hjifsw3azuYfC4LfOVIrRUXVYf5lOZEZF+8v3u8ny6yFD7x/Y1LExO2MU5y
	GOkphcueDIC46+LlFAKc6JPMFR/OzYdpwdYUU7lhAkGbR6Bx3rf6cLNWlRU0SIFZMB/6EDCVmAb
	L+GuCKxHVH7pDCcwN8M+Q/wfGRf+pyGvn6E5IGUU86hosrCmBG4aZic7W5MU9zK3lvlYE4RHEJa
	fzOA2i3XrE4vvcXG+KweIC5c1heTYaa8qrMMAPkVWNQyQceHw7Twcbs4sFroSt2E0mNRA1qzTrI
	rrJxaTKP6jtDTn/0bwVK
X-Received: by 2002:a05:690c:60c7:b0:873:5c0f:280 with SMTP id 00721157ae682-89735f6df22mr25869157b3.42.1789933081162;
        Sun, 20 Sep 2026 12:38:01 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a46a44699sm18596057b3.19.2026.09.20.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:59 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 11/46] liveupdate: Define CPU preservation linker sections
Date: Sun, 20 Sep 2026 15:36:15 -0400
Message-ID: <20260920193650.3373435-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define CPU_PRESERVED_TEXT and CPU_PRESERVED_DATA linker macros to place
code and data required for CPU preservation into dedicated sections
(.text.cpu_preserved and .data.cpu_preserved).

These sections are preserved across live update transitions and mapped
executable/read-write as needed.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/asm-generic/vmlinux.lds.h     | 29 +++++++++++++++++
 include/linux/cpu_preserve.h          | 47 +++++++++++++++++++++++++++
 scripts/mod/modpost.c                 | 32 +++++++++++++++---
 tools/objtool/check.c                 | 35 +++++++++++++++++++-
 tools/objtool/include/objtool/check.h |  1 +
 tools/objtool/include/objtool/elf.h   |  2 +-
 6 files changed, 140 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/cpu_preserve.h

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..0dbaac582bcc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -655,6 +655,34 @@
 		*(.static_call.text)					\
 		__static_call_text_end = .;
 
+/*
+ * Page-aligned text and data sections for preserved CPUs.
+ * This code and data are KHO preserved when CPUs are preserved across
+ * live update.
+ */
+#ifdef CONFIG_LIVEUPDATE_CPU
+#define CPU_PRESERVED_TEXT						\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_text_start = .;				\
+		*(.text.cpu_preserved .text.cpu_preserved.*)		\
+		*(.cpu_preserved.text .cpu_preserved.text.*)		\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_text_end = .;
+
+#define CPU_PRESERVED_DATA						\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_data_start = .;				\
+		*(.data.cpu_preserved .data.cpu_preserved.*)		\
+		*(.cpu_preserved.data .cpu_preserved.data.*)		\
+		*(.rodata.cpu_preserved .rodata.cpu_preserved.*)	\
+		*(.bss..data.cpu_preserved .bss..data.cpu_preserved.*)	\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_data_end = .;
+#else
+#define CPU_PRESERVED_TEXT
+#define CPU_PRESERVED_DATA
+#endif
+
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  KEEP(*(.head.text))
 
@@ -1155,6 +1183,7 @@
 		INIT_TASK_DATA(inittask)				\
 		NOSAVE_DATA						\
 		PAGE_ALIGNED_DATA(pagealigned)				\
+		CPU_PRESERVED_DATA					\
 		CACHE_HOT_DATA(cacheline)				\
 		CACHELINE_ALIGNED_DATA(cacheline)			\
 		READ_MOSTLY_DATA(cacheline)				\
diff --git a/include/linux/cpu_preserve.h b/include/linux/cpu_preserve.h
new file mode 100644
index 000000000000..f653838c383d
--- /dev/null
+++ b/include/linux/cpu_preserve.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Preserved CPU across Live Update
+ */
+#ifndef _LINUX_CPU_PRESERVE_H
+#define _LINUX_CPU_PRESERVE_H
+
+#include <linux/compiler.h>
+
+#ifdef CONFIG_LIVEUPDATE_CPU
+
+/*
+ * __cpu_preserved_text: Code executed by preserved physical CPUs during live
+ * update kexec handover in orphan mode.
+ *
+ * All code in this section must run without stack protector checks because
+ * per-CPU canary state may be invalid during handover and __stack_chk_fail()
+ * resides in regular .text, which gets overwritten during kexec before the
+ * incoming kernel boots.
+ *
+ * Architecture-specific requirements (such as disabling external retpolines
+ * and return thunks on x86) are supplied via ARCH_CPU_PRESERVED_TEXT.
+ */
+#ifndef ARCH_CPU_PRESERVED_TEXT
+#define ARCH_CPU_PRESERVED_TEXT
+#endif
+
+#define __cpu_preserved_text					\
+	__section(".text.cpu_preserved")			\
+	__no_stack_protector					\
+	ARCH_CPU_PRESERVED_TEXT
+#define __cpu_preserved_data	__section(".data.cpu_preserved")
+
+extern char __cpu_preserved_text_start[], __cpu_preserved_text_end[];
+extern char __cpu_preserved_data_start[], __cpu_preserved_data_end[];
+
+#else /* !CONFIG_LIVEUPDATE_CPU */
+
+#define __cpu_preserved_text
+#define __cpu_preserved_data
+
+#endif /* CONFIG_LIVEUPDATE_CPU */
+
+#endif /* _LINUX_CPU_PRESERVE_H */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 75374c64b8cc..51631cd2f6c4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -810,13 +810,27 @@ static void check_section(struct module *mod, struct elf_info *elf,
 #define ALL_INIT_SECTIONS ".init.*"
 #define ALL_EXIT_SECTIONS ".exit.*"
 
+#define ALL_CPU_PRESERVED_TEXT_SECTIONS \
+	".text.cpu_preserved", ".text.cpu_preserved.*", \
+	".cpu_preserved.text", ".cpu_preserved.text.*"
+
+#define ALL_CPU_PRESERVED_DATA_SECTIONS \
+	".data.cpu_preserved", ".data.cpu_preserved.*", \
+	".cpu_preserved.data", ".cpu_preserved.data.*", \
+	".rodata.cpu_preserved", ".rodata.cpu_preserved.*", \
+	".bss..data.cpu_preserved", ".bss..data.cpu_preserved.*"
+
+#define ALL_CPU_PRESERVED_SECTIONS \
+	ALL_CPU_PRESERVED_TEXT_SECTIONS, ALL_CPU_PRESERVED_DATA_SECTIONS
+
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
 		".kprobes.text", ".cpuidle.text", ".noinstr.text", \
 		".ltext", ".ltext.*"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", \
-		".coldtext", ".softirqentry.text", ".irqentry.text"
+		".coldtext", ".softirqentry.text", ".irqentry.text", \
+		ALL_CPU_PRESERVED_TEXT_SECTIONS
 
 #define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
@@ -827,6 +841,7 @@ enum mismatch {
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
 	EXTABLE_TO_NON_TEXT,
+	CPU_PRESERVED_TO_NON_PRESERVED,
 };
 
 /**
@@ -843,13 +858,19 @@ enum mismatch {
  * @mismatch: Type of mismatch.
  */
 struct sectioncheck {
-	const char *fromsec[20];
-	const char *bad_tosec[20];
-	const char *good_tosec[20];
+	const char *fromsec[32];
+	const char *bad_tosec[32];
+	const char *good_tosec[32];
 	enum mismatch mismatch;
 };
 
 static const struct sectioncheck sectioncheck[] = {
+/* Do not reference non-preserved code/data from cpu_preserved sections */
+{
+	.fromsec = { ALL_CPU_PRESERVED_SECTIONS, NULL },
+	.good_tosec = { ALL_CPU_PRESERVED_SECTIONS, NULL },
+	.mismatch = CPU_PRESERVED_TO_NON_PRESERVED,
+},
 /* Do not reference init/exit code/data from
  * normal code and data
  */
@@ -960,6 +981,9 @@ static const struct sectioncheck *section_mismatch(
 static int secref_whitelist(const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
+	if (match(fromsec, PATTERNS(ALL_CPU_PRESERVED_SECTIONS)))
+		return 1;
+
 	/* Check for pattern 1 */
 	if (match(tosec, PATTERNS(ALL_INIT_DATA_SECTIONS)) &&
 	    match(fromsec, PATTERNS(DATA_SECTIONS)) &&
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 464f6c9d9ff0..77389fbfd9ea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -329,6 +329,8 @@ static void init_insn_state(struct objtool_file *file, struct insn_state *state,
 
 	if (opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
+	if (sec)
+		state->cpu_preserved = sec->cpu_preserved;
 }
 
 static struct cfi_state *cfi_alloc(void)
@@ -419,6 +421,14 @@ static int decode_instructions(struct objtool_file *file)
 		u8 prev_len = 0;
 		u8 idx = 0;
 
+		if (!strncmp(sec->name, ".text.cpu_preserved", 19) ||
+		    !strncmp(sec->name, ".cpu_preserved.text", 19) ||
+		    !strncmp(sec->name, ".data.cpu_preserved", 19) ||
+		    !strncmp(sec->name, ".cpu_preserved.data", 19) ||
+		    !strncmp(sec->name, ".rodata.cpu_preserved", 21) ||
+		    !strncmp(sec->name, ".bss..data.cpu_preserved", 24))
+			sec->cpu_preserved = true;
+
 		if (!is_text_sec(sec))
 			continue;
 
@@ -3511,6 +3521,17 @@ static int validate_call(struct objtool_file *file,
 			 struct instruction *insn,
 			 struct insn_state *state)
 {
+	if (state->cpu_preserved) {
+		struct symbol *dest = insn_call_dest(insn);
+
+		if (dest && (dest->sec->idx != SHN_UNDEF || opts.link) &&
+		    !dest->sec->cpu_preserved) {
+			WARN_INSN(insn, "call to %s() leaves .text.cpu_preserved section",
+				  call_dest_name(insn));
+			return 1;
+		}
+	}
+
 	if (state->noinstr && state->instr <= 0 &&
 	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
 		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(insn));
@@ -4164,7 +4185,13 @@ static int validate_retpoline(struct objtool_file *file)
 		if (insn->retpoline_safe)
 			continue;
 
-		if (insn->sec->init)
+		/*
+		 * Preserved CPU text (.text.cpu_preserved) executes across
+		 * kexec when the outgoing kernel's retpoline/rethunk targets
+		 * are no longer mapped.
+		 */
+		if (insn->sec->init ||
+		    !strcmp(insn->sec->name, ".text.cpu_preserved"))
 			continue;
 
 		if (insn->type == INSN_RETURN) {
@@ -4440,6 +4467,12 @@ static int validate_noinstr_sections(struct objtool_file *file)
 		warnings += validate_unwind_hints(file, sec);
 	}
 
+	sec = find_section_by_name(file->elf, ".text.cpu_preserved");
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
+
 	return warnings;
 }
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 063f5985fecd..18318f2faf11 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -16,6 +16,7 @@ struct insn_state {
 	bool uaccess;
 	bool df;
 	bool noinstr;
+	bool cpu_preserved;
 	s8 instr;
 };
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a82517a76a0f..bac9e5f4921f 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -58,7 +58,7 @@ struct section {
 	Elf_Data *data;
 	const char *name;
 	int idx;
-	bool _changed, text, rodata, noinstr, init, truncate;
+	bool _changed, text, rodata, noinstr, init, cpu_preserved, truncate;
 	struct reloc *relocs;
 	unsigned long nr_alloc_relocs;
 	struct section *twin;
-- 
2.55.0.1082.g2b9226bbc0-goog

