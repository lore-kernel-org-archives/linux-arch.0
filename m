From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 23/39] UAPI: sound/sound_core.c should include
 linux/fs.h
Date: Fri, 08 Jul 2011 15:26:41 +0100
Message-ID: <20110708142640.31344.9332.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26006 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1GHO1Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:27:24 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

sound/sound_core.c should include linux/fs.h to get the definition of struct
file_operations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 sound/sound_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 6ce2778..b6bc127 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/kdev_t.h>
 #include <linux/major.h>
+#include <linux/fs.h>
 #include <sound/core.h>
 
 #ifdef CONFIG_SOUND_OSS_CORE
