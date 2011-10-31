From: Eric B Munson <emunson@mgebm.net>
Subject: [PATCH 1/6 V2] Add flag to indicate that a vm was stopped by the host
Date: Mon, 31 Oct 2011 16:07:25 -0400
Message-ID: <1320091650-24682-2-git-send-email-emunson@mgebm.net>
References: <1320091650-24682-1-git-send-email-emunson@mgebm.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320091650-24682-1-git-send-email-emunson@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: avi@redhat.com
Cc: mingo@redhat.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, Eric B Munson <emunson@mgebm.net>
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
1.7.5.4
