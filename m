From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 05/40] avr32: Use block_sigmask()
Date: Tue, 14 Feb 2012 11:40:38 +0000
Message-ID: <1329219673-28711-6-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Havard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-arch.vger.kernel.org

From: Matt Fleming <matt.fleming@intel.com>

Use the new helper function introduced in commit 5e6292c0f28f
("signal: add block_sigmask() for adding sigmask to current->blocked")
which centralises the code for updating current->blocked after
successfully delivering a signal and reduces the amount of duplicate
code across architectures.

In the past some architectures got this code wrong, so using this
helper function should stop that from happening again.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Havard Skinnemoen <hskinnemoen@gmail.com>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/avr32/kernel/signal.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/avr32/kernel/signal.c b/arch/avr32/kernel/signal.c
index 06f4293..feeb77b 100644
--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -223,7 +223,6 @@ static inline void
 handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
 	      sigset_t *oldset, struct pt_regs *regs, int syscall)
 {
-	sigset_t blocked;
 	int ret;
 
 	/*
@@ -244,10 +243,7 @@ handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
 	/*
 	 * Block the signal if we were successful.
 	 */
-	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NODEFER))
-		sigaddset(&blocked, sig);
-	set_current_blocked(&blocked);
+	block_sigmask(ka, sig);
 }
 
 /*
-- 
1.7.4.4
