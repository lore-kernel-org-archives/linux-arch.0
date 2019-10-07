From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Date: Mon, 7 Oct 2019 13:29:04 -0700
Message-ID: <20191007202904.GA6883@roeck-us.net>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Cree <mcree@orcon.net.nz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 07, 2019 at 12:21:25PM -0700, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > this patch causes all my sparc64 emulations to stall during boot. It causes
> > all alpha emulations to crash with [1a] and [1b] when booting from a virtual
> > disk, and one of the xtensa emulations to crash with [2].
> 
> So I think your alpha emulation environment may be broken, because
> Michael Cree reports that it works for him on real hardware, but he
> does see the kernel unaligned count being high.
> 
Yes, that possibility always exists, unfortunately.

> But regardless, this is my current fairly minimal patch that I think
> should fix the unaligned issue, while still giving the behavior we
> want on x86. I hope Al can do something nicer, but I think this is
> "acceptable".
> 
> I'm running this now on x86, and I verified that x86-32 code
> generation looks sane too, but it woudl be good to verify that this
> makes the alignment issue go away on other architectures.
> 
>                 Linus

I started a complete test run with the patch applied. I'll let you know
how it went after it is complete - it should be done in a couple of hours.

Guenter
