From: arnd@arndb.de
Subject: [RFC 14/17] syscalls.h add the missing sys_pipe2 declaration
Date: Mon, 27 Apr 2009 17:01:28 +0200
Message-ID: <20090427150319.552430713@arndb.de>
References: <20090427142010.587518220@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63987 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbZD0PH1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2009 11:07:27 -0400
Content-Disposition: inline; filename=0034-Add-the-missing-sys_pipe2-declaration.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: john.williams@petalogix.com, monstr@monstr.eu, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, liqin.chen@sunplusct.com, Sam Ravnborg <sam@ravnborg.org>, Remis Lima Baima <remis.developer@googlemail.com>

In order to build the generic syscall table, we need a declaration
for every system call. sys_pipe2 was added without a proper declaration,
so add this to syscalls.h now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h |    1 	1 +	0 -	0 !
 1 file changed, 1 insertion(+)

Index: linux-2.6/include/linux/syscalls.h
===================================================================
--- linux-2.6.orig/include/linux/syscalls.h
+++ linux-2.6/include/linux/syscalls.h
@@ -433,6 +433,7 @@ asmlinkage long sys_fcntl(unsigned int f
 asmlinkage long sys_fcntl64(unsigned int fd,
 				unsigned int cmd, unsigned long arg);
 #endif
+asmlinkage long sys_pipe2(int __user *fildes, int flags);
 asmlinkage long sys_dup(unsigned int fildes);
 asmlinkage long sys_dup2(unsigned int oldfd, unsigned int newfd);
 asmlinkage long sys_dup3(unsigned int oldfd, unsigned int newfd, int flags);

-- 
