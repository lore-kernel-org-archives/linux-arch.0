Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:54548 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab1JLRIc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2011 13:08:32 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1RE2IA-0003pc-Eg
	from <mingo@elte.hu>
	for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2011 19:08:30 +0200
Date: Wed, 12 Oct 2011 18:57:22 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/7] Add assertion support with annotated oopsing
Message-ID: <20111012165719.GA18407@elte.hu>
References: <20111012164717.539.44368.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111012164717.539.44368.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20111012165722.V-wlwFQfyXRXWfz-1ttmJmZcmcP9FWignTpCjNneQzo@z>


* David Howells <dhowells@redhat.com> wrote:

> Add the ability to create an annotated oops report.  This is useful for
> displaying the output of assertion failures where direct display of the values
> being checked is of greater value than the register dump.
> 
> This could technically be done simply by issuing one or more printk() calls
> followed by a BUG() but in practice this has a serious disadvantage in that
> people reporting a bug usually seem to take the "cut here" line literally and
> discard everything prior to it when making a report - thus eliminating the most
> important bit of information after the file/line number.
> 
> There are number of possible solutions to this.  I've used the last in this
> list:
> 
>  (1) Emit the "cut here" line early, suppressing the one produced by the BUG()
>      handler.  This would allow the annotation to be formed of multiple
>      printk() calls.
> 
>  (2) Get rid of the "cut here" line entirely.
> 
>  (3) Pass the annotation through to the exception handler.  For practical
>      reasons, this limits the number of annotations to a single format string
>      and parameters.  This means that a va_list has to be passed through and
>      thence to vprintk() - which should be okay.  It also requires arch support
>      to retrieve the annotation data.
> 
> 
> This facility can be made use of by #including <linux/assert.h> and then
> calling:
> 
> 	void assertion_failed(const char *fmt, ...);
> 
> This prints a report that looks like:
> 
> 	------------[ cut here ]------------
> 	ASSERTION FAILED at fs/dcache.c:863!
> 	invalid opcode: 0000 [#1] SMP
> 	...
> 
> if fmt is NULL and:
> 
> 	------------[ cut here ]------------
> 	ASSERTION FAILED at fs/dcache.c:863!
> 	Dentry 0xffff880032675ed8{i=242,n=Documents} still in use (1) [unmount of nfs 12:01]
> 	invalid opcode: 0000 [#1] SMP
> 	...
> 
> otherwise.
> 
> For this to work the arch code must provide two things:
> 
> 	#define arch_assertion_failed(struct assertion_failure *desc)
> 
> to perform the oops and:
> 
> 	#define arch_assertion_failure(struct pt_regs *regs)
> 
> for report_bug() to find whether or not an assertion failure occurred and, if
> so, return a pointer to its description as passed to arch_assertion_failure().
> 
> If arch_assertion_failed() is not defined, then the code will fall back to
> doing a printk() and a BUG().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  arch/x86/include/asm/bug.h |   14 ++++++++++++++
>  include/asm-generic/bug.h  |    1 +
>  include/linux/assert.h     |   36 ++++++++++++++++++++++++++++++++++++
>  kernel/panic.c             |   31 +++++++++++++++++++++++++++++++
>  lib/bug.c                  |   16 ++++++++++++++++
>  5 files changed, 98 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/assert.h

Looks useful, but i'd suggest to make this a variant of the standard 
BUG_ON()/WARN_ON() checks we already have, not an explicit assert().

BUG_ON_VERBOSE() or such.

I find assert()'s inversion confusing when mixed with 
WARN_ON()/BUG_ON().

Likewise, the message of:

       	ASSERTION FAILED at fs/dcache.c:863!

is rather confusing to me (i never know how the condition printed is 
to be interpreted) - why not use the usual 'BUG: ...' message 
convention?

Thanks,

	Ingo
