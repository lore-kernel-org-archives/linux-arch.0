From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sat, 6 Jan 2018 20:22:13 +0000
Message-ID: <20180106202213.23e553fb@alans-desktop>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
        <20180106123242.77f4d860@alans-desktop>
        <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
        <20180106183859.1ad9ae37@alans-desktop>
        <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
        <20180106195551.3207f75d@alans-desktop>
        <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

> "Value prediction consists of predicting entire 32- and 64-bit register values
> based  on  previously-seen values"

For their implementation yes

> 
> > In other words there are at least two problems with Linus proposal
> > 
> > 1. The ffff/0000 mask has to be generated and that has to involve
> > speculative flows.  
> 
> to answer above and Thomas's
> "For one particular architecture and that's not a solution for generic code."
> 
> The following:
> #define array_access(base, idx, max) ({                         \
>         union { typeof(base[0]) _val; unsigned long _bit; } __u;\
>         unsigned long _i = (idx);                               \
>         unsigned long _m = (max);                               \
>         unsigned long _mask = ~(long)(_m - 1 - _i) >> 63;       \
>         __u._val = base[_i & _mask];                            \
>         __u._bit &= _mask;                                      \
>         __u._val; })
> 
> is generic and no speculative flows.

In the value speculation case imagine it's been called 1000 times for
process A which as a limit of say 16 so that file->priv->max is 16, and
then is run for process B which is different.

A value speculating processor waiting for file->priv->max which has been
pushed out of cache by an attacker is at liberty to say 'I've no idea
what max is but hey it was 16 last time so lets plug 16 in and keep going"

So while the change in the mask computation is clever and (subject to
compiler cleverness) safe against guesses of which path will be taken I
don't think it's generically safe.

Unfortunately a lot of things we index are of different sizes as seen by
different tasks, or when passed different other index values so this does
matter.

> Even if 'mask' in 'index & mask' example is a stall the educated
> guess will come from the prior value (according to the quoted paper)

Which might be for a different set of variables when the table is say per
process like file handles, or the value is different each call.

If we have single array of fixed size then I suspect you are right but
usually we don't.

Alan
