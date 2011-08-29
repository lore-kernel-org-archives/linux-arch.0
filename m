From: Eric B Munson <emunson@mgebm.net>
Subject: [PATCH 1/4] Add flag to indicate that a vm was stopped by the host
Date: Mon, 29 Aug 2011 17:27:12 -0600
Message-ID: <1314660435-23293-2-git-send-email-emunson@mgebm.net>
References: <1314660435-23293-1-git-send-email-emunson@mgebm.net>
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <1314660435-23293-1-git-send-email-emunson@mgebm.net>
Sender: kvm-ppc-owner@vger.kernel.org
To: avi@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, mtosatti@redhat.com, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm-ppc@vger.kernel.org, aliguori@us.ibm.com, raharper@us.ibm.com, kvm-ia64@vger.kernel.org, Eric B Munson <emunson@mgebm.net>
List-Id: linux-arch.vger.kernel.org

This flag will be used to check if the vm was stopped by the host when a soft
lockup was detected.

Signed-off-by: Eric B Munson <emunson@mgebm.net>
---
 arch/x86/include/asm/pvclock-abi.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/pvclock-abi.h b/arch/x86/include/asm/pvclock-abi.h
index 35f2d19..6167fd7 100644
--- a/arch/x86/include/asm/pvclock-abi.h
+++ b/arch/x86/include/asm/pvclock-abi.h
@@ -40,5 +40,6 @@ struct pvclock_wall_clock {
 } __attribute__((__packed__));
 
 #define PVCLOCK_TSC_STABLE_BIT	(1 << 0)
+#define PVCLOCK_GUEST_STOPPED	(1 << 1)
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_PVCLOCK_ABI_H */
-- 
1.7.4.1
