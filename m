Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDN2I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Apr 2019 09:28:08 -0400
Date: Thu, 4 Apr 2019 09:28:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from
 syscall_get_arguments()
Message-ID: <20190404092803.1bffd135@gandalf.local.home>
In-Reply-To: <20190401134104.676620247@goodmis.org>
References: <20190401134104.676620247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20190404132803.pZQKir1Wdh3YNN0WBXZTdb3fjCl-KiZRlyaWj6fM5LE@z>

On Mon, 01 Apr 2019 09:41:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> [ Looking for acks ]
> 

I got a couple.

> Two and a half years ago I sent out 3 patches and a title letter that
> had this[1]:

Linus,

Is this something that can go into this -rc release or would you want
me to wait till the next merge window?

The reason I ask, is that there's two arch patches in this series that
have stable tags attached to them. But I moved things around such that
they are applied before the global arch patches are and can be applied
independently.

Should I move those two patches up front and just add those to this
release cycle, or would you like the entire series now?

-- Steve


> ----
>  arch/arc/include/asm/syscall.h        |   7 +-
>  arch/arm/include/asm/syscall.h        |  47 ++---------
>  arch/arm64/include/asm/syscall.h      |  46 ++---------
>  arch/c6x/include/asm/syscall.h        |  79 ++++---------------
>  arch/csky/include/asm/syscall.h       |  26 ++-----
>  arch/h8300/include/asm/syscall.h      |  34 ++------
>  arch/hexagon/include/asm/syscall.h    |   4 +-
>  arch/ia64/include/asm/syscall.h       |  13 +---
>  arch/ia64/kernel/ptrace.c             |   7 +-
>  arch/microblaze/include/asm/syscall.h |   8 +-
>  arch/mips/include/asm/syscall.h       |   3 +-
>  arch/mips/kernel/ptrace.c             |   2 +-
>  arch/nds32/include/asm/syscall.h      |  62 +++------------
>  arch/nios2/include/asm/syscall.h      |  84 ++++----------------
>  arch/openrisc/include/asm/syscall.h   |  12 +--
>  arch/parisc/include/asm/syscall.h     |  30 ++-----
>  arch/powerpc/include/asm/syscall.h    |  15 ++--
>  arch/riscv/include/asm/syscall.h      |  24 ++----
>  arch/s390/include/asm/syscall.h       |  28 +++----
>  arch/sh/include/asm/syscall_32.h      |  47 +++--------
>  arch/sh/include/asm/syscall_64.h      |   8 +-
>  arch/sparc/include/asm/syscall.h      |  11 ++-
>  arch/um/include/asm/syscall-generic.h |  78 +++----------------
>  arch/x86/include/asm/syscall.h        | 142 ++++++++--------------------------
>  arch/xtensa/include/asm/syscall.h     |  33 ++------
>  fs/proc/base.c                        |  17 ++--
>  include/asm-generic/syscall.h         |  21 ++---
>  include/linux/ptrace.h                |  11 ++-
>  include/trace/events/syscalls.h       |   2 +-
>  kernel/seccomp.c                      |   2 +-
>  kernel/trace/trace_syscalls.c         |   9 ++-
>  lib/syscall.c                         |  57 ++++++--------
>  32 files changed, 247 insertions(+), 722 deletions(-)
