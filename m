From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 04/40] trace/ring_buffer: handle 64bit aligned structs
Date: Wed, 31 Oct 2012 16:13:45 +0000
Message-ID: <1351700061-7203-5-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49761 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935778Ab2JaQOu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:14:50 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

Some 32 bit architectures have 64 bit struct alignment (for example
metag which has 64 bit read/write instructions). These require 8 byte
alignment of event data too, so use CONFIG_HAVE_64BIT_ALIGNED_STRUCT
instead of CONFIG_64BIT to decide alignment, and align
buffer_data_page::data accordingly.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/trace/ring_buffer.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 49491fa..15a63d8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -177,7 +177,8 @@ void tracing_off_permanent(void)
 #define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
 #define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */
 
-#if !defined(CONFIG_64BIT) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+#if !defined(CONFIG_HAVE_64BIT_ALIGNED_STRUCT) || \
+	defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
 # define RB_FORCE_8BYTE_ALIGNMENT	0
 # define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
 #else
@@ -185,6 +186,8 @@ void tracing_off_permanent(void)
 # define RB_ARCH_ALIGNMENT		8U
 #endif
 
+#define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)
+
 /* define RINGBUF_TYPE_DATA for 'case RINGBUF_TYPE_DATA:' */
 #define RINGBUF_TYPE_DATA 0 ... RINGBUF_TYPE_DATA_TYPE_LEN_MAX
 
@@ -333,7 +336,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 struct buffer_data_page {
 	u64		 time_stamp;	/* page time stamp */
 	local_t		 commit;	/* write committed index */
-	unsigned char	 data[];	/* data of buffer page */
+	unsigned char	 data[] RB_ALIGN_DATA;	/* data of buffer page */
 };
 
 /*
-- 
1.7.7.6
