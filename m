Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:40482 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbbAFN6r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jan 2015 08:58:47 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 2/5] perf tools: [uclibc] Elide strlcpy warning
Date: Tue, 6 Jan 2015 19:22:12 +0530
Message-ID: <1420552335-26886-3-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1420552335-26886-1-git-send-email-vgupta@synopsys.com>
References: <1420552335-26886-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: acme@redhat.com, peterz@infradead.org
Cc: jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, bp@suse.de, linux-arch@vger.kernel.org, Alexey.Brodkin@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20150106135212.Vlcje2HZLmucbkae6biEgvZnQJ3KJDEMQp8A_v9Hyg4@z>

----------------->8------------------
  CC       bench/sched-pipe.o
In file included from builtin-annotate.c:13:0:
util/cache.h:76:15: warning: redundant redeclaration of 'strlcpy'
[-Wredundant-decls]
 extern size_t strlcpy(char *dest, const char *src, size_t size);
               ^
In file included from util/util.h:55:0,
                 from builtin.h:4,
                 from builtin-annotate.c:8:
~/vineetg/arc/gnu/INSTALL_1412-arc-2014.12-rc1/arc-snps-linux-uclibc/sysroot/usr/include/string.h:396:15:
note: previous declaration of 'strlcpy' was here
 extern size_t strlcpy(char *__restrict dst, const char *__restrict src,
----------------->8------------------

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 tools/perf/util/cache.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
index 5cf9e1b5989d..d04d770d90f6 100644
--- a/tools/perf/util/cache.h
+++ b/tools/perf/util/cache.h
@@ -71,7 +71,9 @@ extern char *perf_path(const char *fmt, ...) __attribute__((format (printf, 1, 2
 extern char *perf_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
+#ifndef __UCLIBC__
 /* Matches the libc/libbsd function attribute so we declare this unconditionally: */
 extern size_t strlcpy(char *dest, const char *src, size_t size);
+#endif
 
 #endif /* __PERF_CACHE_H */
-- 
1.9.1

