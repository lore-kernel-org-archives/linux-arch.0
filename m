From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 37/39] UAPI: Make UAPI headers install to usr/include/
Date: Fri, 08 Jul 2011 15:29:01 +0100
Message-ID: <20110708142901.31344.43162.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833Ab1GHO3n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:29:43 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Make core UAPI headers install to the usr/include/ directory.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9a165a7..60ff965 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,7 +1071,7 @@ headers_install: __headers
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/asm $(hdr-dst)
 	$(if $(wildcard $(srctree)/arch/$(hdr-arch)/include/uapi/asm/Kbuild),, \
 	$(error Headers not exportable for the $(SRCARCH) architecture))
-	$(Q)$(MAKE) $(hdr-inst)=include/uapi
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi dst=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi/asm $(hdr-dst)
 
 PHONY += headers_check_all
@@ -1082,7 +1082,7 @@ PHONY += headers_check
 headers_check: headers_install
 	$(Q)$(MAKE) $(hdr-inst)=include HDRCHECK=1
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/asm $(hdr-dst) HDRCHECK=1
-	$(Q)$(MAKE) $(hdr-inst)=include/uapi HDRCHECK=1
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi HDRCHECK=1 dst=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi/asm $(hdr-dst) HDRCHECK=1
 
 # ---------------------------------------------------------------------------
