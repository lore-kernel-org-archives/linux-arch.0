Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77638DC75;
	Wed, 26 Aug 2026 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787720256; cv=none; b=aLdtZwnbnxWy6dZptq1epOfaYdHrHei72WG+egRVP/IyU/TxFEwTUeoRFZMv1gU8pMg80lH0oAkw+rmTJk5UmhbMWO21K8vM/V5hE/XIP0omDmi7eQbZj10+q8qaWh694DpPCFNSOkyw2374IH0fr6ed5bKll1RSJ4DXNAcSyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787720256; c=relaxed/simple;
	bh=EFmuGVPA/ZgsTxqWnscx8EraGCDS+TIqkuRmJNVonBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbplNeT/lq8HAeGDv5nBvcpY8NZI1TLMCPXVCa2QHfMF+tNDkwmON2bsLZwF1sK4Pbd1kr1WKLUXSTJoqaWloP5e8RdSMfLb4tgqx6OtUUqM5x5+h93Wj0hoYf8Zz9ZgF1nPQqJ/zVaYWET0k/YyNmzgZz2Pfj/3YDzQyeQpn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qck9ykgG; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qck9ykgG"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 459984C0B62;
	Wed, 26 Aug 2026 01:07:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (100-96-49-23.trex-nlb.outbound.svc.cluster.local [100.96.49.23])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5A7254C0BBC;
	Wed, 26 Aug 2026 01:07:53 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Illustrious: 4311d38559935212_1787706474061_3231139894
X-MC-Loop-Signature: 1787706474061:2906846316
X-MC-Ingress-Time: 1787706474060
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.49.23 (trex/8.0.2);
	Wed, 26 Aug 2026 01:07:54 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4hV62Z53fJz1V;
	Tue, 25 Aug 2026 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1787706473;
	bh=eMsnr23HP9lPV0KenSxGVhzn+g2nKrwYjINjwE+8ptg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=qck9ykgGD0FDGfMzf8lMjKxEz2+IBhaxPzncYO2JYJfqf03CmHex1/UlCDMf3GXeu
	 VBZ/D3+6NvU6kWUg4PUXEXnHXcMQpeEMv7muhjd1vcVORYpndgy/RedANS6aeWj1Hc
	 f6rLBX+goLntJYBBIQzXf3HnBpXEJOQaxYeBYo6ekiNBFNBAoIisqODuQSYnzeRFg+
	 mhM6EAjJlVen2M8PK8NxTfciUBwxLj2cYY8b3rUmn9mQfPjkBm3nQ10icYXGbTX07J
	 60k8ivrsNekvlJSNVkIE9VYGeAwYthFwpzuSvo1KhoCHJa0vcB6dUkFNAI+3H6yElh
	 LcL757Rqy4zxw==
Date: Tue, 25 Aug 2026 18:07:48 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org,
	thuth@redhat.com, ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk, rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com, zong.li@sifive.com,
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com,
	seanwascoding@gmail.com, andybnac@gmail.com,
	menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn, atishp@rivosinc.com,
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v8 2/3] riscv: introduce percpu.h into include/asm
Message-ID: <20260826010748.zphu3wh2hlm4t4o2@offworld>
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260703122832.15984-3-cuiyunhui@bytedance.com>
User-Agent: NeoMutt/20220429

On Fri, 03 Jul 2026, Yunhui Cui wrote:

>Add RISC-V specific this_cpu helpers so common percpu operations can use
>short architecture sequences instead of the generic implementation.
>Native-width operations use AMOs, while 8/16-bit operations use Zabha when
>available and a local 32-bit LR/SC fallback otherwise.

The subject and changelog could use some improvement. How about:

riscv: implement this_cpu operations

riscv has no asm/percpu.h, so every this_cpu_*() read-modify-write
takes the generic fallback, which disables local irqs.

A single AMO is atomic with respect to interrupts on the local hart,
so this can be replaced by one relaxed AMO under preemption disabled.
Native-width operations use AMOs, while 8/16-bit operations use Zabha when
available, or a local LR/SC sequence otherwise.

Some comments below, but I ran this on my sifive p550, feel free to add my:

Tested-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>---
> arch/riscv/include/asm/percpu.h | 296 ++++++++++++++++++++++++++++++++
> 1 file changed, 296 insertions(+)
> create mode 100644 arch/riscv/include/asm/percpu.h
>
>diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
>new file mode 100644
>index 0000000000000..76b1b8c1fb953
>--- /dev/null
>+++ b/arch/riscv/include/asm/percpu.h
>@@ -0,0 +1,296 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+
>+#ifndef __ASM_PERCPU_H
>+#define __ASM_PERCPU_H
>+
>+#include <linux/bits.h>
>+#include <linux/preempt.h>
>+
>+#include <asm/alternative-macros.h>
>+#include <asm/cmpxchg.h>
>+#include <asm/cpufeature-macros.h>
>+#include <asm/hwcap.h>
>+
>+#define PERCPU_RW_OPS(sz)						\
>+static inline unsigned long __percpu_read_##sz(void *ptr)		\
>+{									\
>+	return READ_ONCE(*(u##sz *)ptr);				\
>+}									\
>+									\
>+static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
>+{									\
>+	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
>+}
>+
>+PERCPU_RW_OPS(8)
>+PERCPU_RW_OPS(16)
>+PERCPU_RW_OPS(32)
>+
>+#ifdef CONFIG_64BIT
>+PERCPU_RW_OPS(64)
>+#endif
>+
>+#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\
>+static inline void							\
>+__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
>+{									\
>+	asm volatile (							\
>+		"amo" #amo_insn #sfx " zero, %[val], %[ptr]"		\

So afaict that rd=zero could steer the AMO away from the hart, no? From the
Zaamo chapter, it notes that complex implementations "might also implement
AMOs at memory controllers, and can optimize away fetching the original value
when the destination is x0". Similar for the others (PERCPU_8_16_OP).

Maybe use a tmp register instead and force the old value from L1 ("near"):

	u##sz tmp;
	asm volatile (
		"amo" #amo_insn #sfx " %[tmp], %[val], %[ptr]"
		: [ptr] "+A" (*(u##sz *)ptr), [tmp] "=r" (tmp)
		: [val] "r" ((u##sz)(val)));


... which arm64 now does for its pcpu ops:

	/*
	 * Use value-returning atomics for CPU-local ops as they are
	 * more likely to execute "near" to the CPU (e.g. in L1$).
	 *
	 * https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop
	 */

>+		: [ptr] "+A" (*(u##sz *)ptr)				\
>+		: [val] "r" ((u##sz)(val))				\
>+		: "memory");						\

Should not need this clobber either - these don't imply barriers (but you also get
them with the preemption disable/enable).

>+}
>+

...

>+#define this_cpu_cmpxchg_1(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)

This triggers that cmpxchg variable shadowing issue you mentioned in patch 1 with
that __cpu_fallback_try_cmpxchg also using '__old'.

>+#define this_cpu_cmpxchg_2(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>+#define this_cpu_cmpxchg_4(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>+
>+#ifdef CONFIG_64BIT
>+#define this_cpu_cmpxchg_8(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>+
>+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
>+#endif
>+
>+#ifdef system_has_cmpxchg128
>+#define this_cpu_cmpxchg128(pcp, o, n)					\
>+({									\
>+	u128 ret__;							\
>+	typeof(pcp) *ptr__;						\
>+									\
>+	preempt_disable_notrace();					\
>+	ptr__ = raw_cpu_ptr(&(pcp));					\
>+	if (system_has_cmpxchg128())					\
>+		ret__ = cmpxchg128_local(ptr__, (o), (n));		\
>+	else								\
>+		ret__ = this_cpu_generic_cmpxchg(pcp, (o), (n));	\
>+	preempt_enable_notrace();					\
>+	ret__;								\
>+})

With those above this_cpu_cmpxchg() you could now enable HAVE_CMPXCHG_LOCAL.

Thanks,
Davidlohr
