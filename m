From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
Date: Fri, 19 Jun 2020 11:37:47 -0700
Message-ID: <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com>
References: <20200618210645.GB2212102@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200618210645.GB2212102@localhost.localdomain>
Sender: netdev-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 18, 2020 at 2:06 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Rename
>         struct notifier_block *this
> to
>         struct notifier_block *nb
>
> "nb" is arguably a better name for notifier block.

Maybe it's a better name. But it doesn't seem worth it.

Because C++ reserved words are entirely irrelevant.

We did this same dance almost three decades ago, and the fact is, C++
has other reserved words that make it all pointless.

There is no way I will accept the renaming of various "new" variables.
We did it, it was bad, we undid it, and we now have a _lot_ more uses
of 'new' and 'old', and no, we're not changing it for a braindead
language that isn't relevant to the kernel.

The fact is, C++ chose bad identifiers to make reserved words.

If you want to build the kernel with C++, you'd be a lot better off just doing

   /* C++ braindamage */
   #define this __this
   #define new __new

and deal with that instead.

Because no, the 'new' renaming will never happen, and while 'this'
isn't nearly as common or relevant a name, once you have the same
issue with 'new', what's the point of trying to deal with 'this'?

             Linus
