From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/35] UAPI: Make linux/patchkey.h easier to parse
Date: Sat, 02 Jul 2011 12:08:32 +0100
Message-ID: <20110702110832.21948.15925.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLIg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:08:36 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B8ZfH015981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:08:36 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Make linux/patchkey.h easier to parse by:

 (1) Switching the reinclusion guard and the indirect-inclusion checks in
     linux/patchkey.h to put the guard around the outside.

 (2) Making the #elif case associated with the __KERNEL__ guard a nested #if
     in a #else of the __KERNEL__ guard.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/patchkey.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/patchkey.h b/include/linux/patchkey.h
index d974a6e..aefda0e 100644
--- a/include/linux/patchkey.h
+++ b/include/linux/patchkey.h
@@ -32,7 +32,8 @@
 #  else
 #    error "could not determine byte order"
 #  endif
-#elif defined(__BYTE_ORDER)
+#else
+#if defined(__BYTE_ORDER)
 #  if __BYTE_ORDER == __BIG_ENDIAN
 #    define _PATCHKEY(id) (0xfd00|id)
 #  elif __BYTE_ORDER == __LITTLE_ENDIAN
@@ -41,5 +42,6 @@
 #    error "could not determine byte order"
 #  endif
 #endif
+#endif
 
 #endif /* _LINUX_PATCHKEY_H */
