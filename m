Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3882 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761225AbZLJR3O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 12:29:14 -0500
From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/5] blackfin: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 09:28:21 -0800
Message-ID: <1260466101-17545-5-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4B212EEC.3060808@caviumnetworks.com>
References: <4B212EEC.3060808@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, David Daney <ddaney@caviumnetworks.com>, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org
Message-ID: <20091210172821.r5HVjgg4Do9NmYyhhOlucY8Bt2LlA3jlebh_o9vRlnU@z>

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Mike Frysinger <vapier@gentoo.org>
CC: uclinux-dist-devel@blackfin.uclinux.org
---
 arch/blackfin/include/asm/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/blackfin/include/asm/bug.h b/arch/blackfin/include/asm/bug.h
index 6f4548a..75f6dc3 100644
--- a/arch/blackfin/include/asm/bug.h
+++ b/arch/blackfin/include/asm/bug.h
@@ -47,7 +47,7 @@
 #define BUG()								\
 	do {								\
 		_BUG_OR_WARN(0);					\
-		for (;;);						\
+		unreachable();						\
 	} while (0)
 
 #define WARN_ON(condition)							\
-- 
1.6.2.5

