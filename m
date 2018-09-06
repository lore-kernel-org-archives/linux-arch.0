Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48678 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbeIGARX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 20:17:23 -0400
Date: Thu, 6 Sep 2018 21:40:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Message-ID: <20180906194003.GD4816@worktop.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902173224.30606-2-namit@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Nadav Amit <nadav.amit@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180906194003.mzlvvrZc93vsvx2D38nGciak_NJXEdON55kT6fl7Q5k@z>

On Sun, Sep 02, 2018 at 10:32:19AM -0700, Nadav Amit wrote:
> text_mutex is expected to be held before text_poke() is called, but we
> cannot add a lockdep assertion since kgdb does not take it, and instead
> *supposedly* ensures the lock is not taken and will not be acquired by
> any other core while text_poke() is running.
> 
> The reason for the "supposedly" comment is that it is not entirely clear
> that this would be the case if gdb_do_roundup is zero.

Argh, that's pretty shit code...

Not only is that text_mutex abuse ugly, so too is the fixmap usage from
IRQ context. I suppose this really does require your alternative mm
patches for text_poke().
