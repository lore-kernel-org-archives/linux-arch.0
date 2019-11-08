Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38610 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHFDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so3250440plq.5
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:05 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v2 01/37] asm-generic: atomic64: allow using generic atomic64 on 64bit platforms
Date: Fri,  8 Nov 2019 14:02:16 +0900
Message-Id: <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
are not compiled due to type conflict of atomic64_t defined in
linux/type.h.

This commit fixes the issue and allow using generic atomic64 ops.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 include/asm-generic/atomic64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d4450f..9b15847baae5 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -9,9 +9,11 @@
 #define _ASM_GENERIC_ATOMIC64_H
 #include <linux/types.h>
 
+#ifndef CONFIG_64BIT
 typedef struct {
 	s64 counter;
 } atomic64_t;
+#endif
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-- 
2.20.1 (Apple Git-117)
