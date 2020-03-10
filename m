Return-Path: <SRS0=UTne=45=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50517 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbgCLI65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 04:58:57 -0400
From: Ma Jun <majun258@linux.alibaba.com>
Subject: [PATCH]arch/csky:Enable the gcov function in csky achitecture
Date: Tue, 10 Mar 2020 23:32:56 +0800
Message-ID: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: majun258@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Message-ID: <20200310153256.HtmqI7w4WmTCm3TKLluxS-zVb7Ognv25QAcYdaMoWIk@z>

Support the gcov function in csky architecture

Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
---
 arch/csky/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 047427f..9c4749d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -64,6 +64,7 @@ config CSKY
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
 	select PCI_MSI if PCI
+	select ARCH_HAS_GCOV_PROFILE_ALL
 
 config CPU_HAS_CACHEV2
 	bool
-- 
1.8.3.1
