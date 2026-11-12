Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480267;
	b=JCXPaqQcGppkMAOlF8AUe0t3k+ytu9C1e0XjwviYKO0UdtDFiVgZPfhdZFRoCyFJqkOa
	 gzsmv+DahatfG6HfExlYKIdYR8A2RrTw4jhA4VN9pkujtnFy/+xte1s+57tSXo1DtlZAZ
	 l6hiQQv7S5z1qZ5NqZjmaY2eaaXBklgvVRa3K/kMTr+VL0ojUKD/dfeBb9U7TDJ7NLXXk
	 mD06xhc/Isofw4jtY42frwkAHgaJ1csIBRX5uSSFupczXn0joYGd/Oewthq7e3XAoT4XD
	 ANzD6kjmzK3087TZUFRFgNq0CRtivriW6JpOSwdebrWR+QjYiy0sAtnDS0ku53pB4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c+0NQhm/2dySRhzukgerkWXzp7x9hEGESn4jnFASt64=;
	b=iwzHNdmFdvevdP/kHO4FntwQ53XJriszQ6lqAzLK2F14jzptD6ZbECBXIsyY9pVYmPS4
	 Ya54zIV9h1BF12vPGKfq7u8BRix++1Xy0SIHn5qJFm+9QD0r9S+FA6IauCgabxMiiQPEY
	 TLGVZS0F4RFvEolMoJ4sPQDRaWcFzuUl7XUTQEu9iCnBCQkEYia2taL8BCAtWrjsG1IH7
	 G11Cg9BeRD+Um38Z+0bvS7CyyRk+EjWSWujISfsg3sNh9d+vufbQnNY5PTlN6CMBmi7K0
	 ZE8TxRHwNaK3Gib6wyJLRH4NNg1yfqDkOr0afWDg1nbT+Qs3cH2hJ/ZLNd9vwb6VjIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="UhkB3/vg";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E005606A32A
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 10:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E005606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UhkB3/vg
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-372bdb942dbso5286134eec.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480265; x=1795085065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c+0NQhm/2dySRhzukgerkWXzp7x9hEGESn4jnFASt64=;
        b=UhkB3/vgmHv1ldLwAept4ls7/dn/CpTbyqTnRB560UaGC1dXAiNPJ8gZ1/lamzscB3
         K5yR2U8pqgqbVqsufERseB9J1yXWQJadj5YCL6Ln78zq95d53/uBvuhwE2yAtvqvFV1q
         85M1MVJ37Qjcr3ezKqv5zpVTfhBMzr4NKr48UBubxvG5hY3ztCDKGIEgu44xYU4+69Zu
         iKINFioIJ+ioPs4pgQm+fGxK4DLRm1CrRH+g+loWTVfPVlpIbKX3MgtWWfGZSAGZXO1J
         FqYKOpj+6lle/5ovCPL2upQLRBU85X/0p6FJVya6IcG5W0wOMvunC4BcnBW1JW3jjg3Q
         E44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480265; x=1795085065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c+0NQhm/2dySRhzukgerkWXzp7x9hEGESn4jnFASt64=;
        b=19uGZbg9Q4CJcuRzNz3b7k2tG84xH/w0uhxjxELHoglrrL33oK3blW5YGEeQPOCrK5
         SeUUGVh73KiGjzfHbRc8NT+QwrsnptmAu/Ljlug0BWrdJRuQuve734m8hPRLOdmOaiDt
         pndbuhCZzI+ijSgdIgaxj65EF6oUPV/bPVh1+9zwozh6ylw6I3KTtK5sHYpVVzy8rY4X
         ijpe6hCPqvUQDeB+fclgGvLoVDUwiiVW584BkCvTKs85X/6J8182WYUlJgC12ZpqpQFL
         14HTEG8FhiRSx2Q0Su26/SBZVLkce5gRcVc+RdsFLpW6+gJC0wSfo01qvS8lmF93wiaS
         s7MQ==
X-Forwarded-Encrypted: i=1; AL+hErFAXfN8Gj+cNTtYQSBOzuzrckGiwdZiEihRSFbDvcNx6XaeVMGDuqhKk4R8IURH//bl8BEJk4LvUJwm@vger.kernel.org
X-Gm-Message-State: APuU4Z9sz+t+2OsL3n3LDV1a/j38sFa9HqOkCPR6hYeslnyfu/nrGaqy
	gf8mDKND6WDrDS1Wr1t34vvKyd/idZSZmocSrTUEIn1/4F8xXINdvL8kB+1abYYvbkU=
X-Gm-Gg: AYBFou2G1rijHo9gQmBZJYhypEpIyCuQw+4P4aoIP8IghfdX/DJE7fWhwwLi9DkVJEa
	++eNa4P1lK1RaLg4OAao/e6bEwTN5Bx9COnZttziF9j5ro9KMydlOg7mHvg5xU9RPd/u1ypu9OI
	2qIVGJ0ctrXBtNyl+0QVss9SsIjWJ/0YcW3UQSTYqaNHDNpRSU6UXLuMuxRlm1FBI8esLUpmkMy
	8+v0qHMqOsD1HTOz59lbbHlGhZMGTBDZJiiNu07rJVM4is3klc7tgNJSwnRWZRjy6e3ISqeBpLv
	tqp6v+wha5gUKlarsVIFc2DEOhMpxmDwHtYpSXVTKed26pfn9W4LUX73yohLirH6fn6Z8YKY25t
	iDCUqGDc8PDXZzle0MGA9vvorj0FRKG5kcFxDAK4qVNWzj5upa4DH3gNor1v7BxnMI6aYhsusKW
	yFp89eDTgNsSQaVi/QoiM0SA2kMqIiWqIF4kavynxtA34a/oB6HUifh1knVpaRgfvk9Pg+yZiC2
	7AjHi662pmmeFei2/89uo3ArpbpPnFQwTfACOaSbDIMlUoN9O9c9MbbjcmJmBeQrBTtDZIg/SPs
	LKD5pv/+ELOYacJC0dNuIgWI6xbRhvB96sorbo20iHwG8GHvfdCugsMSewS7HTzAr1vmFem/0jY
	yYsHtIdSrbxhj
X-Received: by 2002:a05:693c:4007:b0:369:f420:8679 with SMTP id 5a478bee46e88-37687211c14mr5675144eec.38.1794480264921;
        Thu, 12 Nov 2026 02:44:24 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.44.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:44:24 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	oleg@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	broonie@kernel.org,
	cuiyunhui@bytedance.com,
	dave@stgolabs.net,
	david.laight.linux@gmail.com,
	jszhang@kernel.org,
	tglx@kernel.org,
	conor.dooley@microchip.com,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v10 6/9] riscv: implement preemptible this_cpu xchg operations
Date: Thu, 12 Nov 2026 18:41:46 +0800
Message-Id: <20261112104149.38589-7-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261112104149.38589-1-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
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

Apply the recoverable per-CPU address handling to exchange operations.

Use AMOSWAP for native-width and Zabha subword operations. Where Zabha is
unavailable, use a masked LR/SC sequence that preserves neighboring fields
in the same word.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 92 +++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index 9ff02f3811550..810f4c5eaa508 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -326,6 +326,81 @@ __percpu_add_return_amo_case_16(void __percpu *pcp, unsigned long val)
 	return __percpu_add_return_8_16(pcp, val, 16);
 }
 
+#define __PERCPU_XCHG_AMO_CASE(sfx, sz)					\
+static __always_inline unsigned long					\
+__percpu_xchg_case_##sz(void __percpu *pcp, unsigned long val)		\
+{									\
+	__PCPU_OP_CONTEXT();						\
+	u##sz ret;							\
+									\
+	asm volatile (__PCPU_GPRS_BEGIN					\
+		"amoswap" #sfx " %[ret], %[val], 0(%[addr])\n"		\
+		__PCPU_GPRS_END						\
+		: [gprs] "=m" (__ti->pcpu_gprs),			\
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),		\
+		  [ret] "=&r" (ret)					\
+		: [pcpu_offset] "m" (__ti->pcpu_offset),		\
+		  [pcp] "r" (pcp), [val] "r" ((u##sz)val)		\
+		: "memory");						\
+									\
+	return ret;							\
+}
+
+__PERCPU_XCHG_AMO_CASE(.w, 32)
+#ifdef CONFIG_64BIT
+__PERCPU_XCHG_AMO_CASE(.d, 64)
+#endif
+
+#define __PERCPU_8_16_XCHG_CASE(sz, sfx)				\
+static __always_inline unsigned long					\
+__percpu_xchg_case_##sz(void __percpu *pcp, unsigned long val)		\
+{									\
+	__PCPU_OP_CONTEXT();						\
+	const u32 field_mask = PERCPU_8_16_GET_MASK(sz);		\
+	const unsigned long shift = PERCPU_8_16_GET_SHIFT(pcp);		\
+	const u32 mask = field_mask << shift;				\
+	const u32 new_field = (val & field_mask) << shift;		\
+	void __percpu *pcp32 = PERCPU_8_16_GET_PCP32(pcp);		\
+	u32 old, new, rc;						\
+	u##sz ret;							\
+									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&			\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {	\
+		asm volatile (__PCPU_GPRS_BEGIN				\
+			".option push\n"				\
+			".option arch, +zabha\n"			\
+			"amoswap" #sfx " %[ret], %[val], 0(%[addr])\n"	\
+			".option pop\n"					\
+			__PCPU_GPRS_END					\
+			: [gprs] "=m" (__ti->pcpu_gprs),		\
+			  [off] "=&r" (__off), [addr] "=&r" (__addr),	\
+			  [ret] "=&r" (ret)				\
+			: [pcpu_offset] "m" (__ti->pcpu_offset),	\
+			  [pcp] "r" (pcp), [val] "r" ((u##sz)val)	\
+			: "memory");					\
+		return ret;						\
+	}								\
+									\
+	asm volatile (__PCPU_GPRS_BEGIN					\
+		"0: lr.w %[old], 0(%[addr])\n"				\
+		"and %[new], %[old], %[inv_mask]\n"			\
+		"or %[new], %[new], %[new_field]\n"			\
+		"sc.w %[rc], %[new], 0(%[addr])\n"			\
+		"bnez %[rc], 0b\n"					\
+		__PCPU_GPRS_END						\
+		: [gprs] "=m" (__ti->pcpu_gprs),			\
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),		\
+		  [old] "=&r" (old), [new] "=&r" (new), [rc] "=&r" (rc)	\
+		: [pcpu_offset] "m" (__ti->pcpu_offset),		\
+		  [pcp] "r" (pcp32), [inv_mask] "r" (~mask),		\
+		  [new_field] "r" (new_field)				\
+		: "memory");						\
+									\
+	return (old & mask) >> shift;					\
+}
+
+__PERCPU_8_16_XCHG_CASE(8, .b)
+__PERCPU_8_16_XCHG_CASE(16, .h)
 #define _pcp_wrap(op, pcp, ...)						\
 ({									\
 	op(&(pcp), __VA_ARGS__);					\
@@ -338,6 +413,14 @@ __percpu_add_return_amo_case_16(void __percpu *pcp, unsigned long val)
 	(TYPEOF_UNQUAL(*__pcp_ptr))op(__pcp_ptr, ##args);		\
 })
 
+#define _pcp_wrap_xchg(op, pcp, val)					\
+({									\
+	__auto_type __pcp_ptr = &(pcp);					\
+									\
+	(TYPEOF_UNQUAL(*__pcp_ptr))op(__pcp_ptr,			\
+					     (unsigned long)(val));	\
+})
+
 #define this_cpu_read_1(pcp)	_pcp_wrap_return(__percpu_read_8, pcp)
 #define this_cpu_read_2(pcp)	_pcp_wrap_return(__percpu_read_16, pcp)
 #define this_cpu_read_4(pcp)	_pcp_wrap_return(__percpu_read_32, pcp)
@@ -390,9 +473,18 @@ __percpu_add_return_amo_case_16(void __percpu *pcp, unsigned long val)
 	_pcp_wrap_return(__percpu_add_return_amo_case_64, pcp, val)
 #endif
 
+#define this_cpu_xchg_1(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_8, pcp, val)
+#define this_cpu_xchg_2(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_16, pcp, val)
+#define this_cpu_xchg_4(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_32, pcp, val)
+#ifdef CONFIG_64BIT
+#define this_cpu_xchg_8(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_64, pcp, val)
+#endif
+
 #undef PERCPU_RW_OPS
 #undef __PERCPU_AMO_OP_CASE
 #undef __PERCPU_8_16_OP_CASE
+#undef __PERCPU_XCHG_AMO_CASE
+#undef __PERCPU_8_16_XCHG_CASE
 #undef PERCPU_8_16_GET_SHIFT
 #undef PERCPU_8_16_GET_MASK
 #undef PERCPU_8_16_GET_PCP32
-- 
2.39.5

