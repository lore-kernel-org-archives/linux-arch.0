Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992478AbXDLKuL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Apr 2007 06:50:11 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1176331924.14322.98.camel@localhost.localdomain> 
References: <1176331924.14322.98.camel@localhost.localdomain>  <1176297479.14322.69.camel@localhost.localdomain> <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com> <1176257950.26372.50.camel@localhost.localdomain> <20070410194834.b688ce55.akpm@linux-foundation.org> <400.1176310986@redhat.com> 
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added to -mm tree 
Date: Thu, 12 Apr 2007 11:49:06 +0100
Message-ID: <751.1176374946@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Rusty Russell <rusty@rustcorp.com.au> wrote:

> 
> "if (check_range_limit())" seems like the reverse of "if
> (range_over_limit())" tho.

True.  However, I like your range_over_limit() name better as it means you
don't need a "!" operator or a comparator when using it.

David
