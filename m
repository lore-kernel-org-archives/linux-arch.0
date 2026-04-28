Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBF3FD134;
	Tue, 28 Apr 2026 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360848; cv=none; b=TeW+rToTMcnXCggEsF/QPh4IjJX5vJyo8P673Id1Cx5ZLuVRLa+LELOYdYDNgQcuSDeVoGeGYv0Nx/4/p8AfK+9hwgfEWTBQCROJWaITRn4d1sM6QdJx1PmSnkzsjY0VfQS4Q/NgxzUx9DMNL3lga7t17LnZKNX08/mQLJNKGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360848; c=relaxed/simple;
	bh=7MsMmKyp3iSGK9+D36e92qeu2YsEAXejP/EKxnkpBIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSZz/RYdoM8uymTnNJl9cbM7injhxrP+XVC/gaxdUMw7uOtqpTTJz/iPcRRP7mgwMP4jxkU27SckCdFpfitkgnd6ZPu6hNXcKi/grtLURFo2/QZyF50t5lh9jSxp5pWKPKVKKqlCQLSCvdpdYh52fr6dVaBGSeASizL0WEvOcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxzenHX_Bp4agEAA--.14031S3;
	Tue, 28 Apr 2026 15:20:39 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxjcK3X_BpkWV2AA--.26183S5;
	Tue, 28 Apr 2026 15:20:39 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] LoongArch: BPF: Inline bpf_get_smp_processor_id() helper
Date: Tue, 28 Apr 2026 15:20:21 +0800
Message-ID: <20260428072021.7289-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260428072021.7289-1-yangtiezhu@loongson.cn>
References: <20260428072021.7289-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxjcK3X_BpkWV2AA--.26183S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrykWw4UurW7JFW8ZF1xXrc_yoW8Kw4fpF
	45CrsIkr4DWa4FqrWxJr4kZryYqws5Wry3GFyYgayak3Z7Zry5tr1fKw1aqFn5Ar409a48
	Z390kwsYkF4UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUUU

The pointer to thread_info is always available in the $tp register,
the call to bpf_get_smp_processor_id() can be inlined into a single
load instruction.

(1) Here is the sample test.c:

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  SEC("raw_tp/sys_enter")
  int test_cpuid(void *ctx)
  {
	  return bpf_get_smp_processor_id();
  }
  char _license[] SEC("license") = "GPL";

(2) Here are the test steps:

  sudo yum install libbpf-devel kernel-devel bpftool
  clang -target bpf -O2 -c test.c -o test.o
  sudo sysctl -w net.core.bpf_jit_enable=1
  sudo bpftool prog show name test_cpuid
  sudo rm -f /sys/fs/bpf/test_cpuid
  sudo bpftool prog load test.o /sys/fs/bpf/test_cpuid
  ID=$(sudo bpftool prog show pinned /sys/fs/bpf/test_cpuid | grep -oE '^[0-9]+')
  sudo bpftool prog dump jited id $ID

(3) Here are the test results:

Before: 6 instructions

  ...
  64:	lu12i.w	$t1, 1213
  68:	ori	$t1, $t1, 1680
  6c:	lu32i.d	$t1, 0
  70:	lu52i.d	$t1, $t1, -1792
  74:	jirl	$ra, $t1, 0
  78:	move	$a5, $a0
  ...

After: 1 instruction

  ...
  64:	ld.w	$a5, $tp, 8
  ...

This is similar with commit 2ddec2c80b44 ("riscv, bpf: inline
bpf_get_smp_processor_id()").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index b93b67d22c26..b1c6194c4099 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
 #include <linux/memory.h>
+#include <asm/asm-offsets.h>
 #include "bpf_jit.h"
 
 #define LOONGARCH_MAX_REG_ARGS 8
@@ -1154,6 +1155,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			break;
 		}
 
+		/* Implement helper call to bpf_get_smp_processor_id() inline */
+		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
+			emit_insn(ctx, ldw, regmap[BPF_REG_0], LOONGARCH_GPR_TP, TI_CPU);
+			break;
+		}
+
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
@@ -2380,6 +2387,7 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 	switch (imm) {
 	case BPF_FUNC_get_current_task:
 	case BPF_FUNC_get_current_task_btf:
+	case BPF_FUNC_get_smp_processor_id:
 		return true;
 	default:
 		return false;
-- 
2.42.0

