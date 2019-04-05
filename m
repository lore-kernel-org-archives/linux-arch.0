Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbfDEQJ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Apr 2019 12:09:29 -0400
Date: Fri, 5 Apr 2019 17:09:19 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 00/21] Remove Mysterious Macro Intended to Obscure
 Weird Behaviours (mmiowb())
Message-ID: <20190405160919.GA7857@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405160919.yIMTprtTJC4hl5ejSYfK9JKPOfKczluWcXjD4U-C_Po@z>

On Fri, Apr 05, 2019 at 05:55:37AM -1000, Linus Torvalds wrote:
> On Fri, Apr 5, 2019 at 3:59 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > I've also pushed this series out here:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/mmiowb
> >
> > and I would like to get it into -next once the first patch has been acked.
> 
> Ack on it all.

Thanks.

> With the afore-mentioned slight worry about non-spinlocked IO
> ordering, but I _think_ it's purely limited to ia64 and wmb() and
> friends should work elsewhere?
> 
> Or did I miss something? I think the ia64() mb/rmb/wmb stuff only
> works on normal memory on ia64.

I was worried about RISC-V, but actually their wmb() is "fence ow,ow"
which I think is stronger than their mmiowb() "fence o,w" implementation.

Everybody else should be fine with wmb() afaict, so if a driver writer
is smart enough to want this ordering outside of spinlocks, they can
do that for everybody apart from ia64.

Will
