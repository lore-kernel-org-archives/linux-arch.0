From: David Howells <dhowells@redhat.com>
Subject: [PATCH 34/35] UAPI: Make UAPI headers install to usr/include/
Date: Sat, 02 Jul 2011 12:12:32 +0100
Message-ID: <20110702111232.21948.1105.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1462 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLMg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:12:36 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BCatu026135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:12:36 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Make core UAPI headers install to the usr/include/ directory.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3192b2e..8dff6e8 100644
--- a/Makefile
+++ b/Makefile
@@ -1072,7 +1072,7 @@ headers_install: __headers
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/asm $(hdr-dst)
 	$(if $(wildcard $(srctree)/arch/$(hdr-arch)/uapi/asm/Kbuild),, \
 	$(error Headers not exportable for the $(SRCARCH) architecture))
-	$(Q)$(MAKE) $(hdr-inst)=uapi
+	$(Q)$(MAKE) $(hdr-inst)=uapi dst=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/uapi/asm $(hdr-dst)
 
 PHONY += headers_check_all
@@ -1083,7 +1083,7 @@ PHONY += headers_check
 headers_check: headers_install
 	$(Q)$(MAKE) $(hdr-inst)=include HDRCHECK=1
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/asm $(hdr-dst) HDRCHECK=1
-	$(Q)$(MAKE) $(hdr-inst)=uapi HDRCHECK=1
+	$(Q)$(MAKE) $(hdr-inst)=uapi HDRCHECK=1 dst=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/uapi/asm $(hdr-dst) HDRCHECK=1
 
 # ---------------------------------------------------------------------------
