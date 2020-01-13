Return-Path: <SRS0=fNgb=3C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:40195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgAMNEB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 08:04:01 -0500
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
 <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
In-Reply-To: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Jan 2020 14:03:41 +0100
Message-ID: <CAK8P3a1Qvz+HB-ROy2cmtPtE2m113iBhWbdibpdQ4ycNp9u=ng@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20200113130341.0e1S5LElNDoD0TGi_pgzUE6VRGlrmIPg1HRaG0ErJk4@z>

On Fri, Jan 10, 2020 at 9:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 10, 2020 at 11:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Isn't the read_barrier_depends() the only reason for actually needing
> > the temporary local variable that must not be volatile?
> >
> > If you make alpha provide its own READ_ONCE() as the first
> > step, it would seem that the rest of the series gets much easier
> > as the others can go back to the simple statement from your
>
> Hmm.. The union still would cause that "take the address of a volatile
> thing on the stack" problem, wouldn't it? And that was what caused
> most of the issues.

Ah, I was missing that there is still the union in smp_load_acquire(),
I only saw that the one in READ_ONCE() is needed only on alpha.

The number of files using smp_load_acquire() is fairly small though,
so we could consider changing it to pass both source and destination
as macro arguments and use typeof(dest) instad of typeof(source)
to avoid the volatile pointer access.

> I think the _real_ issue is how KASAN forces that odd pair of inline
> functions in order to have the annotations on the accesses.

But the inline functions (I assume you mean __write_once_size
and __read_once_size_nocheck?) are completely removed after
Will's series, so those no longer cause harm, right?

      Arnd
