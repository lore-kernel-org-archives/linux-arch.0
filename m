Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:48185 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeAPAlg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:41:36 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 15 Jan 2018 18:39:51 -0600
Message-ID: <20180116004009.31036-4-ebiederm@xmission.com>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Subject: [PATCH 04/22] signal: Ensure no siginfo union member increases the size of struct siginfo
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180116003951.7QKqRVYhZdSowCwquJBAgi1-g3vwivJXBW3Rw9WxYq0@z>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 241d54958bbb..b9e5d825ee46 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3688,6 +3688,7 @@ void __init signals_init(void)
 	/* If this check fails, the __ARCH_SI_PREAMBLE_SIZE value is wrong! */
 	BUILD_BUG_ON(__ARCH_SI_PREAMBLE_SIZE
 		!= offsetof(struct siginfo, _sifields._pad));
+	BUILD_BUG_ON(sizeof(struct siginfo) != SI_MAX_SIZE);
 
 	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC);
 }
-- 
2.14.1
