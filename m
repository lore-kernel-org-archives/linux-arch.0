From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 01/26] asm-generic: atomic64: allow using generic atomic64 on 64bit platforms
Date: Wed,  5 Feb 2020 16:30:10 +0900
Message-ID: <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34535 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHar (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:30:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so538333pgi.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:30:45 -0800 (PST)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
are not compiled due to type conflict of atomic64_t defined in
linux/type.h.

This commit fixes the issue and allow using generic atomic64 ops.

Currently, LKL is only the user which defines GENERIC_ATOMIC64
(lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
issues before this commit.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
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
2.21.0 (Apple Git-122.2)
