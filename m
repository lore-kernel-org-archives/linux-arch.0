From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sat, 6 Jan 2018 18:38:59 +0000
Message-ID: <20180106183859.1ad9ae37@alans-desktop>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
        <20180106123242.77f4d860@alans-desktop>
        <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55924 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeAFSjc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jan 2018 13:39:32 -0500
In-Reply-To: <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, 6 Jan 2018 10:13:33 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Sat, Jan 06, 2018 at 12:32:42PM +0000, Alan Cox wrote:
> > On Fri, 5 Jan 2018 18:52:07 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> > > On Fri, Jan 5, 2018 at 5:10 PM, Dan Williams <dan.j.williams@intel.com> wrote:  
> > > > From: Andi Kleen <ak@linux.intel.com>
> > > >
> > > > When access_ok fails we should always stop speculating.
> > > > Add the required barriers to the x86 access_ok macro.    
> > > 
> > > Honestly, this seems completely bogus.  
> > 
> > Also for x86-64 if we are trusting that an AND with a constant won't get
> > speculated into something else surely we can just and the address with ~(1
> > << 63) before copying from/to user space ? The user will then just
> > speculatively steal their own memory.  
> 
> +1
> 
> Any type of straight line code can address variant 1.
> Like changing:
>   array[index]
> into
>   array[index & mask]
> works even when 'mask' is a variable.

That statement is unfortunately not one that we currently believe is
true for all architectures, platforms and implementations. It may be true
for some architectures but processors can speculate on more than just
execution paths. For some architecutres it may be the right way to
implement Linus array_* methods.

> I think "lets sprinkle lfence everywhere" approach is going to
> cause serious performance degradation. Yet people pushing for lfence
> didn't present any numbers.

Normally people who propose security fixes don't have to argue about the
fact they added 30 clocks to avoid your box being 0wned.

If you look at the patches very very few are in remotely hot paths, which
is good news. The ones in hot paths definitely need careful scrutiny but
the priority ought to be fixing and then optimizing unless its obvious
how to tackle it.

Alan
