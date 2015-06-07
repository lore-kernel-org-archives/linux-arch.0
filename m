From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 10/19] ARC: entry.S: Trap handler to use r10 for syscall vs. brkpt decision
Date: Sun, 7 Jun 2015 14:08:14 +0530
Message-ID: <1433666303-26112-11-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37831 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932768AbbFGIju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:50 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 0a75f81e2853..b120f3e1e13e 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -505,8 +505,8 @@ ENTRY(EV_Trap)
 	EXCEPTION_PROLOGUE
 
 	;------- (4) What caused the Trap --------------
-	lr     r12, [ecr]
-	bmsk.f 0, r12, 7
+	lr     r10, [ecr]
+	bmsk.f 0, r10, 7
 	bnz    trap_with_param
 
 	; ======= (5a) Trap is due to System Call ========
-- 
1.9.1
