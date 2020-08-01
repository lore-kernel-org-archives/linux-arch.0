Return-Path: <SRS0=4doj=BL=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgHABOy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:54 -0400
From: guoren@kernel.org
Subject: [PATCH 09/13] csky: Set CONFIG_NR_CPU 4 as default
Date: Sat,  1 Aug 2020 01:14:09 +0000
Message-ID: <1596244453-98575-10-git-send-email-guoren@kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Message-ID: <20200801011409.HX4jbUgcc_rzd99Fqe2O2a2GvQzDOx0I6E4L5yrn9wA@z>

From: Guo Ren <guoren@linux.alibaba.com>

The C860 processors support 4 cores smp for maximum, so set NR_CPU
to 4 as default

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index fd92d73..ad98b93 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -279,7 +279,7 @@ config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
 	depends on SMP
-	default "2"
+	default "4"
 
 config HIGHMEM
 	bool "High Memory Support"
-- 
2.7.4
