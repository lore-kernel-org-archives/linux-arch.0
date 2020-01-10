Return-Path: <SRS0=fIL7=27=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:47301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgAJTrD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 14:47:03 -0500
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org>
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Jan 2020 20:46:44 +0100
Message-ID: <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20200110194644.6o3oMcP0qu21teEe0xjVFACuySz96gkFm4CD3EHDbVE@z>

On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
>
> I have more patches in this area because I'm trying to move all the
> read_barrier_depends() magic into arch/alpha/, but I'm holding off until
> we agree on this part first.

Isn't the read_barrier_depends() the only reason for actually needing
the temporary local variable that must not be volatile?

If you make alpha provide its own READ_ONCE() as the first
step, it would seem that the rest of the series gets much easier
as the others can go back to the simple statement from your

#define __READ_ONCE(x)  (*(volatile __unqual_scalar_typeof(x) *)&(x))

      Arnd
