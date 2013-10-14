From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] xtensa: don't use alternate signal stack on threads
Date: Tue, 15 Oct 2013 02:22:43 +0400
Message-ID: <1381789363-2411-3-git-send-email-jcmvbkbc@gmail.com>
References: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43422 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab3JNWXN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2013 18:23:13 -0400
In-Reply-To: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

From: Baruch Siach <baruch@tkos.co.il>

According to create_thread(3): "The new thread does not inherit the creating
thread's alternate signal stack". Since commit f9a3879a (Fix sigaltstack
corruption among cloned threads), current->sas_ss_size is set to 0 for cloned
processes sharing VM with their parent. Don't use the (nonexistent) alternate
signal stack in this case. This has been broken since commit 29c4dfd9 ([XTENSA]
Remove non-rt signal handling).

Fixes the SA_ONSTACK part of the nptl/tst-cancel20 test from uClibc.

Cc: <stable@vger.kernel.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/signal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 718eca1..98b67d5 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -341,7 +341,7 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 
 	sp = regs->areg[1];
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! on_sig_stack(sp)) {
+	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && sas_ss_flags(sp) == 0) {
 		sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
-- 
1.7.7.6
