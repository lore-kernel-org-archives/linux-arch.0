Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbeIFV7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 17:59:35 -0400
Date: Thu, 6 Sep 2018 19:23:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906172300.GK24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180906172300.9BES8SqbB0hAwR3QLqQ7KbzjutohxF9E36Samaxf0AY@z>

On Thu, Sep 06, 2018 at 05:01:25PM +0000, Nadav Amit wrote:
> I’ll give your patch a try once my server goes back online. I was (and still
> am) worried that interrupts would be disabled when __set_pte_vaddr() is
> called, which would make the fix more complicated.

Thing is, we only need the TLB invalidate if the previous PTE was
present and the new PTE is different. If we write the 'first' PTE, all
is fine.

The code as presented WARNs if we do __set_pte_vaddr() that needs a TLB
invalidate and we have IRQs disabled. And aside from the GHES
trainwreck, the patch as given boots and runs fine on my machine.

And no, if there is a caller that has interrupts disabled and needs TLB
invalidate, the patch still is right. Just means that caller is
terminally broken and needs fixing (like GHES).

There is no way x86 can do what needs done with IRQs disabled.
