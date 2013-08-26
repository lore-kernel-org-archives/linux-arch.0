From: Christoph Lameter <cl@linux.com>
Subject: [guv v2 02/31] percpu: Make __verify_pcu_ptr handle per cpu pointers to arrays
Date: Mon, 26 Aug 2013 20:41:18 +0000
Message-ID: <00000140bc5bf84a-56dd6082-f1d6-4cee-b8dd-cc4e5c27a911-000000@email.amazonses.com>
References: <20130826204138.307369532@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:46180 "EHLO
	a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653Ab3HZUsG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Aug 2013 16:48:06 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org

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
 
