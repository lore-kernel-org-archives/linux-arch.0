From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 34/39] UAPI: Plumb the UAPI Kbuilds into the user
 header handling system
Date: Fri, 08 Jul 2011 15:28:29 +0100
Message-ID: <20110708142829.31344.52892.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab1GHO3Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:29:16 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Plumb the UAPI Kbuilds into the user header handling system.  As the headers
are split the entries will be transferred across.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 0fe2209..ca2bae7 100644
--- a/Makefile
+++ b/Makefile
@@ -1069,6 +1069,10 @@ headers_install: __headers
 	$(error Headers not exportable for the $(SRCARCH) architecture))
 	$(Q)$(MAKE) $(hdr-inst)=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/asm $(hdr-dst)
+	$(if $(wildcard $(srctree)/arch/$(hdr-arch)/include/uapi/asm/Kbuild),, \
+	$(error Headers not exportable for the $(SRCARCH) architecture))
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi
+	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi/asm $(hdr-dst)
 
 PHONY += headers_check_all
 headers_check_all: headers_install_all
@@ -1078,6 +1082,8 @@ PHONY += headers_check
 headers_check: headers_install
 	$(Q)$(MAKE) $(hdr-inst)=include HDRCHECK=1
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/asm $(hdr-dst) HDRCHECK=1
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi HDRCHECK=1
+	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi/asm $(hdr-dst) HDRCHECK=1
 
 # ---------------------------------------------------------------------------
 # Modules
