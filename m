From: David Howells <dhowells@redhat.com>
Subject: [PATCH 22/35] UAPI: Fix SNDRV_*_ENDIAN ordering problem
Date: Sat, 02 Jul 2011 12:10:45 +0100
Message-ID: <20110702111045.21948.7655.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1GBLKt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:10:49 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BAnck029224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:10:49 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
