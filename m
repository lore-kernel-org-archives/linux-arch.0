Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:44170 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261880AbUFETeP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Jun 2004 15:34:15 -0400
Date: Sat, 5 Jun 2004 12:31:50 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: sys getdents64 needs compat wrapper ?
Message-Id: <20040605123150.562eda8e.davem@redhat.com>
In-Reply-To: <20040605114113.13926473.akpm@osdl.org>
References: <26879984$108644643740c1db65f33611.91624784@config13.schlund.de>
	<20040605114113.13926473.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: arnd@arndb.de, arun.sharma@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 5 Jun 2004 11:41:13 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Easier to read, yes.  But __put_user() is faster.  It's a single
> instruction!

It emits a lot of fixup code though, multiply that by the number of
struct members you're copying over and over the entire kernel it begins
to be a non-trivial amount of .text space.

Actually, even the main part is 2 instructions on Sparc.  One to
do the load/store and one to clear the return value to zero for
success.

It would be much better to have a generic way on each platform to
operate on a series of user structure members like this is so
that the code output looks like:

	load/store	[%ptr + 0], %reg0	! struct foo->a
	load/store	[%ptr + 4], %reg1	! struct foo->b
	load/store	[%ptr + 8], %reg2	! struct foo->c
	clr		%retval
exception_label:

That is the optimal solution for these things.  Because right now
we get code like:

	load/store	[%ptr + 0], %reg0	! struct foo->a
	clr		%retval
exception_label1:
	cmp		%retval, 0
	bne		fault_path
	load/store	[%ptr + 4], %reg1	! struct foo->b
	clr		%retval
exception_label2:
	cmp		%retval, 0
	bne		fault_path
	load/store	[%ptr + 8], %reg2	! struct foo->c
	clr		%retval
exception_label3:

But the optimization is terribly hard to do generic, and the
register availability for such tricks is very platform dependent.
