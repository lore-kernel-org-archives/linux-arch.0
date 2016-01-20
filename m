From: David Howells <dhowells@redhat.com>
Subject: [PATCH] FRV: Mark architecture orphaned
Date: Wed, 20 Jan 2016 10:29:00 +0000
Message-ID: <20160120102900.15824.20938.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54468 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933127AbcATK3C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Jan 2016 05:29:02 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Mark the FRV architecture orphaned in the MAINTAINERS file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 MAINTAINERS |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 050d0e77a2cf..414549ceddae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4582,8 +4582,7 @@ F:	include/linux/f2fs_fs.h
 F:	include/trace/events/f2fs.h
 
 FUJITSU FR-V (FRV) PORT
-M:	David Howells <dhowells@redhat.com>
-S:	Maintained
+S:	Orphan
 F:	arch/frv/
 
 FUJITSU LAPTOP EXTRAS
