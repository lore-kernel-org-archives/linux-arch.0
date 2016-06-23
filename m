Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36117 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbcFWTe0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2016 15:34:26 -0400
MIME-Version: 1.0
In-Reply-To: <20160623191123.GE30935@twins.programming.kicks-ass.net>
References: <cover.1466466093.git.luto@kernel.org> <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
 <CALCETrUuG0-tGNQ5iAEO2_gaK1eUq7AoALoBeQKcOP8cvxr=eA@mail.gmail.com>
 <CA+55aFx480bxx7VAmFqdsVGHjoSav4eCvVpcx5ZSpBQuq+=1Mw@mail.gmail.com>
 <20160623143126.GA16664@redhat.com> <20160623191123.GE30935@twins.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jun 2016 12:34:24 -0700
Message-ID: <CA+55aFzuNg5pfv_S_55u1tGhfUEux16wwiUSeCStKfha2MrxBQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86, core)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160623193424.Me0WeJRLQ_kpsFPbYZWmAHAhvYuCqsjfpqduDjfL7S8@z>

On Thu, Jun 23, 2016 at 12:11 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Didn't we talk about using SLAB_DESTROY_BY_RCU for task_struct before?
> If that is possible, a reuse in per-cpu cache is equally possible.
>
> All we really want to guarantee is that the memory remains a
> task_struct, it need not remain the same task, right?

No, we can't do SLAB_DESTROY_BY_RCU for the task_struct itself,
because the RCU list traversal does expect that the thread and task
lists are stable even if it walks into a "stale" struct task_struct.

If we re-use the task-struct before the RCU grace period is over, then
the list walker might end up walking into the wrong thread group
(bad!) or seeing tasks twice on the task list (also bad, although
perhaps not _as_ bad).

The _other_ fields might be ok, but updaing the very list fields that
we walk with RCU is a no-no.

Basically, SLAB_DESTROY_BY_RCU is fine only for things where the RCU
field use is idempotent. So for things where the RCU walker only looks
at entries that don't matter semantically, or where it does things
like "lock/unlock" on a lock that is still valid.

It's actually fairly rare that we can use SLAB_DESTROY_BY_RCU. We have
that sighand thing, and there's a couple of networking uses for the
request_sock and socket slabs. And I sincerely hope the socket slab
RCU lists are safe, because it's dangerous.

               Linus
