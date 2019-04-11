From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Date: Thu, 11 Apr 2019 15:34:33 -0700
Message-ID: <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-2-will.deacon@arm.com>
 <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 11, 2019 at 3:13 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Minor nit... I would have said "All readX() and writeX() accesses _from
> the same CPU_ to the same peripheral... and then s/the CPU/this CPU.

Maybe talk about "same thread" rather than "same cpu", with the
understanding that scheduling/preemption has to include the
appropriate cross-CPU IO barrier?

                   Linus
