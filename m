Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53760 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab2A0CpA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2012 21:45:00 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 7/7] kernel.h: doesn't explicitly use bug.h, so don't include it.
Date: Thu, 26 Jan 2012 21:44:32 -0500
Message-ID: <1327632272-12928-8-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1327632272-12928-1-git-send-email-paul.gortmaker@windriver.com>
References: <1327632272-12928-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org, gregkh@suse.de, rmk+kernel@arm.linux.org.uk
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <20120127024432.5CLLVgAofDTgrMHlJ3gxxfe25NrAhMWnyl08sXKKt9w@z>

This header isn't using bug.h infrastructure, but due to historical
reasons, it was including it.  Removing it revealed several implicit
dependencies (since kernel.h is everywhere) so we've fixed those 1st
before deploying this change.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/kernel.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5dba983..bef5480 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -20,7 +20,6 @@
 #include <linux/printk.h>
 #include <linux/dynamic_debug.h>
 #include <asm/byteorder.h>
-#include <asm/bug.h>
 
 #define USHRT_MAX	((u16)(~0U))
 #define SHRT_MAX	((s16)(USHRT_MAX>>1))
-- 
1.7.7.2

