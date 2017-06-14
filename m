From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 09/13] tracing: define TRACE_DEFINE_SIZEOF() macro to map sizeof's to their values
Date: Wed, 14 Jun 2017 17:27:25 -0500
Message-ID: <20170614222729.16521-10-jeremy.linton@arm.com>
References: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752712AbdFNW1l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 18:27:41 -0400
In-Reply-To: <20170614222729.16521-1-jeremy.linton@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz

Perf has a problem that if sizeof() macros are used within TRACE_EVENT()
macro's they end up in userspace as "sizeof(kernel structure)" which
cannot properly be parsed. Add a macro which can forward this data
through the eval_map for userspace utilization.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/linux/tracepoint.h   |  1 +
 include/trace/trace_events.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index f7b0f55..a26ffbe 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -88,6 +88,7 @@ extern void syscall_unregfunc(void);
 #define PARAMS(args...) args
 
 #define TRACE_DEFINE_ENUM(x)
+#define TRACE_DEFINE_SIZEOF(x)
 
 #endif /* _LINUX_TRACEPOINT_H */
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 49cce5f..3976fa1 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -46,6 +46,19 @@ TRACE_MAKE_SYSTEM_STR();
 	__attribute__((section("_ftrace_eval_map")))	\
 	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
 
+#undef TRACE_DEFINE_SIZEOF
+#define TRACE_DEFINE_SIZEOF(a)				\
+	static struct trace_eval_map __used __initdata	\
+	__##TRACE_SYSTEM##_##a =			\
+	{						\
+		.system = TRACE_SYSTEM_STRING,		\
+		.eval_string = "sizeof(" #a ")",	\
+		.eval_value = sizeof(a)			\
+	};						\
+	static struct trace_eval_map __used		\
+	__attribute__((section("_ftrace_eval_map")))	\
+	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
+
 /*
  * DECLARE_EVENT_CLASS can be used to add a generic function
  * handlers for events. That is, if all events have the same
@@ -158,6 +171,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef TRACE_DEFINE_ENUM
 #define TRACE_DEFINE_ENUM(a)
 
+#undef TRACE_DEFINE_SIZEOF
+#define TRACE_DEFINE_SIZEOF(a)
+
 #undef __field
 #define __field(type, item)
 
-- 
2.9.4
