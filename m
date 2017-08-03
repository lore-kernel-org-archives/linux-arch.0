From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v9 0/5] kprobes related bugfix
Date: Thu,  3 Aug 2017 11:33:58 +0900
Message-ID: <150172762859.27216.16741726568669538542.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbdHCCet (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Aug 2017 22:34:49 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, mathieu.desnoyers@efficios.com, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, linux-arch@vger.kernel.org

Hi,

Here are the 9th version of the series to fix kprobes not
to optimize on the functions in irqentry text ([5/5]).
To check the irqentry text always, [4/5] makes irqentry
text section unconditional.

This involves some other cleanups on h8300, xtensa, and
cris ports, because those sources declare section 
start/end symbol as single characters, but generic
sections.h declares it as character arrays. So it leads
build errors if we apply [4/5].

Changes in v9
 - Add cris cleanup patch (3/5).

BTW, in this series I just give a minimum fix for
arch dependent code, since this is a series to fix
a bug in x86 optprobe. However, IMHO, we should
revisit these "local _stext/_etext references" and
replace it with just including asm/sections.h.
And also, I would like to expose is_kernel_text()
as a generic routine for arch dependent code
so that they can use it.

Thank you,

---

Masami Hiramatsu (5):
      h8300: mark _stext and _etext as char-arrays, not single char
      xtensa: mark _stext and _end as char-arrays, not single char
      cris: mark _stext and _end as char-arrays, not single char
      irq: Make irqentry text section unconditional
      [BUGFIX] kprobes/x86: Do not jump-optimize kprobes on irq entry code


 arch/arm/include/asm/traps.h         |    7 -------
 arch/arm64/include/asm/traps.h       |    7 -------
 arch/cris/arch-v32/mach-a3/arbiter.c |    4 ++--
 arch/cris/arch-v32/mach-fs/arbiter.c |    4 ++--
 arch/cris/kernel/traps.c             |    6 +++---
 arch/h8300/include/asm/traps.h       |    6 +++---
 arch/x86/entry/entry_64.S            |    9 ++-------
 arch/x86/kernel/kprobes/opt.c        |    9 ++++++---
 arch/x86/kernel/unwind_frame.c       |    2 --
 arch/xtensa/kernel/setup.c           |    6 +++---
 include/asm-generic/sections.h       |    4 ++++
 include/asm-generic/vmlinux.lds.h    |    8 --------
 include/linux/interrupt.h            |   14 +-------------
 13 files changed, 26 insertions(+), 60 deletions(-)
