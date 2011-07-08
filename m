From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 05/39] UAPI: Add include/uapi/ directories to build
Date: Fri, 08 Jul 2011 15:23:42 +0100
Message-ID: <20110708142342.31344.75819.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59921 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab1GHOY2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:24:28 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Add include/uapi/ directories to build after the ordinary include directories
so that #include will pick up the UAPI header directly if the kernel header
has been moved there.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 86f47a0..b66bab5 100644
--- a/Makefile
+++ b/Makefile
@@ -357,8 +357,12 @@ CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage
 
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
-LINUXINCLUDE    := -I$(srctree)/arch/$(hdr-arch)/include \
-                   -Iarch/$(hdr-arch)/include/generated -Iinclude \
+LINUXINCLUDE    := \
+		-I$(srctree)/arch/$(hdr-arch)/include \
+		-Iarch/$(hdr-arch)/include/generated \
+		-I$(srctree)/arch/$(hdr-arch)/include/uapi \
+		-Iinclude \
+		-Iinclude/uapi \
                    $(if $(KBUILD_SRC), -I$(srctree)/include) \
                    -include include/generated/autoconf.h
 
