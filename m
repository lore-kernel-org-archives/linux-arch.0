Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33940 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeC3MAP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Mar 2018 08:00:15 -0400
Date: Fri, 30 Mar 2018 14:00:11 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/7] use struct pt_regs based syscall calling for x86-64
Message-ID: <20180330120010.yjjihmfsi7yjcvo5@gmail.com>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
 <20180330101602.ongosnigfmdmgayb@gmail.com>
 <20180330104649.GB12688@light.dominikbrodowski.net>
 <20180330110354.cnrtmjkk77hhbekt@gmail.com>
 <20180330114808.GA10671@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330114808.GA10671@light.dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Message-ID: <20180330120011.plDhEpTq2xxGj5I6tyiLZQdhqBztczn9yOcapJ_ZURk@z>


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Fri, Mar 30, 2018 at 01:03:54PM +0200, Ingo Molnar wrote:
> > 
> > * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > 
> > > > > The whole series is available at
> > > > > 
> > > > >         https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-WIP
> > > > 
> > > > BTW., I'd like all these bits to go through the x86 tree.
> > > > 
> > > > What is the expected merge route of the generic preparatory bits?
> > > 
> > > My current plan is to push the 109 patch bomb to remove in-kernel calls to syscalls
> > > directly to Linus once v4.16 is released.
> > 
> > Are there any (textual and semantic) conflicts with the latest -next?
> > 
> > Also, to what extent were these 109 patches tested in -next?
> 
> These 109 patches are equivalent to the syscalls tree in linux-next. Most of
> these patches habe been in there for quite a while (the last major batch went
> in on March 22; other patches are in there since March 14th).
> 
> Conflicts existend with asm-generic and metag (which contain remvoal of some
> architectures; I have solved that issue by not caring about those archs any
> more); trivial conflicts exist since very few days with the vfs and sparc
> trees.

Ok, great - all that sounds good to me, and I'll integrate the x86 bits once the 
generic bits are upstream.

Thanks,

	Ingo
