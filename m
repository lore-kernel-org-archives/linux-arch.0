From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 08/19] ARC: entry.S: confine EXCEPTION_* macros to one file
Date: Sun, 7 Jun 2015 14:08:12 +0530
Message-ID: <1433666303-26112-9-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56892 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688AbbFGIjj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:39 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry.S | 16 ++++++++++++++++
 arch/arc/mm/tlbex.S     | 16 +---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index d8ec722a936b..6cced37e7a76 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -368,6 +368,22 @@ ENTRY(EV_TLBProtV)
 
 END(EV_TLBProtV)
 
+; Wrapper for Linux page fault handler called from EV_TLBMiss*
+; Very similar to ProtV handler case (6a) above, but avoids the extra checks
+; for Misaligned access
+;
+ENTRY(call_do_page_fault)
+
+	EXCEPTION_PROLOGUE
+	lr  r0, [efa]	; Faulting Data address
+	mov   r1, sp
+	FAKE_RET_FROM_EXCPN r9
+
+	mov blink, ret_from_exception
+	b  do_page_fault
+
+END(call_do_page_fault)
+
 ; ---------------------------------------------
 ; Privilege Violation Exception Handler
 ; ---------------------------------------------
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index d572f1c2c724..d224bf0feefc 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -366,19 +366,5 @@ do_slow_path_pf:
 
 	; Slow path TLB Miss handled as a regular ARC Exception
 	; (stack switching / save the complete reg-file).
-	EXCEPTION_PROLOGUE
-
-	; ------- setup args for Linux Page fault Hanlder ---------
-	mov_s r1, sp
-	lr    r0, [efa]
-
-	; We don't want exceptions to be disabled while the fault is handled.
-	; Now that we have saved the context we return from exception hence
-	; exceptions get re-enable
-
-	FAKE_RET_FROM_EXCPN  r9
-
-	bl  do_page_fault
-	b   ret_from_exception
-
+	b  call_do_page_fault
 END(EV_TLBMissD)
-- 
1.9.1
