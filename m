From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 02/11] signal/sh: Ensure si_signo is initialized in do_divide_error
Date: Thu, 11 Jan 2018 18:59:31 -0600
Message-ID: <20180112005940.23279-2-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Set si_signo.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 0983b31849bb ("sh: Wire up division and address error exceptions on SH-2A.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/kernel/traps_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 57cff00cad17..b3770bb26211 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -609,7 +609,8 @@ asmlinkage void do_divide_error(unsigned long r4)
 		break;
 	}
 
-	force_sig_info(SIGFPE, &info, current);
+	info.si_signo = SIGFPE;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
 
-- 
2.14.1
