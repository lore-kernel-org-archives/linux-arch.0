From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] signal/sh: Stop gcc warning about an impossible case in do_divide_error
Date: Tue, 29 May 2018 10:00:42 -0500
Message-ID: <87h8mqo6at.fsf_-_@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-16-ebiederm@xmission.com>
        <20180420145514.GP3094@brightrain.aerifal.cx>
        <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 28 May 2018 11:19:55 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


Geert Uytterhoeven <geert@linux-m68k.org> reported:
>   HOSTLD  scripts/mod/modpost
>   CC      arch/sh/kernel/traps_32.o
> arch/sh/kernel/traps_32.c: In function 'do_divide_error':
> arch/sh/kernel/traps_32.c:606:17: error: 'code' may be used uninitialized in this function [-Werror=uninitialized]
> cc1: all warnings being treated as errors

It is clear from inspection that do_divide_error is only called with
TRAP_DIVZERO_ERROR or TRAP_DIVOVF_ERROR, as that is the way
set_exception_table_vec is called.  So let gcc know the other cases
should not be considered by returning in all other cases.

This removes the warning and let's the code continue to build.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: c65626c0cd4d ("signal/sh: Use force_sig_fault where appropriate")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I am adding this fix to my tree to at least let the code build.

 arch/sh/kernel/traps_32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 660a4bc17698..60709ad17fc7 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -602,6 +602,9 @@ asmlinkage void do_divide_error(unsigned long r4)
 	case TRAP_DIVOVF_ERROR:
 		code = FPE_INTOVF;
 		break;
+	default:
+		/* Let gcc know unhandled cases don't make it past here */
+		return;
 	}
 	force_sig_fault(SIGFPE, code, NULL, current);
 }
-- 
2.14.1
