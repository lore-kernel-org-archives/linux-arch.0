From: David Howells <dhowells@redhat.com>
Subject: [PATCH 16/35] UAPI: Fix linux/netfilter.h inclusion order
Date: Sat, 02 Jul 2011 12:09:52 +0100
Message-ID: <20110702110952.21948.74186.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18366 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLJz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:09:55 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B9sV2018785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:09:55 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Fix linux/netfilter.h inclusion order to make sure that the inclusion of the
user-specific file happens after the inclusion of the header file that
provides struct in_addr and struct in6_addr.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/netfilter.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 857f502..4faf53d 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -15,6 +15,8 @@
 #include <linux/compiler.h>
 #include <linux/sysctl.h>
 
+// DISINTEGRATE: INCLUDE UAPI HERE
+
 /* Responses from hook functions. */
 #define NF_DROP 0
 #define NF_ACCEPT 1
