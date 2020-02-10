From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Mon, 10 Feb 2020 18:50:53 +0900
Message-ID: <CAK7LNAS=er+Vkvx+vurYMCHS2u1_Vj0zV+tvUzDkSwop3XP1gg@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org> <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
 <20200124083307.GA14914@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38851 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJJvd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Feb 2020 04:51:33 -0500
In-Reply-To: <20200124083307.GA14914@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>

On Fri, Jan 24, 2020 at 5:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 23, 2020 at 09:59:03AM -0800, Linus Torvalds wrote:
> > On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > This is version two of the patches I previously posted as an RFC here:
> >
> > Looks fine to me, as far as I can tell,
>
> Awesome, I've picked them up with a target for tip/locking/core.

Were they really picked up?

The MW is closed now, but I do not them in Linus' tree.
I do not see them even in linux-next.
