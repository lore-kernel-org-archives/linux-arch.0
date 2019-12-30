Return-Path: <SRS0=aRn0=2U=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfL3IXy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:23:54 -0500
From: guoren@kernel.org
Subject: [PATCH 1/5] MAINTAINERS: csky: Add mailing list for csky
Date: Mon, 30 Dec 2019 16:23:27 +0800
Message-ID: <20191230082331.30976-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20191230082327.3VsFMbnVInLYERutlf3Zi5Uz0WrIxFvZeJCzHTeSglU@z>

From: Guo Ren <ren_guo@c-sky.com>

Add mailing list and it's convenient for maintain C-SKY
subsystem.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..1b0e8dcefb94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3553,6 +3553,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.17.0
