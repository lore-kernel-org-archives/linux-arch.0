From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v3 10/23] mm: provide the ability to disable execute on a key at creation
Date: Wed, 21 Jun 2017 18:39:26 -0700
Message-ID: <1498095579-6790-11-git-send-email-linuxram@us.ibm.com>
References: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

Currently sys_pkey_create() provides the ability to disable read
and write permission on the key, at  creation. powerpc  has  the
hardware support to disable execute on a pkey as well.This patch
enhances the interface to let disable execute  at  key  creation
time. x86 does  not  allow  this.  Hence the next patch will add
ability  in  x86  to  return  error  is  PKEY_DISABLE_EXECUTE is
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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
