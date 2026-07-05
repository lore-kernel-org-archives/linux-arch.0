Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3342F7EE5;
	Sun,  5 Jul 2026 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783274282; cv=none; b=oaF9DXPO3YwZc54n+6crmnaG6dg6X0TB5gQDkR3IqWk/Rv2zjcsl5kKC653tMm6S0mi2TZYP2xkM/FL/jCeF2Of89MuQs0NUvHG31dGTO6I38lOI6J0spzE/RTEsNzvEt19rh1LkQ1HggwbsuNpmKy4NGciLayc2wGLhnpZ6NRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783274282; c=relaxed/simple;
	bh=2nHJFss44j+jkIMHTgp/xSgozjeQLI7Xcn/nDjXQaOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qq4w36Kh3sgHWC2GC25rSl50rUW/6uFNsm0HBHcp/h/7UTi6EuHHCLs100GHohakQboRYQXLeFf9p/fm1zbhsn5/6RNcCw5zx1IlFn4DbYcmbohNQP505MqBqV2pYhFjUGFWUMPLD3yrQOLMB8ZhVAUn7mybFG2bH+0hltRPjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P4sl2gXT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P4sl2gXT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aswcegt+1Cm6dBIg32zh4PKIM04KfMMGt2+4p1IlwyM=; b=P4sl2gXTT3Vxmc5mwu7QKntIrs
	gThecBcrpJHbtX7VIAts/rgABcsGkS1HoVU2C1Bd3DRPiyyaweLOyvpMuTkMrMtinKE89g8Nb2RYw
	Ul4536TNUUcLje2R42X3jPny2hZNRGvOc5LNSHjYeb3qp87BWCR/ewcKiGhA3+VtOHtnVO7nnJxGn
	XePL9W5xmFW3nQquUhppnZKqR0A/+INLiFezfOzHQf8XEjbUkCh06aVWINS9JwBy/f2mz0wzK2Mim
	20OSaUxilDs4BeGjqhfqPVDBZe36XUnl340mZO4/n4TqxRSOI2LDVahDR1qK6FTEb2c6dY0SWvAyn
	T8ChdNsw==;
Received: from 201-69-111-23.dial-up.telesp.net.br ([201.69.111.23] helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wgR62-009PnY-SY; Sun, 05 Jul 2026 19:57:39 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 05 Jul 2026 14:56:55 -0300
Subject: [PATCH v4 5/5] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260705-tonyk-robust_arm-v4-5-e0fd0fa259d3@igalia.com>
References: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
In-Reply-To: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Based on aarch64 implementation, provide a 32 bit entry point for
this vDSO.

In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
make sure to store the pop address at r2 and the compare result value
at r3.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm64/kernel/vdso.c            |  9 +++++++++
 arch/arm64/kernel/vdso32/Makefile   |  4 ++++
 arch/arm64/kernel/vdso32/vdso.lds.S |  9 +++++++++
 arch/arm64/kernel/vdso32/vfutex.c   | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 283b38684ef7..e72a9f086999 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -71,6 +71,15 @@ static void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_str
 
 		futex_set_vdso_cs_range(fd, 0, success, end, false);
 	}
+
+#ifdef CONFIG_COMPAT_VDSO
+	if (abi == VDSO_ABI_AA32) {
+		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_success);
+		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end);
+
+		futex_set_vdso_cs_range(fd, 1, success, end, true);
+	}
+#endif
 }
 #else
 static inline void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm) { }
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 4bd60f059f4a..f3190125c68b 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -97,6 +97,10 @@ munge := ../../../arm/vdso/vdsomunge
 hostprogs := $(munge)
 
 c-obj-vdso := note.o
+ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+  c-obj-vdso += vfutex.o
+endif
+
 c-obj-vdso-gettimeofday := vgettimeofday.o
 
 ifneq ($(c-gettimeofday-y),)
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index c374fb0146f3..46c0123b2684 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -87,6 +87,15 @@ VERSION
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+		__vdso_futex_robust_list32_try_unlock;
+#endif
 	local: *;
 	};
 }
+
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+VDSO_futex_list32_try_unlock_cs_success = __futex_list32_try_unlock_cs_success;
+VDSO_futex_list32_try_unlock_cs_start = __futex_list32_try_unlock_cs_start;
+VDSO_futex_list32_try_unlock_cs_end = __futex_list32_try_unlock_cs_end;
+#endif
diff --git a/arch/arm64/kernel/vdso32/vfutex.c b/arch/arm64/kernel/vdso32/vfutex.c
new file mode 100644
index 000000000000..c47502bbe1d9
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vfutex.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/stringify.h>
+#include <vdso/futex.h>
+
+#define LABEL(name, sz) __stringify(__futex_list##sz##_try_unlock_cs_##name)
+
+#define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
+
+__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
+{
+	register __u32 *pop_reg asm("r2") = pop, result_reg asm("r3") = 0;
+	__u32 val, zero = 0;
+
+	asm volatile (
+		GLOBLS(32)
+		"retry:						\n"
+		"	ldrex %[val], %[lock]			\n"
+		"	cmp %[tid], %[val]			\n"
+		"	bne " LABEL(end, 32)"			\n"
+		"	strex %[result], %[zero], %[lock]	\n"
+		LABEL(start, 32)":				\n"
+		"	cmp %[result], #0			\n"
+		"	bne retry				\n"
+		LABEL(success, 32)":				\n"
+		"	str %[zero], %[pop_reg]			\n"
+		LABEL(end, 32)":				\n"
+		: [val] "=&r" (val), [result] "=r" (result_reg)
+		: [tid] "r" (tid), [lock] "Q" (*lock), [pop_reg] "Q" (*pop_reg), [zero] "r" (zero)
+		: "memory"
+	);
+
+	return val;
+}

-- 
2.54.0

