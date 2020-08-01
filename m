From: guoren@kernel.org
Subject: [PATCH 09/13] csky: Set CONFIG_NR_CPU 4 as default
Date: Sat,  1 Aug 2020 01:14:09 +0000
Message-ID: <1596244453-98575-10-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
List-Id: linux-arch.vger.kernel.org

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
