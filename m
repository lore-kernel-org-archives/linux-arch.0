Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136849476;
	Sun, 25 Jan 2026 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769323200; cv=none; b=Qu46DO0ITkgIg9VMf5uGP3wRqIBGlTsrZLl1eKe0vhGRs9FdN6cAGXgmHYDrL+shTjosYlrumprouj2p865/lGyM6qztGASbEUFJrvG1GVdCHt2Th7e09PVyM1auC5prO1A7GwPrT0GqGMoVcdH9Zu1JcM0gjrcxFP0ZL+zcHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769323200; c=relaxed/simple;
	bh=ADeHaXDK0thOJ05SkfkUfNIBfmE8Eht9dXL468PyMvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqNYlhmtw9ErDt5fxu+pNNUXaZiK5PsSJOuTY/wiZktKHOPF9HdCYLd1vxlJfKoqK9Ip8zxnlkeRJllomaG9Jb6uWRB+cRVtYZCmxpEix8TFmfo7U9vpqJHZ4bdPzBo5j6xVOpuOQwrKrJhri3NZJWJKgqF01H5YfSVEeCXNjv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBCwEPdf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBCwEPdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409D2C4CEF1;
	Sun, 25 Jan 2026 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769323199;
	bh=ADeHaXDK0thOJ05SkfkUfNIBfmE8Eht9dXL468PyMvY=;
	h=From:To:Cc:Subject:Date:From;
	b=gBCwEPdfSAAVLxPoFTySU+IJVpeBOK1ZG1tJMNNeTdNCpQEPD1qy7Rz/HbJL4QSVo
	 PL8PtDJH3ALWxojCdwq/CSjWZS2ax//P00CpIQnaNjin5i1JAPWrS/dFK8R74QVdJo
	 Ee49zv5nkJJP67f8vYoTmOtPn8djEmkti8L2J/jvsoTSUSa7K3FYo1d6l5K97gRBXi
	 4Z9ZK9sz+SNcrMLj3QOkCbc1TqAYwEgxktsZbjF2KcQAuacVkAff4p9r8J879UzYOr
	 UKnFjLfGcWag4yww/wjkrJU2OR6QmkCJDIBsmSlqg3QrCnPHXxZckZO72+VWKxaD5b
	 /fib0MdMC84Jw==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	alex@ghiti.fr,
	leobras@redhat.com,
	djordje.todorovic@htecgroup.com,
	aleksa.paunovic@htecgroup.com,
	arnd@arndb.de,
	rabenda.cn@gmail.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <me@ziyao.cc>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH V3] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Date: Sun, 25 Jan 2026 01:39:41 -0500
Message-Id: <20260125063941.443777-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

The early version of XuanTie C910 core has a store merge buffer
delay problem. The store merge buffer could improve the store queue
performance by merging multi-store requests, but when there are not
continued store requests, the prior single store request would be
waiting in the store queue for a long time. That would cause
significant problems for communication between multi-cores. This
problem was found on sg2042 & th1520 platforms with the qspinlock
lock torture test.

So appending a fence w.o could immediately flush the store merge
buffer and let other cores see the write result.

This will apply the WRITE_ONCE errata to handle the non-standard
behavior via appending a fence w.o instruction for WRITE_ONCE().

This problem is only observed on the sg2042 hardware platform by
running the lock_torture test program for half an hour. The problem
was not found in the user space application, because interrupt can
break the livelock.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
Cc: Yao Zi <me@ziyao.cc>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
Changelog

v3:
 - Rebase on 6.19-rc6.
 - Remove errata_list_vendors patch which has been merged.
 - Add Tested-by tag.

v2:
https://lore.kernel.org/linux-riscv/20250713155321.2064856-1-guoren@kernel.org/
 - Add new header file for errata_list_vendors.
 - Rebase newest kernel version.

v1:
https://lore.kernel.org/all/20241214143039.4139398-1-guoren@kernel.org/
---
 arch/riscv/Kconfig.errata                    | 17 ++++++++++
 arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
 arch/riscv/include/asm/errata_list_vendors.h |  3 +-
 arch/riscv/include/asm/rwonce.h              | 34 ++++++++++++++++++++
 include/asm-generic/rwonce.h                 |  2 ++
 5 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/rwonce.h

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 3c945d086c7d..4d3f13522da6 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -154,4 +154,21 @@ config ERRATA_THEAD_GHOSTWRITE
 
 	  If you don't know what to do here, say "Y".
 
+config ERRATA_THEAD_WRITE_ONCE
+	bool "Apply T-Head WRITE_ONCE errata"
+	depends on ERRATA_THEAD
+	default y
+	help
+	  The early version of T-Head C9xx cores of sg2042 & th1520 have a store
+	  merge buffer delay problem. The store merge buffer could improve the
+	  store queue performance by merging multi-store requests, but when there
+	  are no continued store requests, the prior single store request would be
+	  waiting in the store queue for a long time. That would cause signifi-
+	  cant problems for communication between multi-cores. Appending a
+	  fence w.o could immediately flush the store merge buffer and let other
+	  cores see the write result.
+
+	  This will apply the WRITE_ONCE errata to handle the non-standard beh-
+	  avior via appending a fence w.o instruction for WRITE_ONCE().
+
 endmenu # "CPU errata selection"
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 0b942183f708..fbe46f2fa8fb 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -168,6 +168,23 @@ static bool errata_probe_ghostwrite(unsigned int stage,
 	return true;
 }
 
+static bool errata_probe_write_once(unsigned int stage,
+				    unsigned long arch_id, unsigned long impid)
+{
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
+		return false;
+
+	/* target-c9xx cores report arch_id and impid as 0 */
+	if (arch_id != 0 || impid != 0)
+		return false;
+
+	if (stage == RISCV_ALTERNATIVES_BOOT ||
+	    stage == RISCV_ALTERNATIVES_MODULE)
+		return true;
+
+	return false;
+}
+
 static u32 thead_errata_probe(unsigned int stage,
 			      unsigned long archid, unsigned long impid)
 {
@@ -183,6 +200,9 @@ static u32 thead_errata_probe(unsigned int stage,
 
 	errata_probe_ghostwrite(stage, archid, impid);
 
+	if (errata_probe_write_once(stage, archid, impid))
+		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
+
 	return cpu_req_errata;
 }
 
diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/include/asm/errata_list_vendors.h
index ec7eba373437..8fd7c36307e2 100644
--- a/arch/riscv/include/asm/errata_list_vendors.h
+++ b/arch/riscv/include/asm/errata_list_vendors.h
@@ -18,7 +18,8 @@
 #define	ERRATA_THEAD_MAE 0
 #define	ERRATA_THEAD_PMU 1
 #define	ERRATA_THEAD_GHOSTWRITE 2
-#define	ERRATA_THEAD_NUMBER 3
+#define	ERRATA_THEAD_WRITE_ONCE 3
+#define	ERRATA_THEAD_NUMBER 4
 #endif
 
 #ifdef CONFIG_ERRATA_MIPS
diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/rwonce.h
new file mode 100644
index 000000000000..081793d4d772
--- /dev/null
+++ b/arch/riscv/include/asm/rwonce.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_RWONCE_H
+#define __ASM_RWONCE_H
+
+#include <linux/compiler_types.h>
+#include <asm/alternative-macros.h>
+#include <asm/vendorid_list.h>
+#include <asm/errata_list_vendors.h>
+
+#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE)
+
+#define write_once_fence()				\
+do {							\
+	asm volatile(ALTERNATIVE(			\
+		"nop",					\
+		"fence w, o",				\
+		THEAD_VENDOR_ID,			\
+		ERRATA_THEAD_WRITE_ONCE,		\
+		CONFIG_ERRATA_THEAD_WRITE_ONCE)		\
+		: : : "memory");			\
+} while (0)
+
+#define __WRITE_ONCE(x, val)				\
+do {							\
+	*(volatile typeof(x) *)&(x) = (val);		\
+	write_once_fence();				\
+} while (0)
+
+#endif /* defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE) */
+
+#include <asm-generic/rwonce.h>
+
+#endif	/* __ASM_RWONCE_H */
diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 52b969c7cef9..4e2d941f15a1 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -50,10 +50,12 @@
 	__READ_ONCE(x);							\
 })
 
+#ifndef __WRITE_ONCE
 #define __WRITE_ONCE(x, val)						\
 do {									\
 	*(volatile typeof(x) *)&(x) = (val);				\
 } while (0)
+#endif
 
 #define WRITE_ONCE(x, val)						\
 do {									\
-- 
2.40.1

