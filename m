Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:19112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751692AbWAaW3r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Jan 2006 17:29:47 -0500
Date: Tue, 31 Jan 2006 14:31:49 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [PATCH] abstract type/size specification for assembly
Message-Id: <20060131143149.35db2e02.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__31_Jan_2006_14_31_49_-0800_On_xo9OI6utzn6dy"
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Jan Beulich <JBeulich@novell.com>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Tue__31_Jan_2006_14_31_49_-0800_On_xo9OI6utzn6dy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


OK?



From: Jan Beulich <jbeulich@novell.com>

Provide abstraction for generating type and size information of assembly
routines and data.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/linkage.h |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN include/linux/linkage.h~abstract-type-size-specification-for-assembly include/linux/linkage.h
--- 25/include/linux/linkage.h~abstract-type-size-specification-for-assembly	Tue Jan 31 14:30:58 2006
+++ 25-akpm/include/linux/linkage.h	Tue Jan 31 14:30:58 2006
@@ -39,6 +39,11 @@
   ALIGN; \
   name:
 
+#define ENDPROC(name) \
+  .type name, @function; \
+  END(name)
+#define END(name) \
+  .size name, .-name
 
 #endif
 
_


--Multipart=_Tue__31_Jan_2006_14_31_49_-0800_On_xo9OI6utzn6dy
Content-Type: text/plain;
 name="linux-2.6.16-rc1-end-endproc.patch"
Content-Disposition: attachment;
 filename="linux-2.6.16-rc1-end-endproc.patch"
Content-Transfer-Encoding: 7bit

From: Jan Beulich <jbeulich@novell.com>

Provide abstraction for generating type and size information of
assembly routines and data.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/include/linux/linkage.h 2.6.16-rc1-end-endproc/include/linux/linkage.h
--- /home/jbeulich/tmp/linux-2.6.16-rc1/include/linux/linkage.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc1-end-endproc/include/linux/linkage.h	2006-01-25 10:41:49.000000000 +0100
@@ -39,6 +39,11 @@
   ALIGN; \
   name:
 
+#define ENDPROC(name) \
+  .type name, @function; \
+  END(name)
+#define END(name) \
+  .size name, .-name
 
 #endif
 


--Multipart=_Tue__31_Jan_2006_14_31_49_-0800_On_xo9OI6utzn6dy--
