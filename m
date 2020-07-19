From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] raw_copy_from_user() semantics
Date: Sun, 19 Jul 2020 12:28:13 -0700
Message-ID: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
References: <20200719031733.GI2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200719031733.GI2786714@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Jul 18, 2020 at 8:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         So any byte-squeezing loop of that sort would break on a bunch
> of architectures.

I think we should try to get rid of the exact semantics.

If "copy_from/to_user()" takes a fault because it does a
larger-than-byte access (and with unrolling, it could be a _lot_
larger than one byte: x86 dcurrently has that "generic" case that
isn't used very much, but it unrolls 8-byte accesses 8 times, so it
does a 64-byte block that we could just say "if any fo those didn't
work, then you're done), then the copy failed. The exact number of
bytes we _could_ have copied is not important.

So we could simplify the x86 end condition too and remove all the
"handle_tail" complexity.

                  Linus

(*) Yes, it aligns things to 64-byte boundaries too, but only for the
write side, not the read side.
