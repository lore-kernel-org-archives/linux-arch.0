Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B930EF80
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960951; cv=none; b=uCBmILsZiHiIIKepFUNgiGFFMxkt51wF2oknb5xHTHrN0pc6R1OF7epLOXCN7XaU9QNd63Ml3eVbbp50NnCVfQXlzVlpkYlCZx0rBPd+b0GO7DZdfk/v8AZt8co1NVauIDwCe7jSmvZEcaQO/BfHP9T7cMu6gd+zWrLaJhA4hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960951; c=relaxed/simple;
	bh=y5y4a93GgL/orvFUN/Uor2HDrTnqTDD+DCdyAQyAlJ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltWWsrnkWP2ygNhut+pZt6b7Er+FSm1/M1kLAhPqZGs2vcB84LOJPiW4trqfoHa1HYcMhWNIZCM+PbCBCsWt/xUzdnkGzR1ni3NcL9JfF3XlqlOlCeYyY7ROXaLolyEA5bE9aZXX9oUnYE77ps0h/tF+NljpLyHvkkgZeX8bFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IdMfol0b; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IdMfol0b"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso1010789a91.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2026 19:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782960949; x=1783565749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P1+gFKW+hS3rC0joaH/H8WLhsT6tdelp56PcQVXSPXM=;
        b=IdMfol0b/+U2yd2CgRwECPepIRmjuyqin7xhYOY9qKO7wp+IlqiwiuSkHbxZhvHoya
         C7Q/TKx/qoXG6Vu54Ys1NHveYHMI+5ac7RFvtJi0ENJsv2B/euMvv4TDcGVbkbl6s9fw
         LLBS8yyziIapqAXG3hr0UYtbKlhgxebnn+TGbwfJE4S2cz6OfZbQFqss9fhy1DM8JBVV
         aV9ZEyDKtJheOWK9UfVlFduymEynoxFPcYAZko2KvS6NDgVfUqRpoHNEI+c4uPnhILJ3
         /kGyPapWyOE+K218VmFheFrI5KbaPLBQiNzbn7zWW/L0UcXkEmolhrxGncLFvAMgZlpk
         BVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960949; x=1783565749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=P1+gFKW+hS3rC0joaH/H8WLhsT6tdelp56PcQVXSPXM=;
        b=dKYUnxjnpwYWomHybxsKjjl7Mg1IIYhsqRBQZCGmjQw0S/uIARhFIBzT1YMOAaPeGv
         WvuRfGEL3fKZl7UOc6xrMdeKcSf5EEmsg2IlD4MCJh3sfc+/R3MNC2IEL5BMiCc171og
         Lyu20M16N1PEDNy77iZ6JkTzPzrDVI3WCORPYwssNsXRyjEqAvBIkHnRG7ziavIVI8JJ
         ZT2QxnBSxV8L10g98qWewK6A+ALjFhnypxpHCKDynVL1ye77iFsf9S++QNI+D+5nepbE
         ZovcNaPL/KFEI/eIO1zjksnkL68SXRri21hXSIiID8/5mTk9/DRVG2eBaZ0AAxIrXIxL
         A7yQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6NJQwEzuCZ7fKOnNXc5M83tQUWKknf89idMk7gLRXKs+4p+NpASAq0zQDGyriX0hvqVifTiY1kaJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoKO3RRX2EnP2ybK2dcmYn4bKy7vsHbZ5zrsudOK2BnFenlRK
	Lg+aZYWk+yMLaVmp37h7o5BBwE9JgHTNbasGuLWRXyDKbS48VqEB3f9XmckTllr6zek=
X-Gm-Gg: AfdE7clxerTrV4ogripsnIBuZc9Lg+DjPVRafOIydzoNoLmdU9ghIgWOieezOiFAdm8
	rWi+aFtawgrBXw67kcMiGQaEmexXgbwMu2Dn53CKafSUpBWyjwJeSnsh71poXlwzmEKXqj2HDho
	N1mjxtW2bv+huU80a2plmGv+IoW/Ak+rhNHd/eHCVJxUELjPczVRLdXRvr7SRu9r9QLpRNwrnXo
	TE9v6d5CvE9Fw7B0ii0Y9lBokHItvZzh7r9Znmw8w2pgE6IJuonkpTNpkbi6xizsbE64e8fC2Fh
	6vNU/BgFkilaV1yh2dwcveyKvuvtY3b0Uy+9H8Wx+lnHGBhmnTKKM4Au5oiXakrLo57/3QkGdGo
	CFsFk7sBS89B+1IfzaS/9bn7oT+UKsZSIFOMfvhQ8D3w5B4oacUq1/pRqhgzJxz9KHZjkug61fV
	MCLFeTC9KkL2t0hJkvTh9WujG3N9uWGDXf24eVLdyjUbf2Eg==
X-Received: by 2002:a17:90b:3952:b0:37f:c239:10f5 with SMTP id 98e67ed59e1d1-380ba82a068mr3613599a91.12.1782960949162;
        Wed, 01 Jul 2026 19:55:49 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm4358686eec.15.2026.07.01.19.55.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 19:55:48 -0700 (PDT)
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
Subject: [PATCH v7 2/3] riscv: introduce percpu.h into include/asm
Date: Thu,  2 Jul 2026 10:54:42 +0800
Message-Id: <20260702025443.83389-3-cuiyunhui@bytedance.com>
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

Add RISC-V specific this_cpu helpers so common percpu operations can use
short architecture sequences instead of the generic implementation.
Native-width operations use AMOs, while 8/16-bit operations use Zabha when
available and a local 32-bit LR/SC fallback otherwise.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 296 ++++++++++++++++++++++++++++++++
 1 file changed, 296 insertions(+)
 create mode 100644 arch/riscv/include/asm/percpu.h

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
new file mode 100644
index 0000000000000..76b1b8c1fb953
--- /dev/null
+++ b/arch/riscv/include/asm/percpu.h
@@ -0,0 +1,296 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+#include <linux/bits.h>
+#include <linux/preempt.h>
+
+#include <asm/alternative-macros.h>
+#include <asm/cmpxchg.h>
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+
+#define PERCPU_RW_OPS(sz)						\
+static inline unsigned long __percpu_read_##sz(void *ptr)		\
+{									\
+	return READ_ONCE(*(u##sz *)ptr);				\
+}									\
+									\
+static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
+{									\
+	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
+}
+
+PERCPU_RW_OPS(8)
+PERCPU_RW_OPS(16)
+PERCPU_RW_OPS(32)
+
+#ifdef CONFIG_64BIT
+PERCPU_RW_OPS(64)
+#endif
+
+#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\
+static inline void							\
+__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
+{									\
+	asm volatile (							\
+		"amo" #amo_insn #sfx " zero, %[val], %[ptr]"		\
+		: [ptr] "+A" (*(u##sz *)ptr)				\
+		: [val] "r" ((u##sz)(val))				\
+		: "memory");						\
+}
+
+#ifdef CONFIG_64BIT
+#define PERCPU_OP(name, amo_insn)					\
+	__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)			\
+	__PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
+#else
+#define PERCPU_OP(name, amo_insn)					\
+	__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)
+#endif
+
+PERCPU_OP(add, add)
+PERCPU_OP(and, and)
+PERCPU_OP(or, or)
+
+/*
+ * Currently, only this_cpu_add_return_xxx() requires a return value,
+ * and the PERCPU_RET_OP() does not account for other operations.
+ */
+#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)		\
+static inline u##sz							\
+__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long val)	\
+{									\
+	register u##sz ret;						\
+									\
+	asm volatile (							\
+		"amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"		\
+		: [ptr] "+A" (*(u##sz *)ptr), [ret] "=r" (ret)		\
+		: [val] "r" ((u##sz)(val))				\
+		: "memory");						\
+									\
+	return ret + val;						\
+}
+
+#ifdef CONFIG_64BIT
+#define PERCPU_RET_OP(name, amo_insn)					\
+	__PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)		\
+	__PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
+#else
+#define PERCPU_RET_OP(name, amo_insn)					\
+	__PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)
+#endif
+
+PERCPU_RET_OP(add, add)
+
+#define PERCPU_8_16_GET_SHIFT(ptr)	(((unsigned long)(ptr) & 0x3) * BITS_PER_BYTE)
+#define PERCPU_8_16_GET_MASK(sz)	GENMASK((sz) - 1, 0)
+#define PERCPU_8_16_GET_PTR32(ptr)	((u32 *)((unsigned long)(ptr) & ~0x3))
+
+#define PERCPU_8_16_OP(name, amo_insn, sz, sfx, val_type, new_val_expr, asm_op)			\
+static inline void __percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
+{												\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\
+		asm volatile ("amo" #amo_insn #sfx " zero, %[val], %[ptr]"			\
+			: [ptr] "+A"(*(val_type *)ptr)						\
+			: [val] "r"((val_type)((new_val_expr) & PERCPU_8_16_GET_MASK(sz)))	\
+			: "memory");								\
+	} else {										\
+		u32 *ptr32 = PERCPU_8_16_GET_PTR32(ptr);					\
+		const unsigned long shift = PERCPU_8_16_GET_SHIFT(ptr);				\
+		const u32 mask = PERCPU_8_16_GET_MASK(sz) << shift;				\
+		const val_type val_trunc = (val_type)((new_val_expr)				\
+					   & PERCPU_8_16_GET_MASK(sz));				\
+		u32 old, new;									\
+		val_type field;									\
+												\
+		asm volatile (									\
+			"0: lr.w %0, %2\n"							\
+			"and %3, %0, %4\n"							\
+			"srl %3, %3, %5\n"							\
+			#asm_op " %3, %3, %6\n"							\
+			"and %3, %3, %8\n"							\
+			"sll %3, %3, %5\n"							\
+			"and %1, %0, %7\n"							\
+			"or %1, %1, %3\n"							\
+			"sc.w %1, %1, %2\n"							\
+			"bnez %1, 0b\n"								\
+			: "=&r"(old), "=&r"(new), "+A"(*ptr32), "=&r"(field)			\
+			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(~mask),			\
+			  "r"(PERCPU_8_16_GET_MASK(sz))						\
+			: "memory");								\
+		}										\
+}
+
+#define PERCPU_OP_8_16(op_name, op, expr, final_op)			\
+	PERCPU_8_16_OP(op_name, op, 8, .b, u8, expr, final_op);		\
+	PERCPU_8_16_OP(op_name, op, 16, .h, u16, expr, final_op)
+
+PERCPU_OP_8_16(add, add, val, add)
+PERCPU_OP_8_16(and, and, val, and)
+PERCPU_OP_8_16(or, or, val, or)
+
+#define PERCPU_8_16_RET_OP(name, amo_insn, sz, sfx, val_type, new_val_expr)			\
+static inline val_type __percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long val)	\
+{												\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\
+		register val_type ret;								\
+		asm volatile ("amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"			\
+			: [ptr] "+A"(*(val_type *)ptr), [ret] "=r"(ret)				\
+			: [val] "r"((val_type)((new_val_expr) & PERCPU_8_16_GET_MASK(sz)))	\
+			: "memory");								\
+		return ret + (val_type)((new_val_expr) & PERCPU_8_16_GET_MASK(sz));		\
+	} else {										\
+		u32 *ptr32 = PERCPU_8_16_GET_PTR32(ptr);					\
+		const unsigned long shift = PERCPU_8_16_GET_SHIFT(ptr);				\
+		const u32 mask = (PERCPU_8_16_GET_MASK(sz) << shift);				\
+		const u32 inv_mask = ~mask;							\
+		const val_type val_trunc = (val_type)((new_val_expr)				\
+					   & PERCPU_8_16_GET_MASK(sz));				\
+		u32 old, new, field;								\
+												\
+		asm volatile (									\
+			"0: lr.w %0, %3\n"							\
+			"and %1, %0, %4\n"							\
+			"srl %1, %1, %5\n"							\
+			"add %1, %1, %6\n"							\
+			"and %1, %1, %7\n"							\
+			"sll %1, %1, %5\n"							\
+			"and %2, %0, %8\n"							\
+			"or %2, %2, %1\n"							\
+			"sc.w %2, %2, %3\n"							\
+			"bnez %2, 0b\n"								\
+			: "=&r"(old), "=&r"(field), "=&r"(new), "+A"(*ptr32)			\
+			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(PERCPU_8_16_GET_MASK(sz)), \
+			"r"(inv_mask)								\
+			: "memory");								\
+		return (val_type)(field >> shift);						\
+	}											\
+}
+
+PERCPU_8_16_RET_OP(add, add, 8, .b, u8, val)
+PERCPU_8_16_RET_OP(add, add, 16, .h, u16, val)
+
+#define _pcp_protect(op, pcp, ...)					\
+({									\
+	preempt_disable_notrace();					\
+	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
+	preempt_enable_notrace();					\
+})
+
+#define _pcp_protect_return(op, pcp, args...)				\
+({									\
+	typeof(pcp) __retval;						\
+	preempt_disable_notrace();					\
+	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
+	preempt_enable_notrace();					\
+	__retval;							\
+})
+
+#define this_cpu_read_1(pcp)		_pcp_protect_return(__percpu_read_8, pcp)
+#define this_cpu_read_2(pcp)		_pcp_protect_return(__percpu_read_16, pcp)
+#define this_cpu_read_4(pcp)		_pcp_protect_return(__percpu_read_32, pcp)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_read_8(pcp)		_pcp_protect_return(__percpu_read_64, pcp)
+#endif
+
+#define this_cpu_write_1(pcp, val)	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
+#define this_cpu_write_2(pcp, val)	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
+#define this_cpu_write_4(pcp, val)	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_write_8(pcp, val)	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
+#endif
+
+#define this_cpu_add_1(pcp, val)	_pcp_protect(__percpu_add_amo_case_8, pcp, val)
+#define this_cpu_add_2(pcp, val)	_pcp_protect(__percpu_add_amo_case_16, pcp, val)
+#define this_cpu_add_4(pcp, val)	_pcp_protect(__percpu_add_amo_case_32, pcp, val)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_add_8(pcp, val)	_pcp_protect(__percpu_add_amo_case_64, pcp, val)
+#endif
+
+#define this_cpu_add_return_1(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_8, pcp, val)
+
+#define this_cpu_add_return_2(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_16, pcp, val)
+
+#define this_cpu_add_return_4(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_add_return_8(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
+#endif
+
+#define this_cpu_and_1(pcp, val)	_pcp_protect(__percpu_and_amo_case_8, pcp, val)
+#define this_cpu_and_2(pcp, val)	_pcp_protect(__percpu_and_amo_case_16, pcp, val)
+#define this_cpu_and_4(pcp, val)	_pcp_protect(__percpu_and_amo_case_32, pcp, val)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_and_8(pcp, val)	_pcp_protect(__percpu_and_amo_case_64, pcp, val)
+#endif
+
+#define this_cpu_or_1(pcp, val)	_pcp_protect(__percpu_or_amo_case_8, pcp, val)
+#define this_cpu_or_2(pcp, val)	_pcp_protect(__percpu_or_amo_case_16, pcp, val)
+#define this_cpu_or_4(pcp, val)	_pcp_protect(__percpu_or_amo_case_32, pcp, val)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_or_8(pcp, val)	_pcp_protect(__percpu_or_amo_case_64, pcp, val)
+#endif
+
+#define this_cpu_xchg_1(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_2(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_4(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_xchg_8(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#endif
+
+#define this_cpu_cmpxchg_1(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_2(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_4(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_cmpxchg_8(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+
+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
+#endif
+
+#ifdef system_has_cmpxchg128
+#define this_cpu_cmpxchg128(pcp, o, n)					\
+({									\
+	u128 ret__;							\
+	typeof(pcp) *ptr__;						\
+									\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	if (system_has_cmpxchg128())					\
+		ret__ = cmpxchg128_local(ptr__, (o), (n));		\
+	else								\
+		ret__ = this_cpu_generic_cmpxchg(pcp, (o), (n));	\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+#endif
+
+#undef PERCPU_RW_OPS
+#undef __PERCPU_AMO_OP_CASE
+#undef PERCPU_OP
+#undef __PERCPU_AMO_RET_OP_CASE
+#undef PERCPU_RET_OP
+#undef PERCPU_8_16_GET_SHIFT
+#undef PERCPU_8_16_GET_MASK
+#undef PERCPU_8_16_GET_PTR32
+#undef PERCPU_8_16_OP
+#undef PERCPU_OP_8_16
+#undef PERCPU_8_16_RET_OP
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_PERCPU_H */
-- 
2.39.5

