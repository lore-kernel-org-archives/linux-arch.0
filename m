From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/7] x86: relocate get/set debugreg fcns to
 include/asm/debugreg.
Date: Fri, 27 Jan 2012 14:28:32 -0500
Message-ID: <20120127192831.GB7150@windriver.com>
References: <1327632272-12928-1-git-send-email-paul.gortmaker@windriver.com>
 <1327632272-12928-2-git-send-email-paul.gortmaker@windriver.com>
 <20120127115136.GA26228@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43930 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab2A0T3d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2012 14:29:33 -0500
Content-Disposition: inline
In-Reply-To: <20120127115136.GA26228@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, gregkh@suse.de, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

[Re: [PATCH 1/7] x86: relocate get/set debugreg fcns to include/asm/debugreg.] On 27/01/2012 (Fri 12:51) Ingo Molnar wrote:

> 
> * Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> 
> > Since we already have a debugreg.h header file, move the
> > assoc. get/set functions to it.  In addition to it being the
> > logical home for them, it has a secondary advantage.  The
> > functions that are moved use BUG().  So we really need to
> > have linux/bug.h in scope.  But asm/processor.h is used about
> > 600 times, vs. only about 15 for debugreg.h -- so adding bug.h
> > to the latter reduces the amount of time we'll be processing
> > it during a compile.
> > 
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > ---
> >  arch/x86/include/asm/debugreg.h  |   67 ++++++++++++++++++++++++++++++++++++++
> >  arch/x86/include/asm/processor.h |   63 -----------------------------------
> >  arch/x86/kernel/cpu/common.c     |    1 +
> >  3 files changed, 68 insertions(+), 63 deletions(-)
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> I suspect you'd like to carry this in your tree, so that all 
> these patches are together?

Yes, that was my original intent, unless there is a consensus
from people indicating that they'd really rather not see such
standalone cleanup trees exist at all.

Thanks,
Paul.

> 
> Thanks,
> 
> 	Ingo
