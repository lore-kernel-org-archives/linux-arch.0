From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 10/39] UAPI: Don't have a #elif clause in a
 __KERNEL__ guard in linux/soundcard.h
Date: Fri, 08 Jul 2011 15:24:30 +0100
Message-ID: <20110708142430.31344.849.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab1GHOZM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:25:12 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

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
