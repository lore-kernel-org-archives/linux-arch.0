Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34143 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387447AbfFKODj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jun 2019 10:03:39 -0400
MIME-Version: 1.0
References: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
In-Reply-To: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Jun 2019 16:03:21 +0200
Message-ID: <CAK8P3a34Ba+VAzY_-CsVN+tRjk2nCbCiHo=oQq0am6QKKw93Rw@mail.gmail.com>
Subject: Re: [RFC PATCH] Add script to add/remove/rename/renumber syscalls and
 resolve conflicts
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Firoz Khan <firoz.khan@linaro.org>, Nitesh Kataria <nitesh.kataria@linaro.org>
Message-ID: <20190611140321.Y4wDsOcOAxy5n4NCFylijEzX4tePSgQLFZVg0MptQGM@z>

On Tue, Jun 11, 2019 at 3:27 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a script that simplifies the process of altering system call tables in
> the kernel sources.  It has five functions available:

Ah, fun. You had already threatened to add that script in the past.
The implementation of course looks fine, I was just hoping we could
instead eliminate the need for it first.

> +    { file     => "arch/mips/kernel/syscalls/syscall_n32.tbl",
> +      pattern  => "%NUM n32 %NAME sys_%NAME",
> +      compat   => 0 },
> +    { file     => "arch/mips/kernel/syscalls/syscall_n32.tbl",
> +      pattern  => "%NUM n32 %NAME compat_sys_%NAME",
> +      compat   => 1 },
> +    { file     => "arch/mips/kernel/syscalls/syscall_n64.tbl",
> +      pattern  => "%NUM n64 %NAME sys_%NAME" },
> +    { file     => "arch/mips/kernel/syscalls/syscall_o32.tbl",

My preferred way forward for mips n32/n64 would be to merge the
two files and put the n32 stuff into the compat side, with the
middle 100 or so syscalls using '32' and '64' as the ABI since
their numbers diverged at some point.

> +      pattern  => "%NUM o32 %NAME sys_%NAME",
> +      compat   => 0 },
> +    { file     => "arch/mips/kernel/syscalls/syscall_o32.tbl",
> +      pattern  => "%NUM o32 %NAME sys_%NAME compat_sys_%NAME",
> +      compat   => 1 },

For o32, I guess we can just use 'common' in the whole file'.

> +    { file     => "arch/x86/entry/syscalls/syscall_32.tbl",
> +      pattern  => "%NUM i386 %NAME sys_%NAME __ia32_sys_%NAME",
> +      widths   => [ 8, 8, 24, 32, 32],
> +      compat   => 0 },
> +    { file     => "arch/x86/entry/syscalls/syscall_32.tbl",
> +      pattern  => "%NUM i386 %NAME sys_%NAME __ia32_compat_sys_%NAME",
> +      widths   => [ 8, 8, 24, 32, 32],
> +      compat   => 1 },
> +    { file     => "arch/x86/entry/syscalls/syscall_64.tbl",
> +      pattern  => "%NUM common %NAME __x64_sys_%NAME",
> +      widths   => [ 8, 8, 24, 32, 32] },

In case of x86, there are three differences from the normal format,
and both are unnecessary now:

- the __ia32 and __x64 prefixes can easily be added from the
  __SYSCALL_I386 and __SYSCALL_64 macros, for x32
  something similar can be done with a little bit of rework,
  or we skip that since it was decided that there won't be any
  additional x32 syscalls

- The "/ptregs" flag in some calls was added to enable an
  optimization, but that optimization is already removed again,
  so this no longer servers any purpose.

- The whitespace difference can be trivially changed to the common
  version.

> +    # Find the __NR_syscalls value.
> +    for ($i = 0; $i <= $#{$lines}; $i++) {
> +       my $l = $lines->[$i];
> +       if ($l =~ /^#define\s+__NR_syscalls\s+([0-9]+)/) {
> +           die "$f:$i: Redefinition of __NR_syscalls\n" if ($i_nr != -1);
> +           $nr = $1;
> +           $i_nr = $i;
>       }
>   }

Firoz and Nitesh have worked on a syscall.tbl file to replace
the asm-generic/unistd.h file. Firoz had an earlier version before the
time64 syscall changes that made it more complicated, so this
still needs a rebase that I thought Nitesh wanted to post but
hasn't done yet.

The same series should also contain the corresponding conversion
of arch/arm64/include/asm/unistd32.h.

My plan was to eventually use the combination of two syscall.tbl
files as input for the scripts: one architecture specific file for
numbers below 403 (plus the x32 specific ones), and another
generic file for all new numbers. I have not actually implemented
any of that though.

       Arnd
