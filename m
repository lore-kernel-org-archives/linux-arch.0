Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:40129 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750771AbWJMN1r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:27:47 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id 7C62AE0B20A
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:27:46 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id B203A81EE7
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:28:08 +1000 (EST)
From: Keith Owens <kaos@sgi.com>
Subject: [RFC] crash_stop: crash_stop_common_Kconfig
In-reply-to: Your message of "Fri, 13 Oct 2006 23:23:35 +1000."
             <26656.1160745815@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:28:08 +1000
Message-ID: <28266.1160746088@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Add CONFIG_CRASH_STOP and CONFIG_CRASH_STOP_SUPPORTED.  Debug code will
select CRASH_STOP.  That in turn will select CRASH_STOP_SUPPORTED if
the config supports crash_stop().  If the supported architecture list
changes then only the CRASH_STOP entty needs to be updated, all the
tools that select CRASH_STOP do not have to worry about arch dependent
details.

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -398,3 +398,10 @@ config LKDTM
 
 	Documentation on how to use the module can be found in
 	drivers/misc/lkdtm.c
+
+config CRASH_STOP
+	bool
+	select CRASH_STOP_SUPPORTED if SMP && ( (X86 && !X86_VOYAGER) )
+
+config CRASH_STOP_SUPPORTED
+	bool

