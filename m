Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:62848 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424034AbWKIEEv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:04:51 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96luGh005350
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:47:58 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:04:46 +1100
Message-Id: <20061109040446.17391.35190.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 5/12] crash_stop: add DIE_NMIWATCHDOG to x86_64
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

x86_64 defines DIE_NMIWATCHDOG but does not use it.  Add an x86_64 call to
notify_die when the NMI watchdog is about to go off, as i386 does.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 arch/x86_64/kernel/traps.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -613,7 +613,11 @@ void die(const char * str, struct pt_reg
 
 void __kprobes die_nmi(char *str, struct pt_regs *regs, int do_panic)
 {
-	unsigned long flags = oops_begin();
+	unsigned long flags;
+	if (notify_die(DIE_NMIWATCHDOG, str, regs, 0, 2, SIGINT) ==
+	    NOTIFY_STOP)
+		return;
+	flags = oops_begin();
 
 	/*
 	 * We are in trouble anyway, lets at least try
