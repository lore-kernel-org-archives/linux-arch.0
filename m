Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:53784 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161334AbXDKWwZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 18:52:25 -0400
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
	added to -mm tree
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <400.1176310986@redhat.com>
References: <1176297479.14322.69.camel@localhost.localdomain>
	 <200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	 <6632.1176200270@redhat.com>
	 <1176257950.26372.50.camel@localhost.localdomain>
	 <20070410194834.b688ce55.akpm@linux-foundation.org>
	 <400.1176310986@redhat.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 08:52:04 +1000
Message-Id: <1176331924.14322.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-04-11 at 18:03 +0100, David Howells wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > static inline bool range_over_limit(unsigned long start,
> > 				    unsigned long len,
> > 				    unsigned long limit)
> 
> I'm still not sure the name is entirely clear, but it's better.  I'd still
> stick the word "check" in there personally, perhaps check_range_limit(), but
> that's just my preference.

"if (check_range_limit())" seems like the reverse of "if
(range_over_limit())" tho.

> > PS.  Previously this identical function was called __range_ok() (and
> > returned 0 if it was not ok...)
> 
> Ummm...  Didn't __range_ok() implicitly involve get_addr_limit() rather than
> taking an explicit range?  Certainly i386 thinks so:

Yep, my bad.  I was thinking of the sense of the return value.

Thanks,
Rusty.

