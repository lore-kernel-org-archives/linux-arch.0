Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDE3EE1E2;
	Fri, 29 May 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072490; cv=none; b=JGR4dXzuYIpgwM91OlI5l8MGIEUq2dK4q3UcErFIk8LwTVLDAco5/Rp+inIdagwPp4dA2PH2p0aLohxFmEihxwrIh22VynGisB0YjH0j6P3Mo9l2YCrb9SJxXbZmWnP75Bm8GnpSa5kCD6o8aYVpbtgeD+9bgQS/0YLSDYEB3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072490; c=relaxed/simple;
	bh=VN8/a0WXtzv1qop11YkYAJ89INU4HTueEd34qRetO48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dToFOyBYb3Jy345DFabTjvgSlmlYyRI2d+OpBUvpBUjlTrwksMsWZXci6v8kPqHRFpjl9bKO8vspEpzCP61qh3yFOkTt3+J1TH0c50CaJ1akzqynz3xWBx32vVRKWHFu/3tCGctjYh0eoajG87TwtDNf1TBBHlyvBRaHFfz/IYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=m5fSKYAb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="m5fSKYAb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R4JTcNVSu0j7h5Ha9fe+aZclKI7tLU2gi4u42f9j99Y=; b=m5fSKYAbPwXMUu3X4JElCGVLc3
	heuvdO8lxMeOkeCUDdnoRu7zPsg7dQm3kqu+Cqkc3ei8dMHQ7qqa/XL1nB0qfqb82bubYp9tOJ9sb
	T/38Cer1Tm7Hhg36ciYLIqjS4s8coExTfc9KXPf918GSh5c3B3tX4QFLVAT1ym0eGiDZ0ptU7gt9A
	0h0YcIaVen/PxypG6y6FvHaPhHfsYAKaxgFxoXqvFt9sHNumHDk2yDrbPlrcCmSruQ9o4qMtLMTb9
	i4QOHTU9LlSmMQHoQUuZ4Bji4fU5xUEyKOZiV8Dm7BIEM80g/u0TG5dsvwDowYi6E1gLTMT8YMH1F
	07c0LLaw==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wT0AW-009wov-5J; Fri, 29 May 2026 18:34:44 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 29 May 2026 13:33:57 -0300
Subject: [PATCH v3 5/5] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-tonyk-robust_arm-v3-5-a6f02684d4fe@igalia.com>
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
In-Reply-To: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Based on aarch64 implementation, provide a 32 bit entry point for this vDSO.

In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
make sure to store the pop address at r2.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm64/kernel/vdso.c            |  9 +++++++++
 arch/arm64/kernel/vdso32/Makefile   |  2 +-
 arch/arm64/kernel/vdso32/vdso.lds.S |  5 +++++
 arch/arm64/kernel/vdso32/vfutex.c   | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 76f22ea8e181..3ce9d9d79431 100644
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
index 2775843e53cd..cc4248539bec 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -97,7 +97,7 @@ VDSO_LDFLAGS += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 munge := ../../../arm/vdso/vdsomunge
 hostprogs := $(munge)
 
-c-obj-vdso := note.o
+c-obj-vdso := note.o vfutex.o
 c-obj-vdso-gettimeofday := vgettimeofday.o
 
 ifneq ($(c-gettimeofday-y),)
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index c374fb0146f3..31e0a3770c32 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -87,6 +87,11 @@ VERSION
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
+		__vdso_futex_robust_list32_try_unlock;
 	local: *;
 	};
 }
+
+VDSO_futex_list32_try_unlock_cs_success = __futex_list32_try_unlock_cs_success;
+VDSO_futex_list32_try_unlock_cs_start = __futex_list32_try_unlock_cs_start;
+VDSO_futex_list32_try_unlock_cs_end = __futex_list32_try_unlock_cs_end;
diff --git a/arch/arm64/kernel/vdso32/vfutex.c b/arch/arm64/kernel/vdso32/vfutex.c
new file mode 100644
index 000000000000..a347da5ef47f
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
+	register __u32 *pop_reg asm("r2") = pop;
+	__u32 val, result, zero = 0;
+
+	asm volatile (
+		GLOBLS(32)
+		"retry:						\n"
+		"	ldrex %[val], %[lock]			\n"
+		"	cmp %[tid], %[val]			\n"
+		"	bne " LABEL(end, 32)"			\n"
+		"	strex %[result], %[zero], %[lock]	\n"
+		"	cmp %[result], #0			\n"
+		"	bne retry				\n"
+		LABEL(start, 32)":				\n"
+		LABEL(success, 32)":				\n"
+		"	str %[zero], %[pop_reg]			\n"
+		LABEL(end, 32)":				\n"
+		: [val] "=&r" (val), [result] "=r" (result)
+		: [tid] "r" (tid), [lock] "Q" (*lock), [pop_reg] "Q" (*pop_reg), [zero] "r" (zero)
+		: "memory"
+	);
+
+	return val;
+}

-- 
2.54.0

