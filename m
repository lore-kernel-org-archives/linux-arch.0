Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35742 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEX14 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2018 19:27:56 -0400
Date: Wed, 5 Sep 2018 20:56:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180905185617.GC24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902173224.30606-1-namit@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Nadav Amit <nadav.amit@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180905185617.EfMqBQaYiiWWdPgk4f3yIcxEoDJZ_ckmlZPHyTGZEd0@z>

On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
> This patch-set addresses some issues that were raised in a recent
> correspondence and might affect the security and the correctness of code
> patching. (Note that patching performance is not addressed by this
> patch-set).
> 
> The main issue that the patches deal with is the fact that the fixmap
> PTEs that are used for patching are available for access from other
> cores and might be exploited. They are not even flushed from the TLB in
> remote cores, so the risk is even higher. Address this issue by
> introducing a temporary mm that is only used during patching.
> Unfortunately, due to init ordering, fixmap is still used during
> boot-time patching. Future patches can eliminate the need for it.
> 

Remind me; why are we doing it like this instead of fixing fixmap?
Because while this fixes the text_poke crud, it does leave fixmap
broken.
