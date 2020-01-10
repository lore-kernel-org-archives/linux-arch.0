From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Date: Fri, 10 Jan 2020 20:46:44 +0100
Message-ID: <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-arch.vger.kernel.org

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
