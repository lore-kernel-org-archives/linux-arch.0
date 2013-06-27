From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: cris: mm: add a code block for variable declaration
Date: Thu, 27 Jun 2013 14:43:55 +0800
Message-ID: <51CBDF2B.8090304@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: starvik@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, shaohua.li@fusionio.com, linux-cris-kernel@axis.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Need a code block for variable declaration, or can not pass compiling
by old C compiler.

The new C compiler will report the warning (with allmodconfig):

  arch/cris/mm/fault.c: In function =91do_page_fault=92:
  arch/cris/mm/fault.c:228:3: warning: ISO C90 forbids mixed declaratio=
ns and code [-Wdeclaration-after-statement]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/cris/mm/fault.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c
index 73312ab..919ab17c 100644
--- a/arch/cris/mm/fault.c
+++ b/arch/cris/mm/fault.c
@@ -225,8 +225,10 @@ retry:
 			show_registers(regs);
=20
 #ifdef CONFIG_NO_SEGFAULT_TERMINATION
-		DECLARE_WAIT_QUEUE_HEAD(wq);
-		wait_event_interruptible(wq, 0 =3D=3D 1);
+		{
+			DECLARE_WAIT_QUEUE_HEAD(wq);
+			wait_event_interruptible(wq, 0 =3D=3D 1);
+		}
 #else
 		info.si_signo =3D SIGSEGV;
 		info.si_errno =3D 0;
--=20
1.7.7.6
