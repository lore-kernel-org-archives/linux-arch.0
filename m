From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Date: Wed, 22 Apr 2020 09:18:39 +0100
Message-ID: <20200422081838.GA29541@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgDVISp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 04:18:45 -0400
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Tue, Apr 21, 2020 at 11:42:56AM -0700, Linus Torvalds wrote:
> On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
> >
> > It's me again. This is version four of the READ_ONCE() codegen improvement
> > patches [...]
> 
> Let's just plan on biting the bullet and do this for 5.8. I'm assuming
> that I'll juet get a pull request from you?

Sure thing, thanks. I'll get it into -next along with the arm64 bits for
5.8, but I'll send it as a separate pull when the time comes. I'll also
include the sparc32 changes because otherwise the build falls apart and
we'll get an army of angry robots yelling at us (they seem to form the
majority of the active sparc32 user base afaict).

> > (I'm interpreting the silence as monumental joy)
> 
> By now I think we can take that for granted.
> 
> Because "monumental joy" is certainly exactly what I felt re-reading
> that "unqualified scalar type" macro.
> 
> Or maybe it was just my breakfast trying to say "Hi!".

Haha! It's definitely best viewed on an empty stomach, but the comment
does give you ample warning.

Will
