Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40280 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760635Ab0I1C5x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 22:57:53 -0400
Date: Tue, 28 Sep 2010 03:57:52 +0100
Subject: [PATCH 4/6] avr32: clear TIF_RESTORE_SIGMASK when signal is
 delivered
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <E1P0QO9-0008So-06@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hans-christian.egtvedt@atmel.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100928025752.wP1VStl3FSf5SH7WYjRN6N775RW1NXU-EXcFHE5EGfc@z>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/avr32/kernel/signal.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/kernel/signal.c b/arch/avr32/kernel/signal.c
index 52affae..7dbbec1 100644
--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -246,6 +246,10 @@ handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
 		sigaddset(&current->blocked, sig);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
+
+	/* mask saved on sigframe we'd set up */
+	clear_thread_flag(TIF_RESTORE_SIGMASK);
+
 	return;
 
 fail:
-- 
1.5.6.5


