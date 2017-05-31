Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdEaV5A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 May 2017 17:57:00 -0400
From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 10/12] tracing: Update sample file to describe the new macro
Date: Wed, 31 May 2017 16:56:51 -0500
Message-ID: <20170531215653.3240-11-jeremy.linton@arm.com>
In-Reply-To: <20170531215653.3240-1-jeremy.linton@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
Message-ID: <20170531215651.galERhq9T7vZNitW4HXavLlIREnTqh58H9T-OBR1Qj4@z>

Add a blurb in the trace sample file to describe
the macro used to add sizeof to value conversions.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 samples/trace_events/trace-events-sample.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 76a75ab..82e1e66 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -225,6 +225,13 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_FOO);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_BAR);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
 
+/*
+ * The same problem as above applies to sizeof(), so there is also
+ * a macro to solve that problem.
+ */
+
+TRACE_DEFINE_SIZEOF(pteval_t);
+
 TRACE_EVENT(foo_bar,
 
 	TP_PROTO(const char *foo, int bar, const int *lst,
-- 
2.9.4
