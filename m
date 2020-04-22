From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Date: Wed, 22 Apr 2020 13:26:27 +0100
Message-ID: <20200422122626.GA676@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
 <20200422081838.GA29541@willie-the-truck>
 <20200422113721.GA20730@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVM0e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 08:26:34 -0400
Content-Disposition: inline
In-Reply-To: <20200422113721.GA20730@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Wed, Apr 22, 2020 at 01:37:21PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 22, 2020 at 09:18:39AM +0100, Will Deacon wrote:
> > On Tue, Apr 21, 2020 at 11:42:56AM -0700, Linus Torvalds wrote:
> > > On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > It's me again. This is version four of the READ_ONCE() codegen improvement
> > > > patches [...]
> > > 
> > > Let's just plan on biting the bullet and do this for 5.8. I'm assuming
> > > that I'll juet get a pull request from you?
> > 
> > Sure thing, thanks. I'll get it into -next along with the arm64 bits for
> > 5.8, but I'll send it as a separate pull when the time comes. I'll also
> > include the sparc32 changes because otherwise the build falls apart and
> > we'll get an army of angry robots yelling at us (they seem to form the
> > majority of the active sparc32 user base afaict).
> 
> So I'm obviously all for these patches; do note however that it collides
> most mighty with the KCSAN stuff, which I believe is still pending.

That stuff has been pending for the last two releases afaict :/

Anyway, I'm happy to either provide a branch with this series on, or do
the merge myself, or send this again based on something else. What works
best for you? The only thing I'd obviously like to avoid is tightly
coupling this to KCSAN if there's a chance of it missing the merge window
again.

Cheers,

Will
