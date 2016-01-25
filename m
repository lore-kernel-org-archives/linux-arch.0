Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49863 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932821AbcAYWYx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jan 2016 17:24:53 -0500
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 10/16] net/xfrm_user: Use in_compat_syscall to deny compat syscalls
Date: Mon, 25 Jan 2016 14:24:24 -0800
Message-ID: <ba8cd4d5f06bead4294ac3ff26e2b76d10536d83.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
Message-ID: <20160125222424.lVl1hYJX_WMs_86QYLkdn-xwkFEQZtSEBLlyIsbz-qk@z>

The code wants to prevent compat code from receiving messages.  Use
in_compat_syscall for this.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 805681a7d356..2cc7af858c6f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2449,7 +2449,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	int type, err;
 
 #ifdef CONFIG_COMPAT
-	if (is_compat_task())
+	if (in_compat_syscall())
 		return -ENOTSUPP;
 #endif
 
-- 
2.5.0

