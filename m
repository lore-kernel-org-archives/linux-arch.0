From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 07/11] pm_runtime.h: explicitly requires notifier.h
Date: Thu, 28 Jul 2011 01:16:14 -0400
Message-ID: <1311830178-30314-8-git-send-email-paul.gortmaker@windriver.com>
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@elte.hu, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This file was getting notifier.h via device.h --> module.h but
the module.h inclusion is going away, so add notifier.h directly.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/pm_runtime.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index daac05d..19d6a72 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -10,6 +10,7 @@
 #define _LINUX_PM_RUNTIME_H
 
 #include <linux/device.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 
 #include <linux/jiffies.h>
-- 
1.7.6
