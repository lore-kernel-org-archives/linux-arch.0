Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRKfI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 05:35:08 -0500
Date: Wed, 18 Dec 2019 10:35:01 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191218103501.GA15021@willie-the-truck>
References: <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <fb4bba85-1f83-435e-b84e-ee29770d7090@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4bba85-1f83-435e-b84e-ee29770d7090@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191218103501.oEDSKfQ-pwm5Qj9y4tbB1tARJJaCqtIWzM-edZP71io@z>

On Wed, Dec 18, 2019 at 11:22:05AM +0100, Christian Borntraeger wrote:
> On 12.12.19 21:49, Linus Torvalds wrote:
> > On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
> >>
> >> The root of my concern in all of this, and what started me looking at it in
> >> the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> >> for a pointer means that local variables in macros declared using typeof()
> >> suddenly start generating *hideous* code, particularly when pointless stack
> >> spills get stackprotector all excited.
> > 
> > Yeah, removing volatile can be a bit annoying.
> > 
> > For the particular case of the bitops, though, it's not an issue.
> > Since you know the type there, you can just cast it.
> > 
> > And if we had the rule that READ_ONCE() was an arithmetic type, you could do
> > 
> >     typeof(0+(*p)) __var;
> > 
> > since you might as well get the integer promotion anyway (on the
> > non-volatile result).
> > 
> > But that doesn't work with structures or unions, of course.
> 
> We do have a READ_ONCE on the following union in s390 code.
> 
> union ipte_control {
>         unsigned long val;
>         struct {
>                 unsigned long k  : 1;
>                 unsigned long kh : 31;
>                 unsigned long kg : 32;
>         }; 
> };
> 
> 
> In fact this one was the original failure case why we change ACCESS_ONCE.
> 
> see arch/s390/kvm/gaccess.c

Thanks. I think we should be ok just using the 'val' field instead of the
whole union but, then again, when bitfields are involved who knows what the
compiler might do. I thought we usually shied away from using them to mirror
hardware structures like this?

Will
