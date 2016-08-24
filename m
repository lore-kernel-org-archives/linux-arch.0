From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v1 7/7] tools: add userspace linker table sandbox
Date: Wed, 24 Aug 2016 09:20:12 -0700
Message-ID: <CAB=NE6W24OTy+6P6=AM=JDngGJvEa9B_afbQxkx7Epx+_CfAWg@mail.gmail.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org> <1471642875-5957-8-git-send-email-mcgrof@kernel.org>
 <CAGXu5jKX-VZR_r9wMsnLAU+Z10vB4yDiRPpvwXbRZj0=wU208A@mail.gmail.com>
 <20160823000739.GX3296@wotan.suse.de> <201608230028.u7N0SneR020502@mail.zytor.com>
 <20160823143028.GA2834@redhat.com> <CAGXu5j+JsFAUJ4AfCvK2FVE3TOOeLjyiOD1Buy-X4oRHu=Cz=A@mail.gmail.com>
 <20160824123903.GA10063@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756689AbcHXQVj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Aug 2016 12:21:39 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 8B082203B5
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2016 16:20:38 +0000 (UTC)
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204E4203B7
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2016 16:20:37 +0000 (UTC)
Received: by mail-ua0-f176.google.com with SMTP id 74so37301914uau.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2016 09:20:37 -0700 (PDT)
In-Reply-To: <20160824123903.GA10063@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Masami Hiramatsu <mhiramat@kernel.org>, jbaron@akamai.com, Heiko Carstens <heiko.carstens@de.ibm.com>, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, "David S. Miller" <davem@davemloft.net>, Miao Steven <realmz6@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Rusty Russell <rusty@rustcorp.com.au>, gnomes@lxorguk.ukuu.

On Wed, Aug 24, 2016 at 5:39 AM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Changes detected by the tools build system:
>
>       $ make -C tools/perf O=/tmp/build/perf install-bin
>       make: Entering directory '/home/acme/git/linux/tools/perf'
>         BUILD:   Doing 'make -j4' parallel build
> --->  Warning: tools/include/uapi/linux/bpf.h differs from kernel <-------
>         INSTALL  GTK UI
>         CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
>       <SNIP>
>       $

I borrowed the same strategy from perf tools and generalized this
through helpers a bit as Makefile helpers in the linker-tables
sandbox:

HEADERS = \
          ../../include/asm-generic/section-core.h \
          ../../include/asm-generic/ranges.h \
          ../../include/asm-generic/tables.h \
          ../../include/linux/sections.h \
          ../../include/linux/ranges.h \
          ../../include/linux/tables.h

__check_headers: $(HEADERS)
        @$(foreach h, $(HEADERS), \
                (test -f $(h) && ( \
                        (diff -B $(subst ../,../,$(h)) $(h) >/dev/null) \
                        || echo "Warning: $(subst ../../,tools/,$(h))
differs from kernel" >&2 ) || true);)


Instead of doing the check / complaint at install it complains at
build time. Its up to the tools to decide when they want this check,
but perhaps later a generic check can be set up. My thought was later
to move some of this as helpers in a generic tools Makefile to more
easily enable other tools/ to do similar checks more easily. I suspect
we may later want to keep a tighter tab on what tools need what
headers and instead have a generic place to keep tabs on this, but we
can do that slowly later after generalizing a checker.

In doing the linker table sandbox one of the needs I found in needing
separate headers was that often you don't want the same copy as the
kernel provides, as you want to port things over to work in userspace
and often ported to libc. So other than the direct copies -- we also
have another category of headers -- ported headers. Its possible not
all tools may end up wanting the same port, this can be addressed
through two means. One is having a generic port which should suffice
for most tools that need libc, and for those that don't want the
generic port they can just carry their own port in their own tree. The
linker tables tools sandbox enables this by allowing first headers to
be search in its own directory, that way it can override what is
provided as generic in tools. However it may still be useful later to
have two separate directories to be able to easily distinguish between
"copies" and "ports". But this can be done later.

Thoughts?

  Luis
