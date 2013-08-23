Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a194-110.smtp-out.amazonses.com ([199.255.194.110]:35076 "EHLO
	a194-110.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755863Ab3HWTLj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Aug 2013 15:11:39 -0400
Message-ID: <00000140ac8deda6-09306a6b-8b41-48f6-8d72-5f9154593832-000000@email.amazonses.com>
Date: Fri, 23 Aug 2013 19:01:58 +0000
From: Christoph Lameter <cl@linux.com>
Subject: [guv 02/16] percpu: Make __verify_pcu_ptr handle per cpu pointers to arrays
References: <20130823190135.726207430@linux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <20130823190158.nTZFG9yccL-NdFIG8lWH6f-cEPTGwUEllddBteZo9uU@z>

__verify_pcpu_ptr() will cause a compilation failure if the type of the
pointer is a pointer to a fixed array of objects. Adding zero to the
pointer converts the type of pointer to that pointing to a single
object of the array.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/include/linux/percpu-defs.h
===================================================================
--- linux.orig/include/linux/percpu-defs.h	2013-08-22 13:39:04.000000000 -0500
+++ linux/include/linux/percpu-defs.h	2013-08-22 13:41:15.333140537 -0500
@@ -22,9 +22,12 @@
  * Macro which verifies @ptr is a percpu pointer without evaluating
  * @ptr.  This is to be used in percpu accessors to verify that the
  * input parameter is a percpu pointer.
+ *
+ * + 0 is required in order to convert the pointer type from a
+ * potential array type to a pointer to a single item of the array.
  */
 #define __verify_pcpu_ptr(ptr)	do {					\
-	const void __percpu *__vpp_verify = (typeof(ptr))NULL;		\
+	const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;	\
 	(void)__vpp_verify;						\
 } while (0)
 

