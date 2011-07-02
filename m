From: David Howells <dhowells@redhat.com>
Subject: [PATCH 35/35] UAPI: Fix the page-types query program in the docs
Date: Sat, 02 Jul 2011 12:12:42 +0100
Message-ID: <20110702111241.21948.51753.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLMp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:12:45 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BCjmP016873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:12:45 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Fix the page-types query program in Documentation/vm/ as that refers to the
magic numbers header file directly, but the magic numbers are now in the UAPI
headers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/vm/page-types.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/vm/page-types.c b/Documentation/vm/page-types.c
index 7445caa..658ec74 100644
--- a/Documentation/vm/page-types.c
+++ b/Documentation/vm/page-types.c
@@ -34,7 +34,7 @@
 #include <sys/fcntl.h>
 #include <sys/mount.h>
 #include <sys/statfs.h>
-#include "../../include/linux/magic.h"
+#include "../../uapi/linux/magic.h"
 
 
 #ifndef MAX_PATH
