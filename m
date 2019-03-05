Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40975 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAUS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2019 19:20:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id y7so4853471lfg.8
        for <linux-arch@vger.kernel.org>; Mon, 04 Mar 2019 16:20:17 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w69sm1775131lff.22.2019.03.04.16.20.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:20:14 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a8so4853310lfi.7
        for <linux-arch@vger.kernel.org>; Mon, 04 Mar 2019 16:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <87ef7n7x9v.fsf@concordia.ellerman.id.au>
In-Reply-To: <87ef7n7x9v.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2019 16:19:58 -0800
Message-ID: <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190305001958.5RQdaKDqPeqWc9nPsZiH6e6xIVm1J3r2vn5w6CdO9FY@z>

On Mon, Mar 4, 2019 at 2:24 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Without wading into the rest of the discussion, this does raise an
> interesting point, ie. what about eg. rwlock's?
>
> They're basically equivalent to spinlocks, and so could reasonably be
> expected to have the same behaviour.
>
> But we don't check the io_sync flag in arch_read/write_unlock() etc. and
> both of those use lwsync.

I think technically rwlocks should do the same thing, at least when
they are used for exclusion.

Because of the exclusion argument, we can presubably limit it to just
write_unlock(), although at least in theory I guess you could have
some "one reader does IO, then a writer comes in" situation..

Perhaps more importantly, what about sleeping locks? When they
actually *block*, they get the barrier thanks to the scheduler, but
you can have a nice non-contended sequence that never does that.

I guess the fact that these cases have never even shown up as an issue
means that we could just continue to ignore it.

We could even give that approach some fancy name, and claim it as a
revolutionary new programming paradigm ("ostrich programming" to go
with "agile" and "pair programming").

                    Linus
