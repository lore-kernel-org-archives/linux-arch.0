From: Richard Kuo <rkuo@codeaurora.org>
Subject: [PATCH 10/10] hexagon: add missing cpu.h include
Date: Thu, 12 Apr 2012 15:57:33 -0500
Message-ID: <6e201a$5e4iug@wolverine01.qualcomm.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/kernel/smp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0672463..1298141 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -1,7 +1,7 @@
 /*
  * SMP support for Hexagon
  *
- * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
+ * Copyright (c) 2010-2012, Code Aurora Forum. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -28,6 +28,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
+#include <linux/cpu.h>
 
 #include <asm/time.h>    /*  timer_interrupt  */
 #include <asm/hexagon_vm.h>
-- 
1.7.1


--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
