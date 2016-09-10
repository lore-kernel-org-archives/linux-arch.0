From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH] percpu: make this_cpu_generic_read notrace
Date: Sat, 10 Sep 2016 16:45:34 +0800
Message-ID: <1473497134-27807-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33110 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbcIJIp6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2016 04:45:58 -0400
Received: by mail-pf0-f172.google.com with SMTP id g202so36942158pfb.0
        for <linux-arch@vger.kernel.org>; Sat, 10 Sep 2016 01:45:57 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, zhang.lyra@gmail.com

When debug preempt or preempt tracer is enabled, preempt_count_add/sub()
can be traced by function and function graph tracing, and
preempt_disable/enable() would call preempt_count_add/sub(), so
we should use preempt_disable/enable_notrace in Ftrace subsystem.

The function this_cpu_read() started being used by function graph tracing
after the commit 345ddcc882d8 ("ftrace: Have set_ftrace_pid use the
bitmap like events do"), so it has to use preempt_disable/enable_notrace
instead now.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 include/asm-generic/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 4d9f233..70fefec 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -108,9 +108,9 @@ do {									\
 #define this_cpu_generic_read(pcp)					\
 ({									\
 	typeof(pcp) __ret;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	__ret = *this_cpu_ptr(&(pcp));					\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	__ret;								\
 })
 
-- 
2.7.4
