From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Date: Fri, 24 Jan 2020 09:20:14 -0800
Message-ID: <CAKwvOdmTOoTXCGN9NaO5_+sqDsK364=oCiVO_D5=btj1GsJrnw@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com> <20200124082443.GY14914@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39631 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbgAXRU0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 12:20:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id 4so1445829pgd.6
        for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2020 09:20:26 -0800 (PST)
In-Reply-To: <20200124082443.GY14914@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>

On Fri, Jan 24, 2020 at 12:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 23, 2020 at 11:07:59AM -0800, Nick Desaulniers wrote:
>
> > Good thing it's the variable being modified was not declared const; I
> > get spooked when I see -Wdiscarded-qualifiers because of Section
> > 6.7.3.6 of the ISO C11 draft spec:
> >
> > ```
> > If an attempt is made to modify an object defined with a
> > const-qualified type through use
> > of an lvalue with non-const-qualified type, the behavior is undefined.
> > If an attempt is
> > made to refer to an object defined with a volatile-qualified type
> > through use of an lvalue
> > with non-volatile-qualified type, the behavior is undefined.133)
> >
> > 133) This applies to those objects that behave as if they were defined
> > with qualified types, even if they are
> > never actually defined as objects in the program (such as an object at
> > a memory-mapped input/output
> > address).
> > ```
> >
> > Which is about the modification of a const-declared variable (explicit
> > UB which Clang actively exploits),
>
> Just for curiosity's sake. What does clang actually do in that case?
>

https://bugs.llvm.org/show_bug.cgi?id=42763
I was playing around with this in godbolt but couldn't quickly come up
with a simple reproducer.  IIRC, I've fixed maybe 3 instances of this
recently in code though.
-- 
Thanks,
~Nick Desaulniers
