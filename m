From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] compat: Fix RT signal mask corruption via sigprocmask
Date: Wed, 09 May 2012 19:09:59 -0300
Message-ID: <4FAAEB37.1080001@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Tokarev <mjt@tls.msk.ru>, Anthony Liguori <aliguori@us.ibm.com>, Kevin Wolf <kwolf@redhat.com>
List-Id: linux-arch.vger.kernel.org

compat_sys_sigprocmask reads a smaller signal mask from userspace than
sigprogmask accepts for setting. So the high word of blocked.sig[0] will
be cleared, releasing any potentially blocked RT signal.

This was discovered via userspace code that relies on get/setcontext.
glibc's i386 versions of those functions use sigprogmask instead of
rt_sigprogmask to save/restore the signal mask and caused RT signal
unblocking this way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/compat.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/compat.c b/kernel/compat.c
index 74ff849..03e491d 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -381,6 +381,8 @@ asmlinkage long compat_sys_sigprocmask(int how, compat_old_sigset_t __user *set,
 
 	if (set && get_user(s, set))
 		return -EFAULT;
+	s |= current->blocked.sig[0] &
+		~((old_sigset_t)(compat_old_sigset_t)-1);
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_sigprocmask(how,
-- 
1.7.3.4
