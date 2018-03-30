Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36162 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeC3LD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Mar 2018 07:03:58 -0400
Date: Fri, 30 Mar 2018 13:03:54 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/7] use struct pt_regs based syscall calling for x86-64
Message-ID: <20180330110354.cnrtmjkk77hhbekt@gmail.com>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
 <20180330101602.ongosnigfmdmgayb@gmail.com>
 <20180330104649.GB12688@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330104649.GB12688@light.dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Message-ID: <20180330110354.FGzHJkOLcstTFoKJJamCMbGIc7-5VTbq5zfX3Aq0sbo@z>


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> > > The whole series is available at
> > > 
> > >         https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-WIP
> > 
> > BTW., I'd like all these bits to go through the x86 tree.
> > 
> > What is the expected merge route of the generic preparatory bits?
> 
> My current plan is to push the 109 patch bomb to remove in-kernel calls to syscalls
> directly to Linus once v4.16 is released.

Are there any (textual and semantic) conflicts with the latest -next?

Also, to what extent were these 109 patches tested in -next?

> For this series of seven patches, I am content with them going upstream through 
> the x86 tree (once that contains a backmerge of Linus' tree or the syscalls 
> tree, obviously). IMO, these seven patches should be kept together, and not 
> routed upstream through different channels.

Of course they should stay together - the generic code impact is minimal, these 
are 95% x86.

Thanks,

	Ingo
