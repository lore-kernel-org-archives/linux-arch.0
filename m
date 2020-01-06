Return-Path: <SRS0=948I=23=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgAFEL2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 23:11:28 -0500
Date: Mon, 6 Jan 2020 05:11:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch V2 09/17] x86/entry: Remove _TIF_NOHZ from
 _TIF_WORK_SYSCALL_ENTRY
Message-ID: <20200106041124.GA26097@lenoir>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.491328859@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123118.491328859@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Message-ID: <20200106041125.N1S5nME4crqck_AWSPxR4lXBWGsnrY-y2uAFITPjHJ8@z>

On Wed, Oct 23, 2019 at 02:27:14PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
> is not only pointless, it's actually counterproductive:
> 
>  1) Context tracking code is invoked unconditionally before that flag is
>     evaluated.
> 
>  2) If the flag is set the slow path is invoked for nothing due to #1
> 
> Remove it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

I'm borrowing this patch for a series of mine. But if you apply
it in the meantime, that would be even better :-)

Thanks!
