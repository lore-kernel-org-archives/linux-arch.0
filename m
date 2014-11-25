Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:41431 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbaKYMiq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Nov 2014 07:38:46 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Tue, 25 Nov 2014 12:38:45 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2 09/10] tighten rules for ACCESS ONCE
Date: Tue, 25 Nov 2014 13:38:36 +0100
Message-Id: <1416919117-50652-10-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, paulmck@linux.vnet.ibm.com, mingo@kernel.org, torvalds@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Howells <dhowells@redhat.com>, Russell King <linux@arm.linux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>

Now that all non-scalar users of ACCESS_ONCE have been converted
to READ_ONCE or ASSIGN once, lets tighten ACCESS_ONCE to only
work on scalar types.
This variant was proposed by Alexei Starovoitov.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/compiler.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0ff01f2..7265a6c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -411,8 +411,16 @@ static __always_inline void __read_once_size(volatile void *p, void *res, int si
  * merging, or refetching absolutely anything at any time.  Its main intended
  * use is to mediate communication between process-level code and irq/NMI
  * handlers, all running on the same CPU.
+ *
+ * ACCESS_ONCE will only work on scalar types. For union types, ACCESS_ONCE
+ * on a union member will work as long as the size of the member matches the
+ * size of the union and the size is smaller than word size.
+ * If possible READ_ONCE/ASSIGN_ONCE should be used instead.
  */
-#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define __ACCESS_ONCE(x) ({ \
+	 __maybe_unused typeof(x) __var = 0; \
+	(volatile typeof(x) *)&(x); })
+#define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
 
 /* Ignore/forbid kprobes attach on very low level functions marked by this attribute: */
 #ifdef CONFIG_KPROBES
-- 
1.9.3

