Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfLQSbl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 13:31:41 -0500
Date: Tue, 17 Dec 2019 18:31:35 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191217183135.GA3944@willie-the-truck>
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck>
 <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
 <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20191217183135.xZids0NQOSiG-KKHrTFZwlTnjN-jMP429BHAZpK07-0@z>

On Tue, Dec 17, 2019 at 10:05:53AM -0800, Linus Torvalds wrote:
> On Tue, Dec 17, 2019 at 10:04 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Let me think about it.
> 
> .. and in the short term, maybe for code generation, the right thing
> is to just do the cast in the bitops, where we can just cast to
> "unsigned long *" and remove the volatile that way.

Yeah, I think I'll spin that patch series tomorrow anyway, since I don't
think we need to hold it up.

> I'm still hoping there's a trick, but..

Well, there's always Peter's awful hack [1] but it's really gross. FWIW,
I've pushed the handful of patches I have to [2], which drop the GCC 4.8
workaround and introduce a non-atomic version instead of the
'__builtin_memcpy()'.

Will

[1] https://lore.kernel.org/lkml/20191213125618.GD2844@hirez.programming.kicks-ass.net
[2] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=rwonce/cleanup
