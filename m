From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 07/40] metag: Add MAINTAINERS entry
Date: Wed, 31 Oct 2012 16:13:48 +0000
Message-ID: <1351700061-7203-8-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49628 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935765Ab2JaQOs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:14:48 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

Add MAINTAINERS entry for the metag architecture. Will and myself will
be maintaining it between us.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Will Newton <will.newton@imgtec.com>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a6c4da..e1d8299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4530,6 +4530,14 @@ F:	drivers/mtd/
 F:	include/linux/mtd/
 F:	include/mtd/
 
+METAG ARCHITECTURE
+M:	James Hogan <james.hogan@imgtec.com>
+M:	Will Newton <will.newton@imgtec.com>
+S:	Maintained
+F:	arch/metag/
+F:	Documentation/metag/
+F:	Documentation/devicetree/bindings/metag/
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 L:	microblaze-uclinux@itee.uq.edu.au (moderated for non-subscribers)
-- 
1.7.7.6
