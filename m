From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sat, 6 Jan 2018 19:55:51 +0000
Message-ID: <20180106195551.3207f75d@alans-desktop>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
        <20180106123242.77f4d860@alans-desktop>
        <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
        <20180106183859.1ad9ae37@alans-desktop>
        <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:56134 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752397AbeAFT4T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jan 2018 14:56:19 -0500
In-Reply-To: <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

> cpus execute what they see. speculative execution does the same
> except results are not committed to visible registers and stay
> in renanmed/shadow set. There is no 'undo' of the speculative execution.
> The whole issue is that cache and branch predictor don't have
> a shadow unlike registers.

Can I suggest you read something like "Exploitig Value Locaity to Exceed
The Dataflow Limit" by Lipasti and Shen 1996.

In other words there are at least two problems with Linus proposal

1. The ffff/0000 mask has to be generated and that has to involve
speculative flows.

2. There are processors on the planet that may speculate not just what
instruction to execute but faced with a stall on an input continue by
using an educated guess at the value that will appear at the input in
future.

> > > I think "lets sprinkle lfence everywhere" approach is going to
> > > cause serious performance degradation. Yet people pushing for lfence
> > > didn't present any numbers.  
> > 
> > Normally people who propose security fixes don't have to argue about the
> > fact they added 30 clocks to avoid your box being 0wned.
> > 
> > If you look at the patches very very few are in remotely hot paths, which
> > is good news. The ones in hot paths definitely need careful scrutiny but
> > the priority ought to be fixing and then optimizing unless its obvious
> > how to tackle it.  
> 
> fdtable, access_ok and networking are clearly hot, 

Those points are not when compared to a lot of paths executed far far
more (like packet processing). The ipv4/6 ones are mixing lfences and a
lot of stores so probably hurt with lfence. fdtable worries me
a lot less and is anyway clearly required.

I have reviewing the packet building ones on my TODO list for a reason.

Alan
