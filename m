From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] asm-generic/sembuf: Update architecture related information in comment
Date: Wed, 20 May 2020 15:53:08 +0530
Message-ID: <64efe033394b6f0dfef043a63fd8897a81ba6d16.1589970173.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETKXQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2020 06:23:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7DC061A0E
        for <linux-arch@vger.kernel.org>; Wed, 20 May 2020 03:23:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so1319650pfn.11
        for <linux-arch@vger.kernel.org>; Wed, 20 May 2020 03:23:16 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

The structure came originally from x86_32 but is used by most of the
architectures now. Update the comment which says it is for x86 only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/asm-generic/sembuf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 0e709bd3d730..f54e48fc91ae 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -6,9 +6,9 @@
 #include <asm/ipcbuf.h>
 
 /*
- * The semid64_ds structure for x86 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
+ * The semid64_ds structure for most architectures (though it came from x86_32
+ * originally). Note extra padding because this structure is passed back and
+ * forth between kernel and user space.
  *
  * semid64_ds was originally meant to be architecture specific, but
  * everyone just ended up making identical copies without specific
-- 
2.25.0.rc1.19.g042ed3e048af
