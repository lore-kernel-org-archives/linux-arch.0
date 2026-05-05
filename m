Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D73CF025
	for <linux-arch@vger.kernel.org>; Tue,  5 May 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962091; cv=none; b=ClZiGMQjGNh4gS69DvGGIRFh+qXIeiSZ/4Q/XK9uiWwlELtBflbmy2+Fwt0ynqpgZV7xXbnF+bMHAL7qDVP1rfQh3MvPO7sSISXJJjlkzfdXaKP32qRW+VBXXhz/AAibtt5sfJaHYO1t5QXVrW9bDEJYfR9oA1mtR/5RZ5gxXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962091; c=relaxed/simple;
	bh=AK7F7VoU9F9EinHl0J/LunF3c/i6HBW1++hF5htlcaA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7ZNTKRE4FQzhBNaCrX/PwstzxYqWgVA80IFeFPiXCcYvleQi/A9y5rY/Ms/6LqWXcuWSS/WkuU+7ntNuK2hf5pF2RPPvcp4X1QWn7topZFTMaAW5yeNWs/9le+vCnDCCDNL8h/bouS5W/9x//DlLtR500H1OWjdUWyWaWpCssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GjR5QJxL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GjR5QJxL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso3749013b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 04 May 2026 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777962084; x=1778566884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4znkv+W5vuAGwYDPrkKlG4HbKRGYXv2X7CusMf1hFi8=;
        b=GjR5QJxLk2Bx+o4Tp8/+Kd6zribhZ9+M30mTDwY9x6Y00q6QA7ioCKVb5zNSoKZcDw
         i2QkD/VW+EtmC/S9z6ei3FXxk4avJPt744KIhP5GXncJtIeFsYHSQ7cQnYfEYHEmj8J0
         Carbd4fbaHBYijvvXOPCztfAr8U2j+5joT5ZikOq17qkFGPe/JJGeW2AQdYsFEse+F3W
         KvisFkgw3K9Nl9yDxdiCCIl24EADQk8IoySd+u1eOPpd6t6c6s3WHPxb5ndmHfPzNSa9
         8wLYlzyt9g2XEEWaUVW3tzkQJfkNbvvFZP93anzTSr1VmNMf/WvT3ZFGs4cQw6yJoEvW
         LCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777962084; x=1778566884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4znkv+W5vuAGwYDPrkKlG4HbKRGYXv2X7CusMf1hFi8=;
        b=hHYmByyJoC3XdgMW9KRMOXxR8OxwHrRSCxjJgAQ4ks/oFhcJYjGb+EnHXrqVWRyuax
         bO5VkoPjz9GX7ECzHs9NeDbWJxVYPXj0piHgLHeXfMH0U85zBEwrSuCojO/3BkjoDqc0
         dCzYli/hPCQKwJXJrXwsEdZZryj1nQDiMd58w1bavlbT4DxEqXXCC6wsrqRdDM/JusS3
         C9JZzMo6foL/7wZVAMb7zN0hWPaYRJXhvDDotu8qpTnmAaZT9vA2gtAtlXMHF0Xy39mk
         FBPulIRaqPOhNroDKIsLcjy0WvavIl1rW7HXyekyMurhdnNcn/jqc6npqUN+12fLZmbu
         BMYw==
X-Forwarded-Encrypted: i=1; AFNElJ/ANBdTUU4cK+9P1zHGAySugVjnoIzuhO3U7DA6v/U4oG8RaplAz07iTdZA6IEPZ6C++4BVBr1TgbTl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2w6yveaAZwdStF6O2tyRDmJfBAw8U8vzKLANLnOPbUyD46k56
	kO7u0+qC6EEnXL03eksA6EOlPyIZ19K9kAAckRMhqyNfGuRHdNH6JfVz8in403wLQvU=
X-Gm-Gg: AeBDievwO7sE5UWp0B8Zm48whtNBuIMlwXCCiu47Vu9r3+0r5AnAbf+yHU6WG1Y5CHI
	3lriHyX0czqI+CVZEowb3+v1/gmVClygOkkuBqQ2ySeTKsDzR/urNCoQCkquI2Gr069dI5ffEpa
	0FXw7RjDkiizG4KHCUPifNYJi8zqb7/O8IIgGS7LzHPop6/VObpwwayJvsCQFXoYVyUz9ZfBAYu
	VUn3HiLRI70Hgma0PKGHZCS10gOCwghcnfIvewpxS0rQdiu6m8atQNJcNsIldQgUn2fRCB3avlC
	bPLswdRDQcZW/YurwpJkAktplhC3llSQJ25cxa9alukX+VwBCdvB74AlrvCNStUG/Klby/4yPAX
	v8S0YOUg/U3FCVF37Ox+YO8orcTHQdhQ8vT0lwZ0gZcKtTj4iLfWZvlzNzVDlPlAdL6h41FhMWx
	1j6ipbiJsmCtGwF0rdID0pwheeZjFASoX7JQdQxEQZQVOXnLASjTusGeDbSunmtyWA
X-Received: by 2002:a05:6a00:14ca:b0:82f:721f:10ea with SMTP id d2e1a72fcca58-8352d1bf331mr13120000b3a.18.1777962084168;
        Mon, 04 May 2026 23:21:24 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c10sm880738b3a.37.2026.05.04.23.21.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 23:21:23 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	conor.dooley@microchip.com,
	tglx@kernel.org,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 3/3] riscv: store percpu offset into thread_info
Date: Tue,  5 May 2026 14:20:26 +0800
Message-Id: <20260505062026.91724-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260505062026.91724-1-cuiyunhui@bytedance.com>
References: <20260505062026.91724-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Originally we planned to add a register for the percpu offset,
which would speed up percpu variable R/W and reduce access
instructions. After discussion [1], it’s now stored in thread_info.

[1] https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_review/113437553?page=2

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/asm.h         | 6 +-----
 arch/riscv/include/asm/percpu.h      | 4 ++++
 arch/riscv/include/asm/switch_to.h   | 8 ++++++++
 arch/riscv/include/asm/thread_info.h | 3 ++-
 arch/riscv/kernel/asm-offsets.c      | 1 +
 arch/riscv/kernel/smpboot.c          | 7 +++++++
 arch/riscv/net/bpf_jit_comp64.c      | 9 +--------
 7 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index e9e8ba83e632f..137a49488325e 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,11 +91,7 @@
 
 #ifdef CONFIG_SMP
 .macro asm_per_cpu dst sym tmp
-	lw    \tmp, TASK_TI_CPU_NUM(tp)
-	slli  \tmp, \tmp, RISCV_LGPTR
-	la    \dst, __per_cpu_offset
-	add   \dst, \dst, \tmp
-	REG_L \tmp, 0(\dst)
+	REG_L \tmp, TASK_TI_PCPU_OFFSET(tp)
 	la    \dst, \sym
 	add   \dst, \dst, \tmp
 .endm
diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index 3b26fe45e70f4..84612d672105d 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -7,7 +7,9 @@
 
 #include <asm/alternative-macros.h>
 #include <asm/cpufeature-macros.h>
+#include <asm/current.h>
 #include <asm/hwcap.h>
+#include <asm/thread_info.h>
 
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
@@ -275,6 +277,8 @@ _pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
 })
 #endif
 
+#define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ASM_PERCPU_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920c..733b6cd306e40 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -88,6 +88,13 @@ static inline void __switch_to_envcfg(struct task_struct *next)
 			:: "r" (next->thread.envcfg) : "memory");
 }
 
+static inline void __switch_to_pcpu_offset(struct task_struct *next)
+{
+#ifdef CONFIG_SMP
+	next->thread_info.pcpu_offset = __my_cpu_offset;
+#endif
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -122,6 +129,7 @@ do {							\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
 	__switch_to_envcfg(__next);			\
+	__switch_to_pcpu_offset(__next);		\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 55019fdfa9eca..f10ba62b61016 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -53,6 +53,7 @@
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	int			cpu;
 	/*
 	 * These stack pointers are overwritten on every system call or
 	 * exception.  SP is also saved to the stack it can be recovered when
@@ -60,8 +61,8 @@ struct thread_info {
 	 */
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
-	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	unsigned long		pcpu_offset;
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index af827448a609e..fbf53b66b0e06 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -38,6 +38,7 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_SUM, task_struct, thread.sum);
 
 	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
+	OFFSET(TASK_TI_PCPU_OFFSET, task_struct, thread_info.pcpu_offset);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 8b628580fe118..41463a8400f6c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -209,6 +209,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 }
 #endif
 
+void __init smp_prepare_boot_cpu(void)
+{
+	__my_cpu_offset = per_cpu_offset(smp_processor_id());
+}
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
@@ -234,6 +239,8 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	__my_cpu_offset = per_cpu_offset(smp_processor_id());
+
 #ifdef CONFIG_HOTPLUG_PARALLEL
 	cpuhp_ap_sync_alive();
 #endif
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 2f1109dbf105b..177c19216013e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1395,15 +1395,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			if (rd != rs)
 				emit_mv(rd, rs, ctx);
 #ifdef CONFIG_SMP
-			/* Load current CPU number in T1 */
-			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
+			emit_ld(RV_REG_T1, offsetof(struct thread_info, pcpu_offset),
 				RV_REG_TP, ctx);
-			/* Load address of __per_cpu_offset array in T2 */
-			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
-			/* Get address of __per_cpu_offset[cpu] in T1 */
-			emit_sh3add(RV_REG_T1, RV_REG_T1, RV_REG_T2, ctx);
-			/* Load __per_cpu_offset[cpu] in T1 */
-			emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
 			/* Add the offset to Rd */
 			emit_add(rd, rd, RV_REG_T1, ctx);
 #endif
-- 
2.39.5

