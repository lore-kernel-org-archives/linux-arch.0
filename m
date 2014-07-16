Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38691 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaGPUlx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jul 2014 16:41:53 -0400
Received: by mail-ig0-f178.google.com with SMTP id uq10so1504141igb.17
        for <linux-arch@vger.kernel.org>; Wed, 16 Jul 2014 13:41:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
Date: Wed, 16 Jul 2014 13:41:52 -0700
Message-ID: <CAGXu5jJx8Wk-pZvhJY4xA=oywCZDLH3CLiLZ0wrBVqEqSaYT4A@mail.gmail.com>
Subject: Re: [PATCH 0/7] Two-phase seccomp and x86 tracing changes
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, James Morris <james.l.morris@oracle.com>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>
Message-ID: <20140716204152.b8BC-AamFZYXokDR5CO5R0fSVguAi82MeUX5s4y2dZM@z>

On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> This is both a cleanup and a speedup.  It reduces overhead due to
> installing a trivial seccomp filter by 87%.  The speedup comes from
> avoiding the full syscall tracing mechanism for filters that don't
> return SECCOMP_RET_TRACE.
>
> This series works by splitting the seccomp hooks into two phases.
> The first phase evaluates the filter; it can skip syscalls, allow
> them, kill the calling task, or pass a u32 to the second phase.  The
> second phase requires a full tracing context, and it sends ptrace
> events if necessary.
>
> Once this is done, I implemented a similar split for the x86 syscall
> entry work.  The C callback is invoked in two phases: the first has
> only a partial frame, and it can request phase 2 processing with a
> full frame.
>
> Finally, I switch the 64-bit system_call code to use the new split
> entry work.  This is a net deletion of assembly code: it replaces
> all of the audit entry muck.
>
> In the process, I fixed some bugs.
>
> If this is acceptable, someone can do the same tweak for the
> ia32entry and entry_32 code.
>
> This passes all seccomp tests that I know of, except for the ones
> that don't work on current kernels.

After fighting a bit with merging this with the tsync series, I can
confirm this all behaves nicely on x86_64 and ARM.

-Kees

-- 
Kees Cook
Chrome OS Security
