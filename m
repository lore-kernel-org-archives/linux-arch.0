From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cmpxchg and x86 flags output
Date: Wed, 22 Jun 2016 10:11:41 -0700
Message-ID: <CA+55aFxva_dW+=10JA9G1d1uAW1rHimLS5jGVUeNxfFepFzA9A@mail.gmail.com>
References: <F800D95C-A84C-4F54-9620-F28465AC4A16@zytor.com>
 <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com> <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
 <20160615085002.GC30935@twins.programming.kicks-ass.net> <4467.1466499980@warthog.procyon.org.uk>
 <16238.1466611894@warthog.procyon.org.uk> <8455f920-3fea-a20b-1ac1-857870c80338@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8455f920-3fea-a20b-1ac1-857870c80338@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 22, 2016 at 9:36 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> I am kind of hesitant to put knowledge of this into gcc, because it
> freezes something that currently is not gcc-dependent (although we could
> separate out the gcc-generated and non-gcc-generated bits if we really
> care.)

I'm pretty down on the whole intrinsics thing in general. We have
*not* had great luck with most intrinsics, largely because it takes so
long for people to upgrade compilers, and it's such a pain to check
every single little random new gcc addition.

There seems to be no advantage (at least on x86) of some new intrinsic
over just using the asm with condition code outputs. And that's a much
more generic gcc feature that we would use in other places.

I thought Richard Henderson already had a patch for the condition code
asm outputs, but maybe I misremember.

              Linus
