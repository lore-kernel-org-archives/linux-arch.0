From: David Howells <dhowells@redhat.com>
Subject: [PATCH 03/35] UAPI: Add uapi/ include directory to build
Date: Sat, 02 Jul 2011 12:08:00 +0100
Message-ID: <20110702110800.21948.25461.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043Ab1GBLIC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:08:02 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B82bC028338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:08:02 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Add uapi/ include directory to build after the ordinary include directories so
that #include_next will work correctly.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index dc67046..f7e6a60 100644
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
+		-I$(srctree)/arch/$(hdr-arch)/uapi \
+		-Iinclude \
+		-Iuapi \
                    $(if $(KBUILD_SRC), -I$(srctree)/include) \
                    -include include/generated/autoconf.h
 
