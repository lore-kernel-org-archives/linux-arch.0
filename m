From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/5] frv: restart_block.fn needs to be reset on sigreturn
Date: Sat, 18 Sep 2010 20:41:35 +0100
Message-ID: <E1Ox3Hz-0006R7-As@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


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
