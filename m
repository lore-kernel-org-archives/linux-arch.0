From: David Howells <dhowells@redhat.com>
Subject: [PATCH 21/35] UAPI: sound/sound_core.c should include linux/fs.h
Date: Sat, 02 Jul 2011 12:10:36 +0100
Message-ID: <20110702111036.21948.57314.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1GBLKk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:10:40 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BAe1r016674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:10:40 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
