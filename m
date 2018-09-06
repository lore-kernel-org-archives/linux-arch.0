Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeIGBDM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 21:03:12 -0400
Date: Thu, 6 Sep 2018 22:25:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Message-ID: <20180906202547.GC9358@worktop.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
 <20180906195351.GB9358@worktop.programming.kicks-ass.net>
 <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180906202547.GoKcBHkmhWgw8vfCPq5Oi5LjQ3JAFSSRbRHmfZLNb0w@z>

On Thu, Sep 06, 2018 at 07:58:40PM +0000, Nadav Amit wrote:
> > With that CR3 trickery, we can rid ourselves of the text_mutex
> > requirement, since concurrent text_poke is 'safe'. That would clean up
> > the kgdb code quite a bit.
> 
> I don’t know. I’m somewhat worried with multiple mechanisms potentially
> changing the same code at the same time - and maybe ending up with some
> mess.

kgdb only pokes INT3, that should be pretty safe.
