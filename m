Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:50782 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868Ab0FNMs6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2010 08:48:58 -0400
From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 2/5] blackfin: Remove *(.text.*) pattern from the linker script
Date: Mon, 14 Jun 2010 13:38:29 +0100
Message-ID: <1276519112-11649-2-git-send-email-matt@console-pimps.org>
In-Reply-To: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org
Message-ID: <20100614123829.as4kLKlg87W0Arx4wOICRHowZ7fmHSnHD3uiPzbx2zI@z>

From: Matt Fleming <matthew.fleming@imgtec.com>

Drop the pattern from the linker script because the pattern is now
provided by TEXT_TEXT.

Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
---
 arch/blackfin/kernel/vmlinux.lds.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/blackfin/kernel/vmlinux.lds.S b/arch/blackfin/kernel/vmlinux.lds.S
index 984c781..2c340fd 100644
--- a/arch/blackfin/kernel/vmlinux.lds.S
+++ b/arch/blackfin/kernel/vmlinux.lds.S
@@ -42,7 +42,6 @@ SECTIONS
 		__einittext = .;
 		EXIT_TEXT
 #endif
-		*(.text.*)
 		*(.fixup)
 
 #if !L1_CODE_LENGTH
-- 
1.6.6.1

