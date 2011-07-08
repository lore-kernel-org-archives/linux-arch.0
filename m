From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 28/39] UAPI: Guard linux/sound.h
Date: Fri, 08 Jul 2011 15:27:31 +0100
Message-ID: <20110708142731.31344.1398.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab1GHO2O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:28:14 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Place reinclusion guards on linux/sound.h otherwise the splitter script won't
insert a #include_next.

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
