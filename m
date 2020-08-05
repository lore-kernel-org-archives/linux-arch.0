From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 18/29] arm64: mte: Allow user control of the tag check
 mode via prctl()
Date: Wed, 5 Aug 2020 10:24:18 +0100
Message-ID: <20200805092418.GB13391@gaia>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-19-catalin.marinas@arm.com>
 <9342a080-9450-c01a-54a0-9ddebfe45613@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgHEJYX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 05:24:23 -0400
Content-Disposition: inline
In-Reply-To: <9342a080-9450-c01a-54a0-9ddebfe45613@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Aug 04, 2020 at 08:34:42PM +0100, Kevin Brodsky wrote:
> On 15/07/2020 18:08, Catalin Marinas wrote:
> > By default, even if PROT_MTE is set on a memory range, there is no tag
> > check fault reporting (SIGSEGV). Introduce a set of option to the
> > exiting prctl(PR_SET_TAGGED_ADDR_CTRL) to allow user control of the tag
> > check fault mode:
> > 
> >    PR_MTE_TCF_NONE  - no reporting (default)
> >    PR_MTE_TCF_SYNC  - synchronous tag check fault reporting
> >    PR_MTE_TCF_ASYNC - asynchronous tag check fault reporting
> > 
> > These options translate into the corresponding SCTLR_EL1.TCF0 bitfield,
> > context-switched by the kernel. Note that uaccess done by the kernel is
> > not checked and cannot be configured by the user.
> 
> The last sentence is outdated, it should probably say that uaccess is only
> checked in in synchronous mode.

Thanks, I forgot about the commit log. The documentation was updated to:

**Note**: Kernel accesses to the user address space (e.g. ``read()``
system call) are not checked if the user thread tag checking mode is
``PR_MTE_TCF_NONE`` or ``PR_MTE_TCF_ASYNC``. If the tag checking mode is
``PR_MTE_TCF_SYNC``, the kernel makes a best effort to check its user
address accesses, however it cannot always guarantee it.

-- 
Catalin
