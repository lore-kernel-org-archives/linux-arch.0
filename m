From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] mm/pkeys: generate pkey system call code only if ARCH_HAS_PKEYS is selected
Date: Mon, 14 Nov 2016 12:12:51 +0100
Message-ID: <20161114111251.70084-1-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57899 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752194AbcKNLM6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Nov 2016 06:12:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAEB8qHl071380
        for <linux-arch@vger.kernel.org>; Mon, 14 Nov 2016 06:12:57 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26q524tp61-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 Nov 2016 06:12:57 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 14 Nov 2016 11:12:55 -0000
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

Having code for the pkey_mprotect, pkey_alloc and pkey_free system
calls makes only sense if ARCH_HAS_PKEYS is selected. If not selected
these system calls will always return -ENOSPC or -EINVAL.

To simplify things and have less code generate the pkey system call
code only if ARCH_HAS_PKEYS is selected.

For architectures which have already wired up the system calls, but do
not select ARCH_HAS_PKEYS this will result in less generated code and
a different return code: the three system calls will now always return
-ENOSYS, using the cond_syscall mechanism.

For architectures which have not wired up the system calls less
unreachable code will be generated.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 mm/mprotect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 11936526b08b..a06e91c4de29 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -484,6 +484,8 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 	return do_mprotect_pkey(start, len, prot, -1);
 }
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
@@ -534,3 +536,5 @@ SYSCALL_DEFINE1(pkey_free, int, pkey)
 	 */
 	return ret;
 }
+
+#endif /* CONFIG_ARCH_HAS_PKEYS */
-- 
2.8.4
