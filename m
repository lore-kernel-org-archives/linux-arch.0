From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 4/6] avr32: clear TIF_RESTORE_SIGMASK when signal is
 delivered
Date: Tue, 28 Sep 2010 03:57:52 +0100
Message-ID: <E1P0QO9-0008So-06@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hans-christian.egtvedt@atmel.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


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
