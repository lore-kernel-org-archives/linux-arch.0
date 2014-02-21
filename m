From: Juan Emilio Ledesma Torres <jueleto@gmail.com>
Subject: [BUG] Build error due -fstack-protector-strong not supported by compiler
Date: Fri, 21 Feb 2014 20:47:20 -0300
Message-ID: <CAEZm4MLr-Eic7uaiDd+KdbJsFsqrSd5AkKX7HHoSQUQ0AyRxyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50760 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaBUXrV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2014 18:47:21 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so5031029obc.36
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2014 15:47:20 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, "Cc: Arjan van de Ven" <arjan@linux.intel.com>, "Cc: Michal Marek" <mmarek@suse.cz>, "Cc: Russell King" <linux@arm.linux.org.uk>, "Cc: Ralf Baechle" <ralf@linux-mips.org>, "Cc: Paul Mundt" <lethal@linux-sh.org>, "Cc: James Hogan" <james.hogan@imgtec.com>, "Cc: Stephen Rothwell" <sfr@canb.auug.org.au>, "Cc: Shawn Guo" <shawn.guo@linaro.org>, "Cc: Linus Torvalds" <torvalds@linux-foundation.org>, "Cc: Andrew Morton" <akpm@linux-foundation.org>, "Cc: Peter Zijlstra" <peterz@infradead.org>, "Cc: Thomas Gleixner" <tglx@linutronix.de>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org

Hello,

When building latest Torvalds tree (HEAD d158fc7f) on a x86_64 machine
using the attached defconfig I got the following build error:

/home/pc12/linux/arch/x86/Makefile:118: stack-protector enabled but
compiler support broken
Makefile:614: Cannot use CONFIG_CC_STACKPROTECTOR_STRONG:
-fstack-protector-strong not supported by compiler

Makefile:614: Cannot use CONFIG_CC_STACKPROTECTOR_STRONG:
-fstack-protector-strong not supported by compiler
make[1]: No se hace nada para <<all>>.
make[1]: No se hace nada para <<relocs>>.
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CC      kernel/bounds.s
cc1: error: the command line option is not recognized '-fstack-protector-strong'
make[1]: *** [kernel/bounds.s] Error 1
make: *** [prepare0] Error 2

I had already reported the bug on bugzilla [0] but I'm also reporting
here for completeness.

Bisecting this break was introduced on commit 19952a92
("stackprotector: Unify the HAVE_CC_STACKPROTECTOR logic between
architectures")

I don't know if this problem is with the above commit or with my
compiler (gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3)

[0]: https://bugzilla.kernel.org/show_bug.cgi?id=70951

-- 

Best regards,
Juan Ledesma
