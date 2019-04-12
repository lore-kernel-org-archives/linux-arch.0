Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52087 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfDLCIU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Apr 2019 22:08:20 -0400
Message-ID: <e172bf1d741eafd8c056ae3692b400f24bb7c3a7.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 12 Apr 2019 12:07:09 +1000
In-Reply-To: <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
         <20190405135936.7266-2-will.deacon@arm.com>
         <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
         <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190412020709.JjAg2RxShUtSggP1RFhmPNXs0YHMbdXLm5oQi-azaco@z>

On Thu, 2019-04-11 at 15:34 -0700, Linus Torvalds wrote:
> On Thu, Apr 11, 2019 at 3:13 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > Minor nit... I would have said "All readX() and writeX() accesses
> > _from
> > the same CPU_ to the same peripheral... and then s/the CPU/this
> > CPU.
> 
> Maybe talk about "same thread" rather than "same cpu", with the
> understanding that scheduling/preemption has to include the
> appropriate cross-CPU IO barrier?

Works for me, but why not spell all this out in the document ? We know,
but others might not.

Cheers,
Ben.
