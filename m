From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] thread_info: factor out restart_block
Date: Mon, 24 Oct 2016 10:45:38 +0100
Message-ID: <20161024094538.GA15620@leverpostej>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
 <1476901693-8492-3-git-send-email-mark.rutland@arm.com>
 <CALCETrX88DxqBd2D0QB4p39cgZLK6PSTj2hLX_fUh0krDee3iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755895AbcJXJqN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Oct 2016 05:46:13 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrX88DxqBd2D0QB4p39cgZLK6PSTj2hLX_fUh0krDee3iw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Oct 19, 2016 at 04:31:02PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 19, 2016 at 11:28 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Since commit f56141e3e2d9aabf ("all arches, signal: move restart_block
> > to struct task_struct"), thread_info and restart_block have been
> > logically distinct, yet struct restart_block is still defined in
> > <linux/thread_info.h>.
> >
> > At least one architecture (erroneously) uses restart_block as part of
> > its thread_info, and thus the definition of restart_block must come
> > before the include of <asm/thread_info>. Subsequent patches in this
> > series need to shuffle the order of includes and definitions in
> > <linux/thread_info.h>, and will make this ordering fragile.
> >
> > This patch moves the definition of restart_block out to its own header.
> > This serves as generic cleanup, logically separating thread_info and
> > restart_block, and also makes it easier to avoid fragility.
> 
> Looks entirely reasonable to me.
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>

Thanks, that's much appreciated.

Now that Heiko's patch is in -rc2 I'd like to be able to put these two
patches into a stable branch.

Before I do that, would you also be happy to ack/review patch 3?

Thanks,
Mark.
