Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:57875 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932172Ab2BNLoC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Feb 2012 06:44:02 -0500
From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 37/40] xtensa: Don't reimplement force_sigsegv()
Date: Tue, 14 Feb 2012 11:41:10 +0000
Message-ID: <1329219673-28711-38-git-send-email-matt@console-pimps.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Chris Zankel <chris@zankel.net>
Message-ID: <20120214114110.mR5a9X8SaAzyvGGqp1cJQ3xZAd-HPRggLABLvInB6Vc@z>

From: Matt Fleming <matt.fleming@intel.com>

Instead of open coding the sequence from force_sigsegv() just call
it. This also fixes a bug because we were modifying ka->sa.sa_handler
(which is a copy of sighand->action[]), whereas the intention of the
code was to modify sighand->action[] directly.

As the original code was working with a copy it had no effect on
signal delivery.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Chris Zankel <chris@zankel.net>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/xtensa/kernel/signal.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index f2220b5..4f53770 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -425,9 +425,7 @@ static void setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
-- 
1.7.4.4

