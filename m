Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37843 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbbGOPU2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2015 11:20:28 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/2] perf auxtrace: Fix misplaced check for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
Date: Wed, 15 Jul 2015 12:20:07 -0300
Message-ID: <1436973608-9271-2-git-send-email-acme@kernel.org>
In-Reply-To: <1436973608-9271-1-git-send-email-acme@kernel.org>
References: <1436973608-9271-1-git-send-email-acme@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Message-ID: <20150715152007.ObtD2kG5UWMFCQMX2cjh6ZpBcvfMhya2kLu-n6KXJtk@z>

From: Adrian Hunter <adrian.hunter@intel.com>

Move the checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT for AUX area mmaps
until after checking if such mmaps are used anyway.

Reported-by: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/55A5023C.7020907@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 7e7405c9b936..83d9dd96fe08 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -53,11 +53,6 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 {
 	struct perf_event_mmap_page *pc = userpg;
 
-#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pr_err("Cannot use AUX area tracing mmaps\n");
-	return -1;
-#endif
-
 	WARN_ONCE(mm->base, "Uninitialized auxtrace_mmap\n");
 
 	mm->userpg = userpg;
@@ -73,6 +68,11 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 		return 0;
 	}
 
+#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
+	pr_err("Cannot use AUX area tracing mmaps\n");
+	return -1;
+#endif
+
 	pc->aux_offset = mp->offset;
 	pc->aux_size = mp->len;
 
-- 
2.1.0

