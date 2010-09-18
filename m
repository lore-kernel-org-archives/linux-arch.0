Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39380 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab0IRTlg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2010 15:41:36 -0400
Date: Sat, 18 Sep 2010 20:41:35 +0100
Subject: [PATCH 1/5] frv: restart_block.fn needs to be reset on sigreturn
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <E1Ox3Hz-0006R7-As@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <20100918194135.dLhrfHKFAruUl1Yg2ptvXByThsXC6xUbnlGp-seTraY@z>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/frv/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
index 0974c0e..7fc2961 100644
--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -121,6 +121,9 @@ static int restore_sigcontext(struct sigcontext __user *sc, int *_gr8)
 	struct user_context *user = current->thread.user;
 	unsigned long tbr, psr;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	tbr = user->i.tbr;
 	psr = user->i.psr;
 	if (copy_from_user(user, &sc->sc_context, sizeof(sc->sc_context)))
-- 
1.5.6.5


