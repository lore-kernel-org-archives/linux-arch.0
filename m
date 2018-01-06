From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 13:17:31 -0800
Message-ID: <20180106211729.cp5oet3at3hyce4o@ast-mbp>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:42690 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeAFVRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 16:17:35 -0500
Content-Disposition: inline
In-Reply-To: <20180106202213.23e553fb@alans-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, Jan 06, 2018 at 08:22:13PM +0000, Alan Cox wrote:
> > "Value prediction consists of predicting entire 32- and 64-bit register values
> > based  on  previously-seen values"
> 
> For their implementation yes
> 
> > 
> > > In other words there are at least two problems with Linus proposal
> > > 
> > > 1. The ffff/0000 mask has to be generated and that has to involve
> > > speculative flows.  
> > 
> > to answer above and Thomas's
> > "For one particular architecture and that's not a solution for generic code."
> > 
> > The following:
> > #define array_access(base, idx, max) ({                         \
> >         union { typeof(base[0]) _val; unsigned long _bit; } __u;\
> >         unsigned long _i = (idx);                               \
> >         unsigned long _m = (max);                               \
> >         unsigned long _mask = ~(long)(_m - 1 - _i) >> 63;       \
> >         __u._val = base[_i & _mask];                            \
> >         __u._bit &= _mask;                                      \
> >         __u._val; })
> > 
> > is generic and no speculative flows.
> 
> In the value speculation case imagine it's been called 1000 times for
> process A which as a limit of say 16 so that file->priv->max is 16, and
> then is run for process B which is different.
> 
> A value speculating processor waiting for file->priv->max which has been
> pushed out of cache by an attacker is at liberty to say 'I've no idea
> what max is but hey it was 16 last time so lets plug 16 in and keep going"
> 
> So while the change in the mask computation is clever and (subject to
> compiler cleverness) safe against guesses of which path will be taken I
> don't think it's generically safe.
> 
> Unfortunately a lot of things we index are of different sizes as seen by
> different tasks, or when passed different other index values so this does
> matter.
> 
> > Even if 'mask' in 'index & mask' example is a stall the educated
> > guess will come from the prior value (according to the quoted paper)
> 
> Which might be for a different set of variables when the table is say per
> process like file handles, or the value is different each call.
> 
> If we have single array of fixed size then I suspect you are right but
> usually we don't.

Thanks. I see your point. Agree on the above.
The variant 1 exploit does 2000 bytes a second using 64-bit address math.
Things like 'fd' are 32-bit, so it's magnitude higher attack
complexity already (without any kernel changes).
If we do above array_access() the exploit complexity increases even more.
More so the attacker would need to train fdt->max_fds on a known
good fdt with millions of files for 100s of iterations only to do
one speculative access on another fdt with small max_fds 
(to exploit value speculation from large max_fds)
while keeping cache line for that speculative out-of-bounds access on
small fdt empty and measuring cache load times on another cpu.
I frankly don't see such attack being able to keep cache lines pristine
for that small fdt speculation doing hundreds of non-speculative
accesses on another fdt. Way too many moving pieces.
Even if it would be practical the speed probably going to be in bytes per second,
so to read anything meaningful an attack detection techniques (that people
are actively working on) will be able to catch it.
At the end security cannot be absolute.
The current level of paranoia shouldn't force us to make hastily decisions.

So how about we do array_access() macro similar to above by default
with extra CONFIG_ to convert it to lfence ?
Why default to AND approach instead of lfence ?
Because the kernel should still be usable. If security
sacrifices performance so much such security will be turned off.
Ex: kpti suppose to add 5-30%. If it means 10% on production workload
and the datacenter capacity cannot grow 10% overnight, kpti will be off.
