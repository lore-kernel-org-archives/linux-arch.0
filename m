From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/35] UAPI: Fix E820_X_MAX ordering problem
Date: Sat, 02 Jul 2011 12:09:44 +0100
Message-ID: <20110702110944.21948.83285.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12635 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLJr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:09:47 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B9kWq016089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:09:47 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
