From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 10/13] tracing: Update sample file to describe the new macro
Date: Wed, 14 Jun 2017 17:27:26 -0500
Message-ID: <20170614222729.16521-11-jeremy.linton@arm.com>
References: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614222729.16521-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz
List-Id: linux-arch.vger.kernel.org

Add a blurb in the trace sample file to describe
the macro used to add sizeof to value conversions.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 samples/trace_events/trace-events-sample.h | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 76a75ab..a7431d4 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -225,26 +225,36 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_FOO);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_BAR);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
 
+/*
+ * The same problem as above applies to sizeof(), so there is also
+ * a macro to solve that problem. In the case show below foo_bar/format
+ * contains a string "__print_array(...,sizeof(phys_addr_t))" for which
+ * the sizeof() result varies depending on the kernel. Adding the following
+ * macro decodes the size before transferring it to userspace.
+ */
+
+TRACE_DEFINE_SIZEOF(phys_addr_t);
+
 TRACE_EVENT(foo_bar,
 
-	TP_PROTO(const char *foo, int bar, const int *lst,
+	TP_PROTO(const char *foo, int bar, const phys_addr_t *lst,
 		 const char *string, const struct cpumask *mask),
 
 	TP_ARGS(foo, bar, lst, string, mask),
 
 	TP_STRUCT__entry(
-		__array(	char,	foo,    10		)
-		__field(	int,	bar			)
-		__dynamic_array(int,	list,   __length_of(lst))
-		__string(	str,	string			)
-		__bitmask(	cpus,	num_possible_cpus()	)
+		__array(	char,	     foo,    10			)
+		__field(	int,	     bar			)
+		__dynamic_array(phys_addr_t, list,   __length_of(lst)	)
+		__string(	str,	     string			)
+		__bitmask(	cpus,	     num_possible_cpus()	)
 	),
 
 	TP_fast_assign(
 		strlcpy(__entry->foo, foo, 10);
 		__entry->bar	= bar;
 		memcpy(__get_dynamic_array(list), lst,
-		       __length_of(lst) * sizeof(int));
+		       __length_of(lst) * sizeof(phys_addr_t));
 		__assign_str(str, string);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
 	),
@@ -291,8 +301,8 @@ TRACE_EVENT(foo_bar,
  *    This prints out the array that is defined by __array in a nice format.
  */
 		  __print_array(__get_dynamic_array(list),
-				__get_dynamic_array_len(list) / sizeof(int),
-				sizeof(int)),
+				__get_dynamic_array_len(list) / sizeof(phys_addr_t),
+				sizeof(phys_addr_t)),
 		  __get_str(str), __get_bitmask(cpus))
 );
 
-- 
2.9.4
