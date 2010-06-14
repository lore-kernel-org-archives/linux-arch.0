Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:50785 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956Ab0FNMs6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2010 08:48:58 -0400
From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 5/5] score: Remove *(.text.*) pattern from the linker script
Date: Mon, 14 Jun 2010 13:38:32 +0100
Message-ID: <1276519112-11649-5-git-send-email-matt@console-pimps.org>
In-Reply-To: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Chen Liqin <liqin.chen@sunplusct.com>, linux-kernel@vger.kernel.org
Message-ID: <20100614123832.ft4azdyJ5glkYXuH4ttlOErSyHEvVNhntQMZ6qVOJM8@z>

From: Matt Fleming <matthew.fleming@imgtec.com>

Drop the pattern from the linker script because the pattern is now
provided by TEXT_TEXT.

Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
---
 arch/score/kernel/vmlinux.lds.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/score/kernel/vmlinux.lds.S b/arch/score/kernel/vmlinux.lds.S
index eebcbaa..2ed49ad 100644
--- a/arch/score/kernel/vmlinux.lds.S
+++ b/arch/score/kernel/vmlinux.lds.S
@@ -42,7 +42,6 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
-		*(.text.*)
 		*(.fixup)
 		. = ALIGN (4) ;
 		_etext = .;	/* End of text section */
-- 
1.6.6.1

