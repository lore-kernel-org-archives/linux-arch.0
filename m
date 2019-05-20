Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfETDai (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 May 2019 23:30:38 -0400
From: guoren@kernel.org
Subject: [PATCH] MAINTAINERS: Add mailing list for csky architecture
Date: Mon, 20 May 2019 11:27:59 +0800
Message-ID: <1558322879-12358-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com, han_mao@c-sky.com, yibin_liu@c-sky.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arnd.de, linux-csky@vger.kernel.org
Message-ID: <20190520032759.QNecKxMK_hWHj-VH4V0jacHPBp3ZKDPKt7H8MYcd5QM@z>

From: Guo Ren <ren_guo@c-sky.com>

Add the newly created linux-csky@vger.kernel.org mailing list for patch
reviews and discussions.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4..b5fadcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3474,6 +3474,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.7.4
