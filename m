From: David Howells <dhowells@redhat.com>
Subject: [PATCH 16/17] UAPI: Don't have a #elif clause in a __KERNEL__ guard in linux/soundcard.h
Date: Tue, 13 Dec 2011 10:04:12 +0000
Message-ID: <1323770653-19177-17-git-send-email-dhowells@redhat.com>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au, torvalds@linux-foundation.org
Cc: arnd@arndb.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
-- 
1.7.7.4
