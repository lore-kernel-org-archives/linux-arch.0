Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33867 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbdF0KMR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2017 06:12:17 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v4 02/17] mm: ability to disable execute permission on a key at creation
Date: Tue, 27 Jun 2017 03:11:44 -0700
Message-ID: <1498558319-32466-3-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170627101144.ZtyemdX5J_sm8-IGSCd7cnXMQ5n9uMkRbw2ERkihNEE@z>

Currently sys_pkey_create() provides the ability to disable read
and write permission on the key, at  creation. powerpc  has  the
hardware support to disable execute on a pkey as well.This patch
enhances the interface to let disable execute  at  key  creation
time. x86 does  not  allow  this.  Hence the next patch will add
ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
specified.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 include/uapi/asm-generic/mman-common.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 8c27db0..bf4fa07 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -74,7 +74,9 @@
 
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
+#define PKEY_DISABLE_EXECUTE	0x4
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-				 PKEY_DISABLE_WRITE)
+				 PKEY_DISABLE_WRITE  |\
+				 PKEY_DISABLE_EXECUTE)
 
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
-- 
1.8.3.1
