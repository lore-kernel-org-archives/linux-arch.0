From: David Howells <dhowells@redhat.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"): BUG: KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Date: Fri, 12 Apr 2019 17:50:30 +0100
Message-ID: <5890.1555087830@warthog.procyon.org.uk>
References: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com> <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com> <20190411193906.GA12232@hirez.programming.kicks-ass.net> <20190411195424.GL14281@hirez.programming.kicks-ass.net> <20190411211348.GA8451@worktop.programming.kicks-ass.net> <20190412105633.GM14281@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com>
Content-ID: <5889.1555087830.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>, kernel test robot <lkp@intel.com>, LKP <lkp@01.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>
List-Id: linux-arch.vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> We should never have stack alignment bigger than 16 bytes.  And
> preferably not even that.

At least one arch I know of (FRV) had instructions that could atomically
load/store register pairs or register quads, but they had to be pair- or
quad-aligned (ie. 8- or 16-byte), which made for more efficient code if you
could use them.

I don't know whether any arch we currently support has features like this (I
know some have multi-reg load/stores, but they seem to require only
word-alignment).

David
