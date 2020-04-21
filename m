From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Date: Tue, 21 Apr 2020 11:42:56 -0700
Message-ID: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
References: <20200421151537.19241-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
>
> It's me again. This is version four of the READ_ONCE() codegen improvement
> patches [...]

Let's just plan on biting the bullet and do this for 5.8. I'm assuming
that I'll juet get a pull request from you?

> (I'm interpreting the silence as monumental joy)

By now I think we can take that for granted.

Because "monumental joy" is certainly exactly what I felt re-reading
that "unqualified scalar type" macro.

Or maybe it was just my breakfast trying to say "Hi!".

                 Linus
