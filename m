Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:2689 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424034AbWKIEFS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:05:18 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96mO3d005448
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:48:25 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:05:14 +1100
Message-Id: <20061109040514.17391.15796.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 10/12] crash_stop: add to config system
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

Add CONFIG_CRASH_STOP and CONFIG_CRASH_STOP_SUPPORTED.  Debug code will
select CRASH_STOP.  That in turn will select CRASH_STOP_SUPPORTED if
the config supports crash_stop().  If the supported architecture list
changes then only the CRASH_STOP entry needs to be updated, none of the
tools that select CRASH_STOP have to worry about arch dependent
details.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 lib/Kconfig.debug |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -412,3 +412,10 @@ config LKDTM
 
 	Documentation on how to use the module can be found in
 	drivers/misc/lkdtm.c
+
+config CRASH_STOP
+	bool
+	select CRASH_STOP_SUPPORTED if ( IA64 || (X86 && !X86_VOYAGER) )
+
+config CRASH_STOP_SUPPORTED
+	bool
