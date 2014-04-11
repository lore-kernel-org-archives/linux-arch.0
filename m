Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:53732 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741AbaDKK0K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:10 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so3929708eek.8
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:08 -0700 (PDT)
From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 01/15] i386: add renameat2 syscall
Date: Fri, 11 Apr 2014 12:25:37 +0200
Message-ID: <1397211951-20549-2-git-send-email-miklos@szeredi.hu>
In-Reply-To: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20140411102537.GUJNhl7f7gbWMepWQxK2Gr8AddV2UVwignyCYMVVbMk@z>

From: Miklos Szeredi <mszeredi@suse.cz>

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/syscalls/syscall_32.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/syscalls/syscall_32.tbl b/arch/x86/syscalls/syscall_32.tbl
index 96bc506ac6de..d6b867921612 100644
--- a/arch/x86/syscalls/syscall_32.tbl
+++ b/arch/x86/syscalls/syscall_32.tbl
@@ -359,3 +359,4 @@
 350	i386	finit_module		sys_finit_module
 351	i386	sched_setattr		sys_sched_setattr
 352	i386	sched_getattr		sys_sched_getattr
+353	i386	renameat2		sys_renameat2
-- 
1.8.1.4

