From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/3] math128: Introduce {mult,add,cmp}_u128
Date: Tue, 24 Apr 2012 18:46:14 -0700
Message-ID: <CA+55aFx_efN7A2H2VuRGZiyh2xcV=p6uoDLcVAW2JOqmJJNd1Q@mail.gmail.com>
References: <20120424161039.293018424@chello.nl> <20120424162224.526249106@chello.nl>
 <CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com> <1335304497.28150.243.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1335304497.28150.243.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 24, 2012 at 2:54 PM, Peter Zijlstra <a.p.zijlstra@chello.nl=
> wrote:
>
> that does generate slightly better code in that it avoids some masks =
on
> 64bit:
>
> @@ -7,12 +7,11 @@
> =A0.LFB38:
> =A0 =A0 =A0 =A0.cfi_startproc
> =A0 =A0 =A0 =A0movq =A0 =A0%rdi, %r8
> - =A0 =A0 =A0 movq =A0 =A0%rdi, %rdx
> =A0 =A0 =A0 =A0movq =A0 =A0%rsi, %rcx
> + =A0 =A0 =A0 mov =A0 =A0 %edi, %edx
> =A0 =A0 =A0 =A0shrq =A0 =A0$32, %r8
> - =A0 =A0 =A0 andl =A0 =A0$4294967295, %edx
> =A0 =A0 =A0 =A0shrq =A0 =A0$32, %rcx
> - =A0 =A0 =A0 andl =A0 =A0$4294967295, %esi
> + =A0 =A0 =A0 mov =A0 =A0 %esi, %esi

Oh christ.

What insane version of gcc is that? Can you please make a gcc bug-repor=
t?

Because a compiler that generates an instruction sequence like

    movq %rdi,%rsi
    andl $4294967295, %esi

is just so fricking stupid that it's outright buggy. That's just
crazy. It's demented. It's an "and" with all bits set.

But yeah, I do think that in general using a cast to 32-bit instead of
a mask to 32-bit is easier for the compiler. Although that still is a
particularly stupid code sequence to use.

                     Linus
