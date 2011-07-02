From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/35] UAPI: Don't have a #elif clause in a __KERNEL__ guard
 in linux/soundcard.h
Date: Sat, 02 Jul 2011 12:08:41 +0100
Message-ID: <20110702110841.21948.88903.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2301 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLIp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:08:45 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B8jDm024858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:08:45 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Don't have a #elif clause in a __KERNEL__ guard in linux/soundcard.h to make
parsing easier.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/soundcard.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/soundcard.h b/include/linux/soundcard.h
index fe204fe..dfcf86f 100644
--- a/include/linux/soundcard.h
+++ b/include/linux/soundcard.h
@@ -198,7 +198,8 @@ typedef struct seq_event_rec {
 #  else
 #    error "could not determine byte order"
 #  endif
-#elif defined(__BYTE_ORDER)
+#else
+# if defined(__BYTE_ORDER)
 #  if __BYTE_ORDER == __BIG_ENDIAN
 #    define AFMT_S16_NE AFMT_S16_BE
 #  elif __BYTE_ORDER == __LITTLE_ENDIAN
@@ -206,6 +207,7 @@ typedef struct seq_event_rec {
 #  else
 #    error "could not determine byte order"
 #  endif
+# endif
 #endif
 
 /*
