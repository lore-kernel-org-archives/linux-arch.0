From: monstr@seznam.cz
Subject: [PATCH 14/60] microblaze_v4: lmb support
Date: Thu, 26 Jun 2008 14:29:43 +0200
Message-ID: <1214483429-32360-15-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
 <1214483429-32360-2-git-send-email-monstr@seznam.cz>
 <1214483429-32360-3-git-send-email-monstr@seznam.cz>
 <1214483429-32360-4-git-send-email-monstr@seznam.cz>
 <1214483429-32360-5-git-send-email-monstr@seznam.cz>
 <1214483429-32360-6-git-send-email-monstr@seznam.cz>
 <1214483429-32360-7-git-send-email-monstr@seznam.cz>
 <1214483429-32360-8-git-send-email-monstr@seznam.cz>
 <1214483429-32360-9-git-send-email-monstr@seznam.cz>
 <1214483429-32360-10-git-send-email-monstr@seznam.cz>
 <1214483429-32360-11-git-send-email-monstr@seznam.cz>
 <1214483429-32360-12-git-send-email-monstr@seznam.cz>
 <1214483429-32360-13-git-send-email-monstr@seznam.cz>
 <1214483429-32360-14-git-send-email-monstr@seznam.cz>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 238.225.broadband7.iol.cz ([88.102.225.238]:20659 "EHLO
	monstr.eu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757963AbYFZMhM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2008 08:37:12 -0400
In-Reply-To: <1214483429-32360-14-git-send-email-monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 include/asm-microblaze/lmb.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/lmb.h

diff --git a/include/asm-microblaze/lmb.h b/include/asm-microblaze/lmb.h
new file mode 100644
index 0000000..a0a0a92
--- /dev/null
+++ b/include/asm-microblaze/lmb.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2008 Michal Simek <monstr@monstr.eu>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_LMB_H
+#define _ASM_MICROBLAZE_LMB_H
+
+/* LMB limit is OFF */
+#define LMB_REAL_LIMIT	0xFFFFFFFF
+
+#endif /* _ASM_MICROBLAZE_LMB_H */
+
+
-- 
1.5.4.GIT
