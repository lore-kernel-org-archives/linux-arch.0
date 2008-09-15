From: Roland McGrath <roland@redhat.com>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Mon, 15 Sep 2008 13:38:35 -0700 (PDT)
Message-ID: <20080915203835.E2438242E5@pipsqueak.localdomain>
References: <20080912025733.E55F415420D@magilla.localdomain>
	<20080912130511.GA11375@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38314 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444AbYIOUio (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Sep 2008 16:38:44 -0400
In-Reply-To: Paul Mundt's message of  Friday, 12 September 2008 22:05:11 +0900 <20080912130511.GA11375@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org

> user_stack_pointer() is apparently a requirement, too. 

Ah, yes!  I'd forgotten about user_stack_pointer() and instruction_pointer().
Those never got properly documented either.

> Although given that you already have a task_struct pointer the only place
> you currently use it (lib/syscall.c), it makes more sense to use
> KSTK_ESP/KSTK_EIP which is provided by almost everyone already.

Almost?  It must be everyone, right?  
It's used unconditionally in fs/proc/array.c (the only use).

I hadn't noticed these before.  They aren't commented anywhere.
I've got to say, too, these are truly dismal names!

Also, I've just noticed that x86-64's user_stack_pointer() is wrong for the
case when a fast-path 64-bit syscall is in progress.  To get it right, it
needs a bit from the struct thread_info, so a call that takes task_struct
instead of (or in addition to) pt_regs is certainly right.

These are defined in asm/processor.h, as macros.  It would be better if
they could be inlines, but they really can't because asm/processor.h is
before struct task_struct is defined, etc.  I wonder if we could move these
to another header where they can be clean inlines.  I'd sure like to change
those names while we're at it.

Thoughts?


Thanks,
Roland
