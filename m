Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from oz.csail.mit.edu ([128.30.30.239]:57238 "EHLO
	ozymandias.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752853Ab1JYT0X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2011 15:26:23 -0400
From: Eric B Munson <emunson@mgebm.net>
Subject: [PATCH 4/6] Add generic stubs for kvm stop check functions
Date: Tue, 25 Oct 2011 15:26:17 -0400
Message-ID: <1319570779-8907-5-git-send-email-emunson@mgebm.net>
In-Reply-To: <1319570779-8907-1-git-send-email-emunson@mgebm.net>
References: <1319570779-8907-1-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: avi@redhat.com
Cc: mingo@redhat.com, x86@kernel.org, hpa@zytor.com, mtosatti@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, Eric B Munson <emunson@mgebm.net>
Message-ID: <20111025192617.aC4y8ocRWsZ0kmLg2bJ0AyCO8bcPcbACyDfSsRlnmwk@z>

Signed-off-by: Eric B Munson <emunson@mgebm.net>
---
 include/asm-generic/pvclock.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-generic/pvclock.h

diff --git a/include/asm-generic/pvclock.h b/include/asm-generic/pvclock.h
new file mode 100644
index 0000000..b42a8eb
--- /dev/null
+++ b/include/asm-generic/pvclock.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_GENERIC_PVCLOCK_H
+#define _ASM_GENERIC_PVCLOCK_H
+
+
+/*
+ * These functions are used by architectures that support kvm to avoid issuing
+ * false soft lockup messages.
+ */
+static inline bool kvm_check_and_clear_host_stopped(int cpu)
+{
+	return false;
+}
+
+static inline void kvm_clear_guest_paused(struct kvm_vcpu *vcpu)
+{
+	return;
+}
+
+#endif
-- 
1.7.5.4

