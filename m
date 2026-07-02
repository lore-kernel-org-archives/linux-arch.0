Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95030F819
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960970; cv=none; b=d6n3NE4ORulgOGZsb/ChTm5re7+kuYRhZ8AswMyngOgIhxfGiuhMV6y/ee5ZpnHYPUqz2+RrMRI4OTnthg7Abppg6z19Bwath/b/ZIoF1zWhJKG/4Bv+wXSsTOcDKyGQqcDykH9S7iDScxwIhioACsOSMkZwIIeMne3YlFKHlRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960970; c=relaxed/simple;
	bh=m0V0OPDHu9n8ExfR/oojEcseWQEh1xnRnoD6pdxSmg4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDNBA3ZjBUtfili+nkhiT6v2foXTb71JtDr+oqhzZ9Nis30lU9kL5Cx8gL0gDSsmvXSVS+0L/puSjhDCaDpSHNJOKkNA9w3FvnqQohzz87E6Ltw+xlOqGVsx5k97Ztrh9MO7lLZuUrGFowbXpwMGtnUnyrrVMPX4RfnkuMGkS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Mn5/sraM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Mn5/sraM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso546021a91.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2026 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782960967; x=1783565767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQPTBqHJeemrKxXZgGGu1DBrDIrOfa0jY+13RjETMTs=;
        b=Mn5/sraM+xOfMHvaUr2bbUDZehK5hEBpIYtoPur6bCmIYqa20OckCe2ElhZuyaGfp2
         4PWlSeB0/7sGoO06qx6QSx/iWwc2PzDTe1F6rajEALmVeLCcMSp/Vum2SG+o3oXtBJHj
         4jxh1VMOZB5/oWPonEb895qQv8VgZP1CedNjxpnn2YyCDtZiVgd3vrfXj3k+ThBpb939
         RECxr4i8gsbIl6Ltu5LC/d7de1VGmae9XXSTFcoSvCH6npzZ2rTdpO3uLzlkkZxEHfmY
         dbX6u9Rgod/ukLbVbnqlAX1xw9JIxYmOCGerih4m84AQWajgUCaqzGjNVBMpWXildaHT
         MJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960967; x=1783565767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQPTBqHJeemrKxXZgGGu1DBrDIrOfa0jY+13RjETMTs=;
        b=SXdXZ63ueADmma3kB+bfhkVc45W3XzC6eSzrPdlejPpboSmsutLRN4NHLgD1J23b1G
         mX6kB/HPbsX2zfuu5zyxBBMw+gNTIAI7dvMckA937/7i6Qg6dzb9sITb/NSprbeWU/nE
         Jh5nprkIUgNYl6Fv/0wDW75TYgfyja14BDkI821vykxtTSWdWHH1mWLHOQRrR2PESiTG
         gqseBp7vLz1kzo/QMekwMU7ySI2VCz7Kv3uUu4N0VPLSjUQLLwxTG6MT4SYsoewjU8w4
         x74cr6+RAyRSCjZcgzbPop1xrbGIyH72jI3VbcPgCHJrDz/Di+VGG10/Q56eZHk9AVfZ
         xxfA==
X-Forwarded-Encrypted: i=1; AHgh+Ro56T5GZt/NF2TkwnIkUT/SFngGJw/ovA6az4DPyRodc6TUXV8f94j2nT7uKRTMqbwwD/DV7zLyOZmT@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWOuOyKs4ZGGUF/9U02ZRs7Jd/wCGtOmB2688RWE/W5wMwX4u
	/Nc2iwe98+nsOb4+sk83sfohKQMv9InLzUDySMoZt9sD+SpYDaSPaxd8AZbmVk3rmaE=
X-Gm-Gg: AfdE7cmY1IpoCw9GugTzCbEWMoJ9aRwJFuH+Fr/8DeUdTxb/nbSkCpUu6lqMs3RKQB8
	TYM4tC4NkXCW6Gzb0Ub4kNYAalvlagqcMF4PXFM5QBwndshtedL/Ppm+toNlANcndS5QPXOpwdW
	OiOqo9Xhan6dvlmRDBhBax/pACCQDQzNTJwFbiJxvdvOh6hfKTvHmvV+AfYmgOql5tODn55Y1qJ
	7qqX95LMMw8oLLolDUFDLxzCYGPpiQ8ZnVm26+DTHF5ib00/hJH17oTS972pO6Nh0NBlIB9c0H4
	+JMdYUobShjwgMbRjvBax2dO+fo+aSyWiD2EqDBkCtIx3FD80B0kVEZ+X1RY/5K6uCwzgxK4eHK
	+ret3XfvHaFuoFBhWHH6GJJehfI+ukux1DNBUa+CB8DUlBFKvlVCptHrBAeNgUy71nzIQd/AMcj
	vtDOUpqSx5LIpRDIZy3EqeHf4CZ05II37o8XKF+9pR9JSDbg==
X-Received: by 2002:a17:90b:5863:b0:37d:ac5b:392f with SMTP id 98e67ed59e1d1-380ba8a2945mr3208382a91.8.1782960966655;
        Wed, 01 Jul 2026 19:56:06 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm4358686eec.15.2026.07.01.19.55.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 19:56:06 -0700 (PDT)
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
Subject: [PATCH v7 3/3] riscv: store percpu offset into thread_info
Date: Thu,  2 Jul 2026 10:54:43 +0800
Message-Id: <20260702025443.83389-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260702025443.83389-1-cuiyunhui@bytedance.com>
References: <20260702025443.83389-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V percpu addressing currently derives the base offset from the CPU
number and __per_cpu_offset[]. Cache the current CPU percpu offset in
thread_info so percpu accesses can load it directly.

Keep the cached value up to date for the boot CPU, context switches and
secondary CPU bringup. Initialize secondary idle tasks before they start
running so early percpu accesses use the secondary CPU offset rather than
inheriting the boot CPU value.

Link: https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_review/113437553?page=2
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/asm.h         | 6 +-----
 arch/riscv/include/asm/percpu.h      | 4 ++++
 arch/riscv/include/asm/switch_to.h   | 8 ++++++++
 arch/riscv/include/asm/thread_info.h | 3 ++-
 arch/riscv/kernel/asm-offsets.c      | 1 +
 arch/riscv/kernel/smpboot.c          | 8 ++++++++
 arch/riscv/net/bpf_jit_comp64.c      | 9 +--------
 7 files changed, 25 insertions(+), 14 deletions(-)

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
index 76b1b8c1fb953..9bf9f4cf4ca5a 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -9,7 +9,9 @@
 #include <asm/alternative-macros.h>
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature-macros.h>
+#include <asm/current.h>
 #include <asm/hwcap.h>
+#include <asm/thread_info.h>
 
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
@@ -279,6 +281,8 @@ _pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
 })
 #endif
 
+#define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
+
 #undef PERCPU_RW_OPS
 #undef __PERCPU_AMO_OP_CASE
 #undef PERCPU_OP
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
index a75f0cfea1e9f..20d46c28fdde9 100644
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
index f6ef57930b50a..7876854d16279 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -191,6 +191,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret;
 	tidle->thread_info.cpu = cpu;
+	tidle->thread_info.pcpu_offset = per_cpu_offset(cpu);
 
 	ret = start_secondary_cpu(cpu, tidle);
 	if (!ret) {
@@ -208,6 +209,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -233,6 +239,8 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	__my_cpu_offset = per_cpu_offset(smp_processor_id());
+
 #ifdef CONFIG_HOTPLUG_PARALLEL
 	cpuhp_ap_sync_alive();
 #endif
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c03c1de16b79a..eab93d5258e9e 100644
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

