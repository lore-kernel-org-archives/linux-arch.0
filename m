From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/17] UAPI: Guard linux/sound.h
Date: Tue, 13 Dec 2011 10:04:04 +0000
Message-ID: <1323770653-19177-9-git-send-email-dhowells@redhat.com>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au, torvalds@linux-foundation.org
Cc: arnd@arndb.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Place reinclusion guards on linux/sound.h otherwise the UAPI splitter script
won't insert a #include to make the kernel header include the UAPI header.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/sound.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/sound.h b/include/linux/sound.h
index 44dcf05..fae20ba 100644
--- a/include/linux/sound.h
+++ b/include/linux/sound.h
@@ -1,3 +1,5 @@
+#ifndef _LINUX_SOUND_H
+#define _LINUX_SOUND_H
 
 /*
  * Minor numbers for the sound driver.
@@ -42,3 +44,5 @@ extern void unregister_sound_mixer(int unit);
 extern void unregister_sound_midi(int unit);
 extern void unregister_sound_dsp(int unit);
 #endif /* __KERNEL__ */
+
+#endif /* _LINUX_SOUND_H */
-- 
1.7.7.4
