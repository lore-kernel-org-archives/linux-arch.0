From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 12/13] tracing: Replace some magic constants with sizeof()
Date: Wed, 14 Jun 2017 17:27:28 -0500
Message-ID: <20170614222729.16521-13-jeremy.linton@arm.com>
References: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614222729.16521-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz
List-Id: linux-arch.vger.kernel.org

Now that sizeof() works in TP_printk, lets replace a
few cases in the kernel where the element size is hardcoded
rather than using sizeof().

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/trace/events/thermal.h                 |  4 +++-
 include/trace/events/thermal_power_allocator.h |  4 ++--
 sound/firewire/motu/amdtp-motu-trace.h         | 12 ++++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 6cde5b3..fad25224 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -90,6 +90,8 @@ TRACE_EVENT(thermal_zone_trip,
 		show_tzt_type(__entry->trip_type))
 );
 
+TRACE_DEFINE_SIZEOF(u32);
+
 TRACE_EVENT(thermal_power_cpu_get_power,
 	TP_PROTO(const struct cpumask *cpus, unsigned long freq, u32 *load,
 		size_t load_len, u32 dynamic_power, u32 static_power),
@@ -118,7 +120,7 @@ TRACE_EVENT(thermal_power_cpu_get_power,
 
 	TP_printk("cpus=%s freq=%lu load={%s} dynamic_power=%d static_power=%d",
 		__get_bitmask(cpumask), __entry->freq,
-		__print_array(__get_dynamic_array(load), __entry->load_len, 4),
+		__print_array(__get_dynamic_array(load), __entry->load_len, sizeof(u32)),
 		__entry->dynamic_power, __entry->static_power)
 );
 
diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace/events/thermal_power_allocator.h
index 5afae8f..5f0ef92 100644
--- a/include/trace/events/thermal_power_allocator.h
+++ b/include/trace/events/thermal_power_allocator.h
@@ -45,10 +45,10 @@ TRACE_EVENT(thermal_power_allocator,
 	TP_printk("thermal_zone_id=%d req_power={%s} total_req_power=%u granted_power={%s} total_granted_power=%u power_range=%u max_allocatable_power=%u current_temperature=%d delta_temperature=%d",
 		__entry->tz_id,
 		__print_array(__get_dynamic_array(req_power),
-                              __entry->num_actors, 4),
+			      __entry->num_actors, sizeof(u32)),
 		__entry->total_req_power,
 		__print_array(__get_dynamic_array(granted_power),
-                              __entry->num_actors, 4),
+			      __entry->num_actors, sizeof(u32)),
 		__entry->total_granted_power, __entry->power_range,
 		__entry->max_allocatable_power, __entry->current_temp,
 		__entry->delta_temp)
diff --git a/sound/firewire/motu/amdtp-motu-trace.h b/sound/firewire/motu/amdtp-motu-trace.h
index cd0cbfa9..22babfa 100644
--- a/sound/firewire/motu/amdtp-motu-trace.h
+++ b/sound/firewire/motu/amdtp-motu-trace.h
@@ -18,6 +18,8 @@ static void copy_sph(u32 *frame, __be32 *buffer, unsigned int data_blocks,
 static void copy_message(u64 *frames, __be32 *buffer, unsigned int data_blocks,
 			 unsigned int data_block_quadlets);
 
+TRACE_DEFINE_SIZEOF(u32);
+
 TRACE_EVENT(in_data_block_sph,
 	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
 	TP_ARGS(s, data_blocks, buffer),
@@ -38,7 +40,7 @@ TRACE_EVENT(in_data_block_sph,
 		__entry->src,
 		__entry->dst,
 		__entry->data_blocks,
-		__print_array(__get_dynamic_array(tstamps), __entry->data_blocks, 4)
+		__print_array(__get_dynamic_array(tstamps), __entry->data_blocks, sizeof(u32))
 	)
 );
 
@@ -62,10 +64,12 @@ TRACE_EVENT(out_data_block_sph,
 		__entry->src,
 		__entry->dst,
 		__entry->data_blocks,
-		__print_array(__get_dynamic_array(tstamps), __entry->data_blocks, 4)
+		__print_array(__get_dynamic_array(tstamps), __entry->data_blocks, sizeof(u32))
 	)
 );
 
+TRACE_DEFINE_SIZEOF(u64);
+
 TRACE_EVENT(in_data_block_message,
 	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
 	TP_ARGS(s, data_blocks, buffer),
@@ -86,7 +90,7 @@ TRACE_EVENT(in_data_block_message,
 		__entry->src,
 		__entry->dst,
 		__entry->data_blocks,
-		__print_array(__get_dynamic_array(messages), __entry->data_blocks, 8)
+		__print_array(__get_dynamic_array(messages), __entry->data_blocks, sizeof(u64))
 	)
 );
 
@@ -110,7 +114,7 @@ TRACE_EVENT(out_data_block_message,
 		__entry->src,
 		__entry->dst,
 		__entry->data_blocks,
-		__print_array(__get_dynamic_array(messages), __entry->data_blocks, 8)
+		__print_array(__get_dynamic_array(messages), __entry->data_blocks, sizeof(u64))
 	)
 );
 
-- 
2.9.4
