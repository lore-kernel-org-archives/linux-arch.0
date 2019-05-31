Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37023 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfEaT44 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 15:56:56 -0400
MIME-Version: 1.0
References: <20190531191204.4044-1-palmer@sifive.com> <20190531191204.4044-4-palmer@sifive.com>
In-Reply-To: <20190531191204.4044-4-palmer@sifive.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2019 21:56:39 +0200
Message-ID: <CAK8P3a2=xko56LbwV4tyhyyyX+tw+EV-NGavYEYj0q61t=mnwg@mail.gmail.com>
Subject: Re: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20190531195639.bQFFmM94jiBUTsUZueRmRz-8dMwGE-Hfr3s36uvx338@z>

On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

As usual, each patch needs a changelog text. I would prefer having a single
patch here that changes /all/ system call tables at once, rather than doing one
at a time like we used to.

In linux-next, we are at number 434 now, and there are a couple of other
new system calls being proposed right now (more than usual), so you may
have to change the number a few times.

Note: most architectures use .tbl files now, the exceptions are
include/uapi/asm-generic/unistd.h and arch/arm64/include/asm/unistd32.h,
and the latter also requires changing __NR_compat_syscalls in asm/unistd.h.

Numbers should now be the same across architectures, except for alpha,
which has a +110 offset. We have discussed ways to have a single
file to modify for a new call on all architectures, but no patches yet.

     Arnd
