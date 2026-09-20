Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F1477290
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933131; cv=none; b=Y3ad/L/phQiSzKN1n5D0KjWcIcGVUMdDFpH57nufCEhMaBaz25wKETpPXsAqSUnHIVFSiCXR9eu0blgCmB4ZlDTKZX7Y9kLUDjCkKT6vpqGOrH9vhSpPlYP9v76PqIECxfkX1p/WCHYD2NzKv9lQ0mf848P6Ww8PL3xdXkjKU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933131; c=relaxed/simple;
	bh=U4CoNZ2lBt0BuSrb+qI4PEF3vLDs5TzYJw62sdeeMqE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6391k+NBwn69nie9gak0Zn+gWgk4YTyr6B1dVQx1TdRs4YEi754a5xuMOUp710KYCnbF7SfwBx3AdZ0iot8vOwtGG4EHrBAytxnwjeKnv2Q1HTffsAaI2Y6Bj9mfVjtEDbHY0I/v5Iei1V9kv02LCCSY20ab3IULgf952XyToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=C6Agq9FF; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="C6Agq9FF"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so23274617b3.0
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933128; x=1790537928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fQwtMjDkRZvOK0KEqWuda0aT7+Kg50uVl9w6x/heTIA=;
        b=C6Agq9FFN+/Lc6qltHEvnqByqsYBTJI06l54QhJtKaKOsPfBRGwObWtXqZgNsjTbJD
         DE0uIbKPGPJdoMJ/btacsgddMYqkrtFu8HXE20LkIr1uAQIBWvOpLRKJ7PzRDvjJargl
         +oSqcxyd3wDp06VS5AhTzEteZEBRdIUlby4oM19HInbAELCT5KrPKr5Q27q9wlYBoCSv
         gTQobHCsdoaYPCwQ7Pgy4jSU49NbgTIuSdiWCxr1CYYVPzG6iTUv2M3RRVQb1uPTaQ8J
         aAx7iCqImckrLtrXgZCx5r6ciaoDUPj2vcNVVBP6hlr2BhGGkiraFdw0v5l0EoLXxeaz
         wrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933128; x=1790537928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fQwtMjDkRZvOK0KEqWuda0aT7+Kg50uVl9w6x/heTIA=;
        b=IKFCfkvcoQBK01p7mTFkaHZCdHM75sOeLc833qahckjewwyQZwM/VFEjcvwBzKpheq
         p117HnUaOCHa+jAZShDTWitR30FJ6IgYKyWzjEI/XBc09lw5op1To2gAGLs6hlj16Xus
         LAeLEGIN3iYirQMm8ngNHUvtZGDfDJlVoOrmnpCIq9c5X5sZddL/kwLPirRhXTDDbTe6
         cLxFSIcbiKjDyEpvUhElkwXopOG+FQC6+/htQ85bElf3qoqyhpMrqmwhPfhqNWslb/0p
         FbzdDh74KX9ozZjumvOetdaA7k/axJQqz76mKv2lNqT6Tczcy/0LOaPkPIbKJ8J27SGG
         b47Q==
X-Forwarded-Encrypted: i=1; AKwUvByIRxNTzNOp9esMmK0Wr5C4qUDOCH3UwfPUIInE70PF/f/C9HwEXcLwJdOI6HsxOOs+l+mF/5vdz4PF@vger.kernel.org
X-Gm-Message-State: AFuF++ndROpWs99yWRE6ySVcJQ5+PEmwaiy1qCDF0PLWbIQLTUeW8QIG
	yvNZ1Ppxe8MSh/em9gOUXWHaUbH5ZLCVg+xduck7iFqSnZCBjjYh80R42psIYXN0zq4=
X-Gm-Gg: AYBFou0cWSuc4X6dj6EMhBaDaYOz9rrv/lDPfRBs+rHCU2ifHm6KRqkN8iX+LK2BoFH
	vtnxt2KIyvJwD+QOy7rFC88U35/3DqTssN+A68MlMCHtHIB+lKTDQsoNLAFVyUWxu0BwV5Cp5j9
	8ctMwaG0yH1haRiqdUw+T1t6Sy9+CciSQZrAghRD7CkJjlWm1N9AQWMJfBOmOUnSD4wS43FSRN4
	Njn8P+pVXR5vdW7TRQCyOx3aQs1RKllobJBxhJd1QgF8wFk5Dr6DR+yQcpneNotFkgw187XjX79
	u5oopa7cACKyQbCceiiFCTudOMvdqSaJf0wuhsEBRDj8sWjDGm7XRRGFkaEl2rI6BLXyOh1+y1C
	5x8h2kTeRzmc2QFnJIkQOGkfaDNKSZakm3ptbl7c2b1MeVLv7kk4xqjkkSIAUVbl4j2L23UpSLk
	zyp5oAHiJH0ndkoqLkCGJeHweuLTlpzBKa7XeHEc6sIv/BGdVokRbtw/QS0CxWi7TzUtMiQL+mC
	IyCX5cHW5DvKizzqAY5OkFdaWIRLsKnMwhuEGZZtcwbNQ0R9imotZSSzaQbldxILzM9cqWApZjT
	JdTjoFXpnulR5GJd2Ps=
X-Received: by 2002:a05:690c:d8a:b0:882:309e:fcaa with SMTP id 00721157ae682-89733726012mr21472487b3.15.1789933127683;
        Sun, 20 Sep 2026 12:38:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a46c43cecsm19037957b3.22.2026.09.20.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:46 -0700 (PDT)
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
Subject: [RFC PATCH 19/46] x86: liveupdate: Add low-level physical CPU preservation assembly
Date: Sun, 20 Sep 2026 15:36:23 -0400
Message-ID: <20260920193650.3373435-20-pasha.tatashin@soleen.com>
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

Add arch/x86/kernel/preserve_cpu.S stack switch routine, preserved linker
sections in vmlinux.lds.S, and SMP stop exclusion for preserved cores.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/include/asm/cpu_preserve.h | 31 +++++++++++++++
 arch/x86/kernel/preserve_cpu.S      | 62 +++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S       |  2 +
 3 files changed, 95 insertions(+)
 create mode 100644 arch/x86/include/asm/cpu_preserve.h
 create mode 100644 arch/x86/kernel/preserve_cpu.S

diff --git a/arch/x86/include/asm/cpu_preserve.h b/arch/x86/include/asm/cpu_preserve.h
new file mode 100644
index 000000000000..969903eb70cb
--- /dev/null
+++ b/arch/x86/include/asm/cpu_preserve.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef __ASM_X86_CPU_PRESERVE_H
+#define __ASM_X86_CPU_PRESERVE_H
+
+#include <asm/page_types.h>
+
+#define ARCH_CPU_PRESERVED_STACK_ORDER	THREAD_SIZE_ORDER
+
+#ifdef CONFIG_CC_IS_GCC
+#define ARCH_CPU_PRESERVED_TEXT \
+	__attribute__((indirect_branch("keep"), function_return("keep")))
+#else
+#define ARCH_CPU_PRESERVED_TEXT
+#endif
+
+#ifdef CONFIG_LIVEUPDATE_CPU
+void arch_cpu_preserved_load_desc(void);
+bool arch_cpu_preserved_is_active(void);
+void x86_preserved_iret_stub(void);
+void x86_preserved_iret_err_stub(void);
+void x86_preserved_apic_eoi_stub(void);
+#else
+static inline void arch_cpu_preserved_load_desc(void) {}
+static inline bool arch_cpu_preserved_is_active(void) { return false; }
+#endif
+
+#endif /* __ASM_X86_CPU_PRESERVE_H */
diff --git a/arch/x86/kernel/preserve_cpu.S b/arch/x86/kernel/preserve_cpu.S
new file mode 100644
index 000000000000..8acb98d46f90
--- /dev/null
+++ b/arch/x86/kernel/preserve_cpu.S
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+#include <asm/unwind_hints.h>
+
+	.section .text.cpu_preserved, "ax"
+
+SYM_CODE_START(x86_preserved_iret_err_stub)
+	UNWIND_HINT_IRET_REGS
+	ENDBR
+	addq	$8, %rsp
+	iretq
+SYM_CODE_END(x86_preserved_iret_err_stub)
+
+SYM_CODE_START(x86_preserved_iret_stub)
+	UNWIND_HINT_IRET_REGS
+	ENDBR
+	iretq
+SYM_CODE_END(x86_preserved_iret_stub)
+
+SYM_CODE_START(x86_preserved_apic_eoi_stub)
+	UNWIND_HINT_IRET_REGS
+	ENDBR
+	pushq	%rax
+	pushq	%rcx
+	pushq	%rdx
+	/* x2APIC mode: MSR 0x80b (APIC_EOI) = 0 */
+	movl	$0x80b, %ecx
+	xorl	%eax, %eax
+	xorl	%edx, %edx
+	wrmsr
+	popq	%rdx
+	popq	%rcx
+	popq	%rax
+	iretq
+SYM_CODE_END(x86_preserved_apic_eoi_stub)
+
+/*
+ * arch_cpu_preserved_call_on_stack - Switch stack and call function
+ * @cpu: CPU ID (%rdi)
+ * @stack: Target stack top (%rsi)
+ * @fn: Function pointer to invoke (%rdx)
+ */
+SYM_CODE_START(arch_cpu_preserved_call_on_stack)
+	pushq	%rbp
+	movq	%rsp, %rbp
+	pushq	%r12
+
+	movq	%rsp, %r12	/* save old stack pointer */
+	movq	%rsi, %rsp	/* switch to target stack */
+
+	call	*%rdx		/* call fn(cpu) */
+
+	movq	%r12, %rsp	/* restore old stack pointer */
+	popq	%r12
+	leave
+	ret
+SYM_CODE_END(arch_cpu_preserved_call_on_stack)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2438b89a4620..9b8b70057bcf 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -155,6 +155,7 @@ SECTIONS
 #endif
 		ALIGN_ENTRY_TEXT_END
 
+		CPU_PRESERVED_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -194,6 +195,7 @@ SECTIONS
 #endif
 
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
+		CPU_PRESERVED_DATA
 
 		CACHE_HOT_DATA(L1_CACHE_BYTES)
 
-- 
2.55.0.1082.g2b9226bbc0-goog

