From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 08/12] tracing: Rename enum_replace to eval_replace
Date: Wed, 31 May 2017 16:56:49 -0500
Message-ID: <20170531215653.3240-9-jeremy.linton@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531215653.3240-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
List-Id: linux-arch.vger.kernel.org

The enum_replace stanza works as is for sizeof()
calls as well as enums. Rename it as well.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kernel/trace/trace_events.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e6897b0..83dfd0d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2067,12 +2067,12 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	return 0;
 }
 
-static char *enum_replace(char *ptr, struct trace_eval_map *map, int len)
+static char *eval_replace(char *ptr, struct trace_eval_map *map, int len)
 {
 	int rlen;
 	int elen;
 
-	/* Find the length of the enum value as a string */
+	/* Find the length of the eval value as a string */
 	elen = snprintf(ptr, 0, "%ld", map->eval_value);
 	/* Make sure there's enough room to replace the string with the value */
 	if (len < elen)
@@ -2127,14 +2127,14 @@ static void update_event_printk(struct trace_event_call *call,
 		if (isalpha(*ptr) || *ptr == '_') {
 			if (strncmp(map->eval_string, ptr, len) == 0 &&
 			    !isalnum(ptr[len]) && ptr[len] != '_') {
-				ptr = enum_replace(ptr, map, len);
-				/* Hmm, enum string smaller than value */
+				ptr = eval_replace(ptr, map, len);
+				/* enum/sizeof string smaller than value */
 				if (WARN_ON_ONCE(!ptr))
 					return;
 				/*
-				 * No need to decrement here, as enum_replace()
+				 * No need to decrement here, as eval_replace()
 				 * returns the pointer to the character passed
-				 * the enum, and two enums can not be placed
+				 * the eval, and two evals can not be placed
 				 * back to back without something in between.
 				 * We can skip that something in between.
 				 */
-- 
2.9.4
