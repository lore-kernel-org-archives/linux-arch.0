Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:58912 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754116AbXKAADL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2007 20:03:11 -0400
Message-Id: <20071101000310.217429212@sgi.com>
References: <20071101000211.970501947@sgi.com>
Date: Wed, 31 Oct 2007 17:02:14 -0700
From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 3/7] Allocpercpu: Do __percpu_disguise() only if CONFIG_DEBUG_VM is set
Content-Disposition: inline; filename=opt_disguise
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Pekka Enberg <penberg@cs.helsinki.fi>
List-ID: <linux-arch.vger.kernel.org>

Disguising costs a few cycles in the hot paths. So switch it off if
we are not debuggin.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

---
 include/linux/percpu.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6/include/linux/percpu.h
===================================================================
--- linux-2.6.orig/include/linux/percpu.h	2007-10-31 16:40:14.892121256 -0700
+++ linux-2.6/include/linux/percpu.h	2007-10-31 16:41:00.907621059 -0700
@@ -33,7 +33,11 @@
 
 #ifdef CONFIG_SMP
 
+#ifdef CONFIG_DEBUG_VM
 #define __percpu_disguise(pdata) ((void *)~(unsigned long)(pdata))
+#else
+#define __percpu_disguide(pdata) ((void *)(pdata))
+#endif
 
 /* 
  * Use this to get to a cpu's version of the per-cpu object dynamically

-- 
