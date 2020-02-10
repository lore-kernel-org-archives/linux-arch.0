From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Mon, 10 Feb 2020 09:59:56 +0000
Message-ID: <20200210095956.GA15056@willie-the-truck>
References: <20200123153341.19947-1-will@kernel.org>
 <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
 <20200124083307.GA14914@hirez.programming.kicks-ass.net>
 <CAK7LNAS=er+Vkvx+vurYMCHS2u1_Vj0zV+tvUzDkSwop3XP1gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgBJKAD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Feb 2020 05:00:03 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNAS=er+Vkvx+vurYMCHS2u1_Vj0zV+tvUzDkSwop3XP1gg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>

On Mon, Feb 10, 2020 at 06:50:53PM +0900, Masahiro Yamada wrote:
> On Fri, Jan 24, 2020 at 5:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jan 23, 2020 at 09:59:03AM -0800, Linus Torvalds wrote:
> > > On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > This is version two of the patches I previously posted as an RFC here:
> > >
> > > Looks fine to me, as far as I can tell,
> >
> > Awesome, I've picked them up with a target for tip/locking/core.
> 
> Were they really picked up?
> 
> The MW is closed now, but I do not them in Linus' tree.
> I do not see them even in linux-next.

We ended up running into build issues with m68k which took quite a bit of
effort to fix, so that meant we missed the merge window. It also seems that
we've now run into similar looking issues for sparc32 :(

Will
