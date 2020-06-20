From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
Date: Sat, 20 Jun 2020 10:57:32 +0300
Message-ID: <20200620075732.GA468070@localhost.localdomain>
References: <20200618210645.GB2212102@localhost.localdomain>
 <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 19, 2020 at 11:37:47AM -0700, Linus Torvalds wrote:
> On Thu, Jun 18, 2020 at 2:06 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Rename
> >         struct notifier_block *this
> > to
> >         struct notifier_block *nb
> >
> > "nb" is arguably a better name for notifier block.
> 
> Maybe it's a better name. But it doesn't seem worth it.
> 
> Because C++ reserved words are entirely irrelevant.
> 
> We did this same dance almost three decades ago, and the fact is, C++
> has other reserved words that make it all pointless.

The real problems are "class" and "new" indeed.

> There is no way I will accept the renaming of various "new" variables.

I'm not sending "new".

> We did it, it was bad, we undid it, and we now have a _lot_ more uses
> of 'new' and 'old', and no, we're not changing it for a braindead
> language that isn't relevant to the kernel.
> 
> The fact is, C++ chose bad identifiers to make reserved words.
> 
> If you want to build the kernel with C++, you'd be a lot better off just doing
> 
>    /* C++ braindamage */
>    #define this __this
>    #define new __new
> 
> and deal with that instead.

Can't do this because of placement new.

> Because no, the 'new' renaming will never happen, and while 'this'
> isn't nearly as common or relevant a name, once you have the same
> issue with 'new', what's the point of trying to deal with 'this'?

I'm not sending "new".

There is stuff which can be merge without breaking source compatibility
and readability of C version:

	private		=> priv
	virtual		=> virt
	this		=> self (in some contexts)

and those which can not. I'm not sending the latter.
