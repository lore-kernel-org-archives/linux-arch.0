Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57169 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2BTAMF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:12:05 -0500
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 07/30] compat: Introduce COMPAT_USE_64BIT_TIME
Date: Sun, 19 Feb 2012 16:07:45 -0800
Message-ID: <1329696488-16970-8-git-send-email-hpa@zytor.com>
In-Reply-To: <1329696488-16970-1-git-send-email-hpa@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com
Message-ID: <20120220000745.oDjIwcDeHbAnXTRUtWOUAMK1XaLbhUiD38UC4bHgfeE@z>

From: "H. J. Lu" <hjl.tools@gmail.com>

Allow a compatibility ABI to use a 64-bit time_t and 64-bit members in
struct timeval and struct timespec to avoid the Y2038 problem.

This will be used for the x32 ABI.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 include/linux/compat.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 41c9f65..1be91c0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -19,6 +19,10 @@
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
+#ifndef COMPAT_USE_64BIT_TIME
+#define COMPAT_USE_64BIT_TIME 0
+#endif
+
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
-- 
1.7.6.5

