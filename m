Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:33412 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcFUECe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 00:02:34 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1466466093.git.luto@kernel.org>
References: <cover.1466466093.git.luto@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Jun 2016 21:01:40 -0700
Message-ID: <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86, core)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160621040140.VledZPAyh4C73PR6gL6mVvTsS15bYS2SJVXNHtaMWBE@z>

On Mon, Jun 20, 2016 at 4:43 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> On my laptop, this adds about 1.5µs of overhead to task creation,
> which seems to be mainly caused by vmalloc inefficiently allocating
> individual pages even when a higher-order page is available on the
> freelist.

I really think that problem needs to be fixed before this should be merged.

The easy fix may be to just have a very limited re-use of these stacks
in generic code, rather than try to do anything fancy with multi-page
allocations. Just a few of these allocations held in reserve (perhaps
make the allocations percpu to avoid new locks).

It won't help for a thundering herd problem where you start tons of
new threads, but those don't tend to be short-lived ones anyway. In
contrast, I think one common case is the "run shell scripts" that runs
tons and tons of short-lived processes, and having a small "stack of
stacks" would probably catch that case very nicely. Even a
single-entry cache might be ok, but I see no reason to not make it be
perhaps three or four stacks per CPU.

Make the "thread create/exit" sequence go really fast by avoiding the
allocation/deallocation, and hopefully catching a hot cache and TLB
line too.

Performance is not something that we add later. If the first version
of the patch series doesn't perform well, it should not be considered
ready.

            Linus
