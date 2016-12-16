Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:63515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760727AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/13] arm/arm64: xen: avoid gcc-4.4 warning
Date: Fri, 16 Dec 2016 11:56:29 +0100
Message-ID: <20161216105634.235457-9-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105629.zvkWTvx3p4h61jHUWMx3wESzGEQiFOq0s_RB3KvLocI@z>

Ancient gcc doesn't know about __builtin_unreachable(), causing
lots of instances of a harmless warning:

include/xen/arm/page.h: In function 'arbitrary_virt_to_machine':
include/xen/arm/page.h:85: warning: no return statement in function returning non-void

Adding a return statement doesn't change the behavior here, but
shuts up that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/xen/arm/page.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/xen/arm/page.h b/include/xen/arm/page.h
index 415dbc6e43fd..2485013e3c6f 100644
--- a/include/xen/arm/page.h
+++ b/include/xen/arm/page.h
@@ -82,6 +82,7 @@ static inline unsigned long bfn_to_pfn(unsigned long bfn)
 static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
 {
 	BUG();
+	return XMADDR(0);
 }
 
 /* TODO: this shouldn't be here but it is because the frontend drivers
-- 
2.9.0

