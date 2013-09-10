From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 7/7] sched, x86: Optimize the preempt_schedule() call
Date: Tue, 10 Sep 2013 16:25:17 +0200
Message-ID: <20130910142517.GA8388@gmail.com>
References: <20130910130811.507933095@infradead.org>
 <20130910132011.474646746@infradead.org>
 <20130910134247.GC7537@gmail.com>
 <522F410702000078000F1EE0@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:65369 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab3IJOZX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Sep 2013 10:25:23 -0400
Content-Disposition: inline
In-Reply-To: <522F410702000078000F1EE0@nat28.tlf.novell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Mike Galbraith <bitbucket@online.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Anvin <hpa@zytor.com>


* Jan Beulich <JBeulich@suse.com> wrote:

> >>> On 10.09.13 at 15:42, Ingo Molnar <mingo@kernel.org> wrote:
> 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> +	.macro SAVE_ALL
> >> +	pushl_cfi %eax
> >> +	CFI_REL_OFFSET eax, 0
> >> +	pushl_cfi %ebp
> >> +	CFI_REL_OFFSET ebp, 0
> >> +	pushl_cfi %edi
> >> +	CFI_REL_OFFSET edi, 0
> >> +	pushl_cfi %esi
> >> +	CFI_REL_OFFSET esi, 0
> >> +	pushl_cfi %edx
> >> +	CFI_REL_OFFSET edx, 0
> >> +	pushl_cfi %ecx
> >> +	CFI_REL_OFFSET ecx, 0
> >> +	pushl_cfi %ebx
> >> +	CFI_REL_OFFSET ebx, 0
> >> +	.endm
> >> +
> >> +	.macro RESTORE_ALL
> >> +	popl_cfi %ebx
> >> +	CFI_RESTORE ebx
> >> +	popl_cfi %ecx
> >> +	CFI_RESTORE ecx
> >> +	popl_cfi %edx
> >> +	CFI_RESTORE edx
> >> +	popl_cfi %esi
> >> +	CFI_RESTORE esi
> >> +	popl_cfi %edi
> >> +	CFI_RESTORE edi
> >> +	popl_cfi %ebp
> >> +	CFI_RESTORE ebp
> >> +	popl_cfi %eax
> >> +	CFI_RESTORE eax
> >> +	.endm
> > 
> > Side note: shouldn't the pushl_cfi and popl_cfi macros be adjusted, 
> > instead of open coding it?
> 
> If you mean the open coding of CFI_REL_OFFSET and CFI_RESTORE, then no - 
> there may be pushes/pops that don't save the caller's register values 
> (i.e. where solely the frame pointer adjustment matters).

Ok.

> If you meant something else, please clarify what.

No, that's what I meant.

Thanks,

	Ingo
