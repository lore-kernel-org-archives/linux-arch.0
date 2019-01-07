From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] make 'user_access_begin()' do 'access_ok()'
Date: Tue, 8 Jan 2019 06:49:19 +0900
Message-ID: <20190107214919.GO3235@lianli.shorne-pla.net>
References: <20190106180927.GA11993@roeck-us.net>
 <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
 <CAHk-=wiSVm6j1Ga8gra6hSQQSK8WF5bW4DtRi4V7mCtCUkTaQw@mail.gmail.com>
 <78e3717b-0604-3d5f-38b8-c523e392fc76@roeck-us.net>
 <CAHk-=wg45nXe50ORC7reBJqsFGUPELtbk5p7ijkE9=fs1wGLAQ@mail.gmail.com>
 <CAHk-=wgnLcrL8PbS0Dz3nprCXvR5iFCKjVvJmN_EbZW88i4L7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnLcrL8PbS0Dz3nprCXvR5iFCKjVvJmN_EbZW88i4L7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Matt Turner <mattst88@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Burton <paul.burton@mips.com>, Greentime Hu <green.hu@gmail.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 07, 2019 at 10:05:12AM -0800, Linus Torvalds wrote:
> Gaah. Re-sending this for the kernel mailing list just for posterity.
> I keep replying to emails that had the mailing list address wrong, and
> then my reply will have it wrong too.
> 
> I will learn to fix up the address just in time for this thread to die
> out, I suspect.
> 
>                 Linus
> 
> On Mon, Jan 7, 2019 at 10:02 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Jan 6, 2019 at 8:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Of the above, my test system boots images for the following architectures
> > > in qemu.
> > >
> > > - mips (32/64 bit, big/little endian)
> > > - nios2
> > > - openrisc
> > > - xtensa (mmu and nommu)
> >
> > So most of those are "only" the "macro arguments used twice" problem
> > (although openrisc also does the "arguments not quoted right"). That
> > doesn't cause problems with the new commit, it's an independent issue
> > that could cause random problems elsewhere

Linus,  Thanks for pointing this out and Guenter thanks for testing.

I ack the issue on OpenRISC and will send a patch for review in a day or so.
I'll also do an audit of openrisc to see if we have similar issues.

Next to access_ok() is __addr_ok() which seems to have the similar quoting
issue, but I don't see it being used anywhere, it's also defined and not
used on: arm, x86 and csky.   It is used on SH.

OK to remove __addr_ok()?

-Stafford
