Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from oz.csail.mit.edu ([128.30.30.239]:34645 "EHLO mail.mgebm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028Ab2AQSkq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Jan 2012 13:40:46 -0500
From: Eric B Munson <emunson@mgebm.net>
Subject: [PATCH 1/4 V10] Add flag to indicate that a vm was stopped by the host
Date: Tue, 17 Jan 2012 13:40:38 -0500
Message-ID: <1326825641-15765-2-git-send-email-emunson@mgebm.net>
In-Reply-To: <1326825641-15765-1-git-send-email-emunson@mgebm.net>
References: <1326825641-15765-1-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: avi@redhat.com
Cc: Eric B Munson <emunson@mgebm.net>, mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20120117184038.m9w76ZQ63OeXsGUdbkT7UtKJe4ZqIsqD54hZO4aiRj8@z>

This flag will be used to check if the vm was stopped by the host when a soft
lockup was detected.  The host will set the flag when it stops the guest.  On
resume, the guest will check this flag if a soft lockup is detected and skip
issuing the warning.

Signed-off-by: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: ryanh@linux.vnet.ibm.com
Cc: aliguori@us.ibm.com
Cc: mtosatti@redhat.com
Cc: jeremy.fitzhardinge@citrix.com
Cc: kvm@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
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

