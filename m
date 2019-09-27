From: guoren@kernel.org
Subject: [PATCH] csky: Fixup csky_pmu.max_period assignment
Date: Fri, 27 Sep 2019 11:02:59 +0800
Message-ID: <1569553379-11327-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, Mao Han <han_mao@c-sky.com>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

The csky_pmu.max_period has type u64, and BIT() can only return
32 bits unsigned long on C-SKY. The initialization for max_period
will be incorrect when count_width is bigger than 32.

Use BIG_ULL()

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 4c1a193..7570109 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1306,7 +1306,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 				 &csky_pmu.count_width)) {
 		csky_pmu.count_width = DEFAULT_COUNT_WIDTH;
 	}
-	csky_pmu.max_period = BIT(csky_pmu.count_width) - 1;
+	csky_pmu.max_period = BIT_ULL(csky_pmu.count_width) - 1;
 
 	csky_pmu.plat_device = pdev;
 
-- 
2.7.4
