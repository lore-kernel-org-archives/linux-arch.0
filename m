Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3885 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761230AbZLJR3O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 12:29:14 -0500
From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/5] mn10300: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 09:28:17 -0800
Message-ID: <1260466101-17545-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4B212EEC.3060808@caviumnetworks.com>
References: <4B212EEC.3060808@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, David Daney <ddaney@caviumnetworks.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com
Message-ID: <20091210172817.EVmSpm8M_9yJTXhPxrIpxmm7KDV43ajr37pwSsGoEkk@z>

Use the new unreachable() macro instead of while(1).

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: David Howells <dhowells@redhat.com>
CC: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
CC: linux-am33-list@redhat.com
---
 arch/mn10300/include/asm/bug.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mn10300/include/asm/bug.h b/arch/mn10300/include/asm/bug.h
index aa6a388..447a7e6 100644
--- a/arch/mn10300/include/asm/bug.h
+++ b/arch/mn10300/include/asm/bug.h
@@ -27,7 +27,8 @@ do {								\
 		:						\
 		: "i"(__FILE__), "i"(__LINE__)			\
 		);						\
-} while (1)
+	unreachable();						\
+} while (0)
 
 #define HAVE_ARCH_BUG
 #endif /* CONFIG_BUG */
-- 
1.6.2.5

