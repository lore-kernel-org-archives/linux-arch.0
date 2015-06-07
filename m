From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 09/19] ARC: entry.S: FAKE_RET_FROM_EXCPN can always use r9
Date: Sun, 7 Jun 2015 14:08:13 +0530
Message-ID: <1433666303-26112-10-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56899 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779AbbFGIju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:50 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry.h | 16 ++++++++--------
 arch/arc/kernel/entry.S      | 24 +++++++++++-------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index e880a5f1b2e4..c976b54c9b07 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -331,14 +331,14 @@
  * Look at EV_ProtV to see how this is actually used
  *-------------------------------------------------------------*/
 
-.macro FAKE_RET_FROM_EXCPN  reg
-
-	ld  \reg, [sp, PT_status32]
-	bic  \reg, \reg, (STATUS_U_MASK|STATUS_DE_MASK)
-	bset \reg, \reg, STATUS_L_BIT
-	sr  \reg, [erstatus]
-	mov \reg, 55f
-	sr  \reg, [eret]
+.macro FAKE_RET_FROM_EXCPN
+
+	ld  r9, [sp, PT_status32]
+	bic  r9, r9, (STATUS_U_MASK|STATUS_DE_MASK)
+	bset r9, r9, STATUS_L_BIT
+	sr  r9, [erstatus]
+	mov r9, 55f
+	sr  r9, [eret]
 
 	rtie
 55:
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 6cced37e7a76..0a75f81e2853 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -261,7 +261,7 @@ ENTRY(instr_service)
 	lr  r0, [efa]
 	mov r1, sp
 
-	FAKE_RET_FROM_EXCPN r9
+	FAKE_RET_FROM_EXCPN
 
 	bl  do_insterror_or_kprobe
 	b   ret_from_exception
@@ -278,7 +278,7 @@ ENTRY(mem_service)
 	lr  r0, [efa]
 	mov r1, sp
 
-	FAKE_RET_FROM_EXCPN r9
+	FAKE_RET_FROM_EXCPN
 
 	bl  do_memory_error
 	b   ret_from_exception
@@ -330,12 +330,11 @@ ENTRY(EV_TLBProtV)
 	lr  r2, [ecr]
 	lr  r0, [efa]	; Faulting Data address
 
-	; --------(4) Return from CPU Exception Mode ---------
-	;  Fake a rtie, but rtie to next label
-	;  That way, subsequently, do_page_fault ( ) executes in pure kernel
-	;  mode with further Exceptions enabled
+	; Exception auto-disables further Intr/exceptions.
+	; Re-enable them by pretending to return from exception
+	; (so rest of handler executes in pure K mode)
 
-	FAKE_RET_FROM_EXCPN r9
+	FAKE_RET_FROM_EXCPN
 
 	mov   r1, sp
 
@@ -377,7 +376,7 @@ ENTRY(call_do_page_fault)
 	EXCEPTION_PROLOGUE
 	lr  r0, [efa]	; Faulting Data address
 	mov   r1, sp
-	FAKE_RET_FROM_EXCPN r9
+	FAKE_RET_FROM_EXCPN
 
 	mov blink, ret_from_exception
 	b  do_page_fault
@@ -394,7 +393,7 @@ ENTRY(EV_PrivilegeV)
 	lr  r0, [efa]
 	mov r1, sp
 
-	FAKE_RET_FROM_EXCPN r9
+	FAKE_RET_FROM_EXCPN
 
 	bl  do_privilege_fault
 	b   ret_from_exception
@@ -410,7 +409,7 @@ ENTRY(EV_Extension)
 	lr  r0, [efa]
 	mov r1, sp
 
-	FAKE_RET_FROM_EXCPN r9
+	FAKE_RET_FROM_EXCPN
 
 	bl  do_extension_fault
 	b   ret_from_exception
@@ -472,7 +471,7 @@ trap_with_param:
 
 	; Now that we have read EFA, it is safe to do "fake" rtie
 	;   and get out of CPU exception mode
-	FAKE_RET_FROM_EXCPN r11
+	FAKE_RET_FROM_EXCPN
 
 	; Save callee regs in case gdb wants to have a look
 	; SP will grow up by size of CALLEE Reg-File
@@ -512,8 +511,7 @@ ENTRY(EV_Trap)
 
 	; ======= (5a) Trap is due to System Call ========
 
-	; Before doing anything, return from CPU Exception Mode
-	FAKE_RET_FROM_EXCPN r11
+	FAKE_RET_FROM_EXCPN
 
 	; If syscall tracing ongoing, invoke pre-pos-hooks
 	GET_CURR_THR_INFO_FLAGS   r10
-- 
1.9.1
