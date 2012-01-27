Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:41061 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab2A0LwI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jan 2012 06:52:08 -0500
Date: Fri, 27 Jan 2012 12:51:36 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/7] x86: relocate get/set debugreg fcns to
 include/asm/debugreg.
Message-ID: <20120127115136.GA26228@elte.hu>
References: <1327632272-12928-1-git-send-email-paul.gortmaker@windriver.com>
 <1327632272-12928-2-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327632272-12928-2-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, gregkh@suse.de, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20120127115136.dXmFykxnmhM8mU09NYBHOymD4idZnF7KIJ3ymMBKB00@z>


* Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> Since we already have a debugreg.h header file, move the
> assoc. get/set functions to it.  In addition to it being the
> logical home for them, it has a secondary advantage.  The
> functions that are moved use BUG().  So we really need to
> have linux/bug.h in scope.  But asm/processor.h is used about
> 600 times, vs. only about 15 for debugreg.h -- so adding bug.h
> to the latter reduces the amount of time we'll be processing
> it during a compile.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/debugreg.h  |   67 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/processor.h |   63 -----------------------------------
>  arch/x86/kernel/cpu/common.c     |    1 +
>  3 files changed, 68 insertions(+), 63 deletions(-)

Acked-by: Ingo Molnar <mingo@elte.hu>

I suspect you'd like to carry this in your tree, so that all 
these patches are together?

Thanks,

	Ingo
