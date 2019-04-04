Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbfDDVGO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Apr 2019 17:06:14 -0400
Date: Thu, 4 Apr 2019 17:06:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
Message-ID: <20190404170608.25cadc7d@gandalf.local.home>
In-Reply-To: <20190404181758.GA8071@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
        <20190401134421.278590567@goodmis.org>
        <20190404181758.GA8071@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Palmer Dabbelt <palmer@sifive.com>, Dave Martin <dave.martin@arm.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Message-ID: <20190404210608.d4DGkD4sL8Payh7DDOxsB4KQZKjGykuE9abWnhrMIYE@z>

On Thu, 4 Apr 2019 21:17:58 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> There are several places listed below where I'd prefer to see more readable
> equivalents, but feel free to leave it to respective arch maintainers.

I was going to do similar changes, but figured I'd do just that (let
the arch maintainers further optimize the code). I made this more about
fixing the interface and less about the optimization and clean ups that
it can allow.

-- Steve
