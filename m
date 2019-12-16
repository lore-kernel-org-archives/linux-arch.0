From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Mon, 16 Dec 2019 12:47:24 +0100
Message-ID: <20191216114724.GL2844@hirez.programming.kicks-ass.net>
References: <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
 <20191213144359.GA3826@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191213144359.GA3826@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 16, 2019 at 10:28:06AM +0000, Will Deacon wrote:
> However, enabling this for 32-bit ARM is total carnage; as Linus mentioned,
> a whole bunch of code appears to be relying on atomic 64-bit access of
> READ_ONCE(); the perf ring buffer, io_uring, the scheduler, pm_runtime,
> cpuidle, ... :(
> 
> Unfortunately, at least some of these *do* look like bugs, but I can't see
> how we can fix them, not least because the first two are user ABI afaict. It
> may also be that in practice we get 2x32-bit stores, and that works out fine
> when storing a 32-bit virtual address. I'm not sure what (if anything) the
> compiler guarantees in these cases.

Perf does indeed have a (known) problem here for the head/tail values.
Last time we looked at that nobody could really come up with a sane
solution that wouldn't break something.

I'll try and dig out that thread. Perhaps casting the value to 'unsigned
long' internally might work, I forgot the details.
