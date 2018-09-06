Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIFXI6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 19:08:58 -0400
Date: Thu, 6 Sep 2018 20:31:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906183157.GK24106@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
 <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
 <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
 <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180906183157.eQM-L1vdIUyc1PYJhG1TVfDiN6QefHrf9-sPqD0vE2U@z>

On Thu, Sep 06, 2018 at 11:09:23AM -0700, Andy Lutomirski wrote:
> > On Sep 6, 2018, at 10:58 AM, Nadav Amit <namit@vmware.com> wrote:
> > It depends what security you want. Some may consider even the short
> > time-window in which the kernel code is writable from other cores as
> > insufficient for security.
> > 
> > In addition, the set removes the need for remote TLB shootdowns that
> > text_poke() - with this fix - requires.
> > 
> 
> I’m personally in favor of not needing a global broadcast flush to install kprobes.

That's fine. But at that point its an optimization, not a correctness
issue.
