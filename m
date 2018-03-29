Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59810 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeC2L0U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:20 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 104/109] net: remove compat_sys_*() prototypes from net/compat.h
Date: Thu, 29 Mar 2018 13:24:21 +0200
Message-ID: <20180329112426.23043-105-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-ID: <20180329112421.ppvDOZuX_rbKivtzS6ZhAMeXgUq2vmkehKMNDjGpMqo@z>

As the syscall functions should only be called from the system call table
but not from elsewhere in the kernel, it is sufficient that they are
defined in linux/compat.h.

Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/net/compat.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/net/compat.h b/include/net/compat.h
index a91bea80b9fc..4c6d75612b6c 100644
--- a/include/net/compat.h
+++ b/include/net/compat.h
@@ -44,17 +44,6 @@ int compat_sock_get_timestampns(struct sock *, struct timespec __user *);
 int get_compat_msghdr(struct msghdr *, struct compat_msghdr __user *,
 		      struct sockaddr __user **, struct iovec **);
 struct sock_fprog __user *get_compat_bpf_fprog(char __user *optval);
-asmlinkage long compat_sys_sendmsg(int, struct compat_msghdr __user *,
-				   unsigned int);
-asmlinkage long compat_sys_sendmmsg(int, struct compat_mmsghdr __user *,
-				    unsigned int, unsigned int);
-asmlinkage long compat_sys_recvmsg(int, struct compat_msghdr __user *,
-				   unsigned int);
-asmlinkage long compat_sys_recvmmsg(int, struct compat_mmsghdr __user *,
-				    unsigned int, unsigned int,
-				    struct compat_timespec __user *);
-asmlinkage long compat_sys_getsockopt(int, int, int, char __user *,
-				      int __user *);
 int put_cmsg_compat(struct msghdr*, int, int, int, void *);
 
 int cmsghdr_from_user_compat_to_kern(struct msghdr *, struct sock *,
-- 
2.16.3
