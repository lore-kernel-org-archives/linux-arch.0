Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45665 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCCCTN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Mar 2019 21:19:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id d24so1333246ljc.12
        for <linux-arch@vger.kernel.org>; Sat, 02 Mar 2019 18:19:12 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v5sm591410lfa.38.2019.03.02.18.19.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 18:19:07 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id a8so1104375lfi.7
        for <linux-arch@vger.kernel.org>; Sat, 02 Mar 2019 18:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none>
In-Reply-To: <1551575210.6lwpiqtg5k.astroid@bobo.none>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2019 18:18:50 -0800
Message-ID: <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190303021850.WJPMy0I1Osd-4GCRNXU2r0IE4BX8ssPRULWbwCMSpSs@z>

On Sat, Mar 2, 2019 at 5:43 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Is there a reason to call this "mmiowb"? We already have wmb that
> orders cacheable stores vs mmio stores don't we?

Sadly no it doesn't. Not on ia64, and people tried to make that the
new rule because of the platform breakage on what some people thought
would be a major platform.

Plain wmb() was only guaranteed to order regular memory against each
other (mostly useful for dma) on some of these platforms, because they
had such broken IO synchronization.

So mmiowb() is not a new name. It's been around for a while, and the
people who wanted it have happily become irrelevant. Will is making it
go away, but the name remains for historical reasons, even if Will's
new acronym explanation for the name is much better ;)

                Linus
