Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHz3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Feb 2019 02:55:29 -0500
Date: Mon, 11 Feb 2019 16:55:24 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190211075524.GA26690@jagdpanzerIV>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190208185515.r6vkrezbd3odhpxt@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208185515.r6vkrezbd3odhpxt@home.goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
Message-ID: <20190211075524.jib8lDzCy_WolBAmI2j-YnG2ZBOvCxZj5jy_bs9FtBI@z>

On (02/08/19 13:55), Steven Rostedt wrote:
[..]
> > +	if (len) {
> > +		/*
> > +		 * Order the stores above in vsnprintf() vs the store of the
> > +		 * space below which joins the two strings. Note this doesn't
> > +		 * make the code truly race free because there is no barrier on
> > +		 * the read side. ie. Another CPU might load the uninitialised
> > +		 * tail of the buffer first and then the space below (rather
> > +		 * than the NULL that was there previously), and so print the
> > +		 * uninitialised tail. But the whole string lives in BSS so in
> > +		 * practice it should just see NULLs.
> > +		 */
> > +		smp_wmb();
> 
> This shows me that this can be called at a time when more than one CPU is
> active. What happens if we have two CPUs calling dump_stack_add_arch_desc() at
> the same time? Can't that corrupt the dump_stack_arch_desc_str?

Can overwrite part of it, I guess (but it seems that Michael
is OK with this). The string is still NULL terminated.

The worst case scenario I can think of is not the one when
two CPUs call dump_stack_add_arch_desc(), but when CPUA calls
dump_stack_add_arch_desc() to append some data and at the
same time CPUB calls dump_stack_set_arch_desc() and simply
overwrites dump_stack_arch_desc_str. Not sure if this is
critical (or possible).

	-ss
