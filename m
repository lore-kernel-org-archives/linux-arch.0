From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v2] tools/memory-model/Documentation: Fix "conflict" definition
Date: Mon, 2 Mar 2020 19:33:02 +0100
Message-ID: <CANpmjNNbXLzrVOpLPVaCfX_f96s9kdGXUioBm8QnS8A+B_-NKg@mail.gmail.com>
References: <20200302141819.40270-1-elver@google.com> <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37200 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 13:33:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id 5so238311oiy.4
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 10:33:14 -0800 (PST)
In-Reply-To: <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "parri.andrea@gmail.com" <parri.andrea@gmail.com>, "will@kernel.org" <will@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "npiggin@gmail.com" <npiggin@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>, "luc.maranget@inria.fr" <luc.maranget@inria.fr>, "paulmck@kernel.org" <paulmck@kernel.org>, "akiyks@gmail.com" <akiyks@gmail.com>, "dlustig@nvidia.com" <dlustig@nvidia.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, 2 Mar 2020 at 18:44, David Laight <David.Laight@aculab.com> wrote:
>
> From: Marco Elver
> > Sent: 02 March 2020 14:18
> >
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> >
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
>
> I'm pretty sure that Linux requires that the underlying memory
> subsystem remove any possible 'conflicts' by serialising the
> requests (in an arbitrary order).
>
> So 'conflicts' are never relevant.

A "conflict" is nothing bad per-se. A conflict is simply "two accesses
to the same location, at least one is a write". Conflicting accesses
may not even be concurrent.

> There are memory subsystems where conflicts MUST be avoided.
> For instance the fpga I use have some dual-ported memory.
> Concurrent accesses on the two ports for the same address
> must (usually) be avoided if one is a write.
> Two writes will generate corrupt memory.
> A concurrent write+read will generate a garbage read.
> In the special case where the two ports use the same clock
> it is possible to force the read to be 'old data' but that
> constrains the timings.
>
> On such systems the code must avoid conflicting cycles.

What I gather is that on this system you need to avoid "concurrent
conflicting" accesses. Note that, "conflict" does not imply
"concurrent" and vice-versa.

Thanks,
-- Marco
