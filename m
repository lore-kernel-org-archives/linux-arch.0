Return-Path: <SRS0=wbd0=7X=lists.infradead.org=linux-riscv-bounces+rppt=kernel.org@kernel.org>
MIME-Version: 1.0
References: <20200610174811.44b94525@thinkpad>
In-Reply-To: <20200610174811.44b94525@thinkpad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jun 2020 09:53:49 -0700
Message-ID: <CAHk-=wgm0_0PjXaSVbrpDfgtn6UbDyWjSRnXvfdebweUYSZ+eA@mail.gmail.com>
Subject: Re: Possible duplicate page fault accounting on some archs after
 commit 4064b9827063
Content-Type: text/plain; charset="UTF-8"
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=kernel.org@lists.infradead.org
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Xu <peterx@redhat.com>, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-hexagon@vger.kernel.org, Ley Foon Tan <ley.foon.tan@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-xtensa@linux-xtensa.org, linux-um <linux-um@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, openrisc@lists.librecores.org, Guan Xuetao <gxt@pku.edu.cn>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200610165349.SCkyjbKcxcR3Dfc7h9AnciQbyVFnF6wh8nYx2NjrvTI@z>

On Wed, Jun 10, 2020 at 8:48 AM Gerald Schaefer
<gerald.schaefer@de.ibm.com> wrote:
>
> This was found by coincidence in s390 code, and a quick check showed that
> there are quite a lot of other architectures that seem to be affected in a
> similar way. I'm preparing a fix for s390, by moving the accounting behind
> the retry loop, similar to x86. It is not completely straight-forward, so
> I leave the fix for other archs to the respective maintainers.

Hmm. I wonder if we could move the handling into  handle_mm_fault() itself.

It's _fairly_ trivial to do on the arch side, just as long as you
remember to make the VM_FAULT_MAJOR bit sticky like x86 does with that

        major |= fault & VM_FAULT_MAJOR;

right after handle_mm_fault(). But it certainly doesn't seem like it
would be hard to move into common code in handle_mm_fault() either, by
just not doing the accounting if it's about to return VM_FAULT_RETRY
or VM_FAULT_ERROR.

That said, we want that perf_sw_event() accounting too, so we'd have
to pass in a 'struct regs *' as well. And it's not clear which way
accounting should go for other callers of handle_mm_fault() (ie gup
etc).

So I guess just having architectures fix it up individually and make
sure they don't do it for retry conditions is the right thing to do..

             Linus
