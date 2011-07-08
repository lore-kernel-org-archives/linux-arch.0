From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 24/39] UAPI: Fix SNDRV_*_ENDIAN ordering problem
Date: Fri, 08 Jul 2011 15:26:49 +0100
Message-ID: <20110708142649.31344.81482.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62638 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1GHO13 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:27:29 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

There's an ordering problem around the definition of SNDRV_*_ENDIAN: the
definition in the kernel-specific header is referred to in the user-specific
header data structures.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/sound/asound.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 5d6074f..e4918f6 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -40,6 +40,7 @@
 #endif
 #endif
 
+// DISINTEGRATE: INCLUDE UAPI HERE
 #endif /* __KERNEL__ **/
 
 /*
