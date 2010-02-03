From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] cris/arch-v10: don't clear TIF_SYSCALL_TRACE in ptrace_disable
Date: Wed, 3 Feb 2010 10:03:59 +0100
Message-ID: <20100203090359.GA30339@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:52689 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab0BCJEB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Feb 2010 04:04:01 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: starvik@axis.com, jesper.nilsson@axis.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

The flag is already cleared by the only caller directly after the call to
ptrace_disable.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/cris/arch-v10/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/kernel/ptrace.c	2010-02-03 09:59:31.935004127 +0100
+++ linux-2.6/arch/cris/arch-v10/kernel/ptrace.c	2010-02-03 09:59:41.196068227 +0100
@@ -64,8 +64,6 @@ inline int put_reg(struct task_struct *t
 void 
 ptrace_disable(struct task_struct *child)
 {
-       /* Todo - pending singlesteps? */
-       clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 /* 
