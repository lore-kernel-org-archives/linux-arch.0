Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXDKRE3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 13:04:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1176297479.14322.69.camel@localhost.localdomain> 
References: <1176297479.14322.69.camel@localhost.localdomain>  <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com> <1176257950.26372.50.camel@localhost.localdomain> <20070410194834.b688ce55.akpm@linux-foundation.org> 
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added to -mm tree 
Date: Wed, 11 Apr 2007 18:03:06 +0100
Message-ID: <400.1176310986@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Rusty Russell <rusty@rustcorp.com.au> wrote:

> static inline bool range_over_limit(unsigned long start,
> 				    unsigned long len,
> 				    unsigned long limit)

I'm still not sure the name is entirely clear, but it's better.  I'd still
stick the word "check" in there personally, perhaps check_range_limit(), but
that's just my preference.

> PS.  Previously this identical function was called __range_ok() (and
> returned 0 if it was not ok...)

Ummm...  Didn't __range_ok() implicitly involve get_addr_limit() rather than
taking an explicit range?  Certainly i386 thinks so:

#define __range_ok(addr,size) ({ \
	unsigned long flag,roksum; \
	__chk_user_ptr(addr); \
	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
		:"=&r" (flag), "=r" (roksum) \
		:"1" (addr),"g" ((int)(size)),"rm" (current_thread_info()->addr_limit.seg)); \
	flag; })

David
