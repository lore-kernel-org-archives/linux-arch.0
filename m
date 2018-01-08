From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sun, 7 Jan 2018 18:09:02 -0800
Message-ID: <20180108020900.2iggkwt6p5xtmsnd@ast-mbp>
References: <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <alpine.DEB.2.20.1801071107001.2606@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:37406 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754882AbeAHCJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 21:09:07 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1801071107001.2606@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sun, Jan 07, 2018 at 11:08:24AM +0100, Thomas Gleixner wrote:
> On Sat, 6 Jan 2018, Alexei Starovoitov wrote:
> > which clearly states that bpf_tail_call() was used in the attack.
> > Yet none of the intel nor arm patches address speculation in
> > this bpf helper!
> > It means that:
> > - gpz didn't share neither exploit nor the detailed description
> >   of the POC with cpu vendors until now
> > - coverity rules used to find all these places in the kernel
> >   failed to find bpf_tail_call
> > - cpu vendors were speculating what variant 1 can actually do
> 
> You forgot to mention that there might be other attacks than the public POC
> which are not covered by a simple AND ....

if above statement is not a pure speculation please share CVE number.
For varaint[123] they've been reserved for months.

> For spectre_v1/2 we face the same problem simply because we got informed so
> much ahead of time and we were all twiddling thumbs, enjoying our christmas
> vacation and having a good time.

right. they were informed in a way that they failed to address
variant1 with pre-embargo and public patches.

> The exploits are out in the wild and they are observed already, so we

this statement contradicts with everything that was publicly stated.
Or you're referring to 'exploit' at the end of spectre paper?

> want to discuss the right way to fix it for the next 3 month and leave all
> doors open until the last bit of performance is squeezed out.

Let's look at facts:
- Linus explains his array_access() idea
- lfence proponents quickly point out that it needs gcc to be smart
  enough to emit setbe and go back to lfence patches
- I spent half an hour to tweak array_access() to be generic
  on all archs and compiler indepedent
- lfence proponets point out that AND with a variable somehow
  won't work, yet after further discussion it's actually fine due to
  the nature of variant1 attack that needs to train predictor with in-bounds
  access to mispredict with out-of-bounds speculative load
- then lfence proponets claim 'non public POC' not covered by AND
- it all in the matter of 2 days.
- and now the argument that it will take 3 month to discuss a solution
  without lfence, yet still no performance numbers for lfence
  though 'people in the know' were twiddling thumbs for months.

That's just not cool.
