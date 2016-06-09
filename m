Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32693 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933632AbcFIACM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jun 2016 20:02:12 -0400
Subject: [PATCH 7/9] generic syscalls: wire up memory protection keys syscalls
From: Dave Hansen <dave@sr71.net>
Date: Wed, 08 Jun 2016 17:01:33 -0700
References: <20160609000117.71AC7623@viggo.jf.intel.com>
In-Reply-To: <20160609000117.71AC7623@viggo.jf.intel.com>
Message-ID: <20160609000133.D83B340F@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, arnd@arndb.de
Message-ID: <20160609000133.EgC18eT7fgjbAXWYNpB2pyvRBAY91aWGmrO2bMTwEqo@z>


From: Dave Hansen <dave.hansen@linux.intel.com>

These new syscalls are implemented as generic code, so enable
them for architectures like arm64 which use the generic syscall
table.

According to Arnd:

	Even if the support is x86 specific for the forseeable
	future, it may be good to reserve the number just in
	case.  The other architecture specific syscall lists are
	usually left to the individual arch maintainers, most a
	lot of the newer architectures share this table.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

 b/include/uapi/asm-generic/unistd.h |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff -puN include/uapi/asm-generic/unistd.h~pkeys-119-syscalls-generic include/uapi/asm-generic/unistd.h
--- a/include/uapi/asm-generic/unistd.h~pkeys-119-syscalls-generic	2016-06-08 16:26:36.450995311 -0700
+++ b/include/uapi/asm-generic/unistd.h	2016-06-08 16:26:36.455995538 -0700
@@ -724,9 +724,19 @@ __SYSCALL(__NR_copy_file_range, sys_copy
 __SC_COMP(__NR_preadv2, sys_preadv2, compat_sys_preadv2)
 #define __NR_pwritev2 287
 __SC_COMP(__NR_pwritev2, sys_pwritev2, compat_sys_pwritev2)
+#define __NR_pkey_mprotect 288
+__SYSCALL(__NR_pkey_mprotect, sys_pkey_mprotect)
+#define __NR_pkey_alloc 289
+__SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
+#define __NR_pkey_free 290
+__SYSCALL(__NR_pkey_free,     sys_pkey_free)
+#define __NR_pkey_get 291
+__SYSCALL(__NR_pkey_get,      sys_pkey_get)
+#define __NR_pkey_set 292
+__SYSCALL(__NR_pkey_set,      sys_pkey_set)
 
 #undef __NR_syscalls
-#define __NR_syscalls 288
+#define __NR_syscalls 293
 
 /*
  * All syscalls below here should go away really,
_
