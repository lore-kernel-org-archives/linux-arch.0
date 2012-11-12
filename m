Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:51561 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2KLLwJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 06:52:09 -0500
From: <Vineet.Gupta1@synopsys.com>
Subject: [RFC Patch v1 49/55] perf, ARC: Enable building perf tools for ARC
Date: Mon, 12 Nov 2012 17:19:07 +0530
Message-ID: <1352720953-24321-19-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1352720953-24321-1-git-send-email-vgupta@synopsys.com>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, arnd@arndb.de, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20121112114907.1f3q-VFXtjsU3qgmV9BG7mbk4Y2cfla8ml6HC3hdO50@z>

From: Vineet Gupta <vgupta@synopsys.com>

Although with uClibc there's more we need to do

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 tools/perf/perf.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index c50985e..1006b17 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -107,6 +107,12 @@ void get_term_dimensions(struct winsize *ws);
 #define CPUINFO_PROC	"cpu model"
 #endif
 
+#ifdef __arc__
+#define rmb()		asm volatile("" ::: "memory")
+#define cpu_relax()	rmb()
+#define CPUINFO_PROC	"Processor"
+#endif
+
 #include <time.h>
 #include <unistd.h>
 #include <sys/types.h>
-- 
1.7.4.1

