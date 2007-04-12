Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58290 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992462AbXDLKs0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Apr 2007 06:48:26 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1176334892.14322.137.camel@localhost.localdomain> 
References: <1176334892.14322.137.camel@localhost.localdomain>  <20070410194834.b688ce55.akpm@linux-foundation.org> <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com> <1176257950.26372.50.camel@localhost.localdomain> <14926.1176288559@redhat.com> <20070411112452.6979414c.akpm@linux-foundation.org> 
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added to -mm tree 
Date: Thu, 12 Apr 2007 11:47:47 +0100
Message-ID: <720.1176374867@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Rusty Russell <rusty@rustcorp.com.au> wrote:

> +static inline bool range_over_limit(unsigned long start, unsigned long len,
> +				    unsigned long limit)

I like it.

> + * range_over_limit() - is a start and length past a limit?

As I understand it you wouldn't normally put "()" there for kdoc comments.

David
