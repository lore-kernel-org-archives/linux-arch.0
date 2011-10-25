From: Eric B Munson <emunson@mgebm.net>
Subject: [PATCH 4/6] Add generic stubs for kvm stop check functions
Date: Tue, 25 Oct 2011 15:26:17 -0400
Message-ID: <1319570779-8907-5-git-send-email-emunson@mgebm.net>
References: <1319570779-8907-1-git-send-email-emunson@mgebm.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319570779-8907-1-git-send-email-emunson@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: avi@redhat.com
Cc: mingo@redhat.com, x86@kernel.org, hpa@zytor.com, mtosatti@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, Eric B Munson <emunson@mgebm.net>
List-Id: linux-arch.vger.kernel.org

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
