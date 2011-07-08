From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 17/39] UAPI: Fix E820_X_MAX ordering problem
Date: Fri, 08 Jul 2011 15:25:42 +0100
Message-ID: <20110708142542.31344.93894.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4297 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab1GHO0Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:26:25 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

There's an ordering problem around the definition of E820_X_MAX: the definition
in the kernel-specific header is referred to in the user-specific header data
structures, at least for x86.  When compiling userspace, the user-specific
header provides an alternate version of E820_X_MAX.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/e820.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/e820.h b/arch/x86/include/asm/e820.h
index 908b969..e02512f 100644
--- a/arch/x86/include/asm/e820.h
+++ b/arch/x86/include/asm/e820.h
@@ -45,6 +45,8 @@
 #define E820_NVS	4
 #define E820_UNUSABLE	5
 
+// DISINTEGRATE: INCLUDE UAPI HERE
+
 /*
  * reserved RAM used by kernel itself
  * if CONFIG_INTEL_TXT is enabled, memory of this type will be
