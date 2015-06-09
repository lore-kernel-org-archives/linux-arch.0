From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 17/28] ARC: add compiler barrier to LLSC based cmpxchg
Date: Tue, 9 Jun 2015 17:18:17 +0530
Message-ID: <1433850508-26317-18-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33116 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753853AbbFILu3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:29 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>

When auditing cmpxchg call sites, Chuck noted that gcc was optimizing
away some of the desired LDs.

|	do {
|		new = old = *ipi_data_ptr;
|		new |= 1U << msg;
|	} while (cmpxchg(ipi_data_ptr, old, new) != old);

was generating to below

| 8015cef8:	ld         r2,[r4,0]  <-- First LD
| 8015cefc:	bset       r1,r2,r1
|
| 8015cf00:	llock      r3,[r4]  <-- atomic op
| 8015cf04:	brne       r3,r2,8015cf10
| 8015cf08:	scond      r1,[r4]
| 8015cf0c:	bnz        8015cf00
|
| 8015cf10:	brne       r3,r2,8015cf00  <-- Branch doesn't go to orig LD

Although this was fixed by adding a ACCESS_ONCE in this call site, it
seems safer (for now at least) to add compiler barrier to LLSC based
cmpxchg

Reported-by: Chuck Jordan <cjordan@synopsys,com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/cmpxchg.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 03cd6894855d..90de5c528da2 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -25,10 +25,11 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 	"	scond   %3, [%1]	\n"
 	"	bnz     1b		\n"
 	"2:				\n"
-	: "=&r"(prev)
-	: "r"(ptr), "ir"(expected),
-	  "r"(new) /* can't be "ir". scond can't take limm for "b" */
-	: "cc");
+	: "=&r"(prev)	/* Early clobber, to prevent reg reuse */
+	: "r"(ptr),	/* Not "m": llock only supports reg direct addr mode */
+	  "ir"(expected),
+	  "r"(new)	/* can't be "ir". scond can't take LIMM for "b" */
+	: "cc", "memory"); /* so that gcc knows memory is being written here */
 
 	return prev;
 }
-- 
1.9.1
