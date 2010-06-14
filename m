Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:50781 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378Ab0FNMs6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2010 08:48:58 -0400
From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 4/5] parisc: Remove *(.text.*) pattern from the linker script
Date: Mon, 14 Jun 2010 13:38:31 +0100
Message-ID: <1276519112-11649-4-git-send-email-matt@console-pimps.org>
In-Reply-To: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org
Message-ID: <20100614123831.ReRg_0btGqSJ33F4NB8Qj6dlmCM_2hCFeWrSB7M5fbM@z>

From: Matt Fleming <matthew.fleming@imgtec.com>

Drop the pattern from the linker script because the pattern is now
provided by TEXT_TEXT.

Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
---
 arch/parisc/kernel/vmlinux.lds.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index d64a6bb..6784e39 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -61,7 +61,6 @@ SECTIONS
 		*(.text.sys_exit)
 		*(.text.do_sigaltstack)
 		*(.text.do_fork)
-		*(.text.*)
 		*(.fixup)
 		*(.lock.text)		/* out-of-line lock text */
 		*(.gnu.warning)
-- 
1.6.6.1

