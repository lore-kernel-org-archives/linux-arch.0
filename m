Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46522 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754544AbYBEKOa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2008 05:14:30 -0500
Date: Tue, 5 Feb 2008 02:13:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix timerfd breakage on avr32
Message-Id: <20080205021347.4785ca44.akpm@linux-foundation.org>
In-Reply-To: <20080205110347.62cf2925@dhcp-252-066.norway.atmel.com>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org>
	<20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
	<20080205110347.62cf2925@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: torvalds@linux-foundation.org, davidel@xmailserver.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de, Hirokazu Takata <takata@linux-m32r.org>, Paul Mundt <lethal@linux-sh.org>

On Tue, 5 Feb 2008 11:03:47 +0100 Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> On Tue, 5 Feb 2008 10:54:54 +0100
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> 
> > The next time you go and remove a system call, could you _please_ post
> > a HUGE warning to linux-arch? Or just do a quick grep and fix it up.
> 
> Btw, a quick grep through 2.6.24-mm1 shows
> 
> arch/frv/kernel/entry.S:	.long sys_timerfd
> arch/m32r/kernel/syscall_table.S:	.long sys_timerfd
> arch/sh/kernel/syscalls_32.S:	.long sys_timerfd
> arch/sh/kernel/syscalls_64.S:	.long sys_timerfd		/* 350 */
> 
> so frv, m32r and sh are probably broken too.
> 

argh. After fixing so many architectures I asked for a grepped
fix :(


This?


 arch/frv/kernel/entry.S          |    2 +-
 arch/m32r/kernel/syscall_table.S |    2 +-
 arch/sh/kernel/syscalls_32.S     |    2 +-
 arch/sh/kernel/syscalls_64.S     |    2 +-
 include/asm-frv/unistd.h         |    2 +-
 include/asm-m32r/unistd.h        |    2 +-
 include/asm-sh/unistd_32.h       |    2 +-
 include/asm-sh/unistd_64.h       |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff -puN arch/frv/kernel/entry.S~timerfd-fix-remaining-architectures arch/frv/kernel/entry.S
--- a/arch/frv/kernel/entry.S~timerfd-fix-remaining-architectures
+++ a/arch/frv/kernel/entry.S
@@ -1494,7 +1494,7 @@ sys_call_table:
 	.long sys_epoll_pwait
 	.long sys_utimensat		/* 320 */
 	.long sys_signalfd
-	.long sys_timerfd
+	.long sys_ni_syscall
 	.long sys_eventfd
 	.long sys_fallocate
 
diff -puN arch/m32r/kernel/syscall_table.S~timerfd-fix-remaining-architectures arch/m32r/kernel/syscall_table.S
--- a/arch/m32r/kernel/syscall_table.S~timerfd-fix-remaining-architectures
+++ a/arch/m32r/kernel/syscall_table.S
@@ -321,6 +321,6 @@ ENTRY(sys_call_table)
 	.long sys_epoll_pwait
 	.long sys_utimensat		/* 320 */
 	.long sys_signalfd
-	.long sys_timerfd
+	.long sys_ni_syscall
 	.long sys_eventfd
 	.long sys_fallocate
diff -puN arch/sh/kernel/syscalls_32.S~timerfd-fix-remaining-architectures arch/sh/kernel/syscalls_32.S
--- a/arch/sh/kernel/syscalls_32.S~timerfd-fix-remaining-architectures
+++ a/arch/sh/kernel/syscalls_32.S
@@ -338,6 +338,6 @@ ENTRY(sys_call_table)
 	.long sys_epoll_pwait
 	.long sys_utimensat		/* 320 */
 	.long sys_signalfd
-	.long sys_timerfd
+	.long sys_ni_syscall
 	.long sys_eventfd
 	.long sys_fallocate
diff -puN arch/sh/kernel/syscalls_64.S~timerfd-fix-remaining-architectures arch/sh/kernel/syscalls_64.S
--- a/arch/sh/kernel/syscalls_64.S~timerfd-fix-remaining-architectures
+++ a/arch/sh/kernel/syscalls_64.S
@@ -376,6 +376,6 @@ sys_call_table:
 	.long sys_epoll_pwait
 	.long sys_utimensat
 	.long sys_signalfd
-	.long sys_timerfd		/* 350 */
+	.long sys_ni_syscall		/* 350 */
 	.long sys_eventfd
 	.long sys_fallocate
diff -puN include/asm-frv/unistd.h~timerfd-fix-remaining-architectures include/asm-frv/unistd.h
--- a/include/asm-frv/unistd.h~timerfd-fix-remaining-architectures
+++ a/include/asm-frv/unistd.h
@@ -328,7 +328,7 @@
 #define __NR_epoll_pwait	319
 #define __NR_utimensat		320
 #define __NR_signalfd		321
-#define __NR_timerfd		322
+/* #define __NR_timerfd		322 removed */
 #define __NR_eventfd		323
 #define __NR_fallocate		324
 
diff -puN include/asm-m32r/unistd.h~timerfd-fix-remaining-architectures include/asm-m32r/unistd.h
--- a/include/asm-m32r/unistd.h~timerfd-fix-remaining-architectures
+++ a/include/asm-m32r/unistd.h
@@ -327,7 +327,7 @@
 #define __NR_epoll_pwait	319
 #define __NR_utimensat		320
 #define __NR_signalfd		321
-#define __NR_timerfd		322
+/* #define __NR_timerfd		322 removed */
 #define __NR_eventfd		323
 #define __NR_fallocate		324
 
diff -puN include/asm-sh/unistd.h~timerfd-fix-remaining-architectures include/asm-sh/unistd.h
diff -puN include/asm-sh/unistd_32.h~timerfd-fix-remaining-architectures include/asm-sh/unistd_32.h
--- a/include/asm-sh/unistd_32.h~timerfd-fix-remaining-architectures
+++ a/include/asm-sh/unistd_32.h
@@ -330,7 +330,7 @@
 #define __NR_epoll_pwait	319
 #define __NR_utimensat		320
 #define __NR_signalfd		321
-#define __NR_timerfd		322
+/* #define __NR_timerfd		322 removed */
 #define __NR_eventfd		323
 #define __NR_fallocate		324
 
diff -puN include/asm-sh/unistd_64.h~timerfd-fix-remaining-architectures include/asm-sh/unistd_64.h
--- a/include/asm-sh/unistd_64.h~timerfd-fix-remaining-architectures
+++ a/include/asm-sh/unistd_64.h
@@ -370,7 +370,7 @@
 #define __NR_epoll_pwait	347
 #define __NR_utimensat		348
 #define __NR_signalfd		349
-#define __NR_timerfd		350
+/* #define __NR_timerfd		350 removed */
 #define __NR_eventfd		351
 #define __NR_fallocate		352
 
_

