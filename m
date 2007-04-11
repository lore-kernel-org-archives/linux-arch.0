Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:55659 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbXDKSbb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 14:31:31 -0400
Date: Wed, 11 Apr 2007 11:31:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
 added to -mm tree
Message-Id: <20070411113101.6a444667.akpm@linux-foundation.org>
In-Reply-To: <400.1176310986@redhat.com>
References: <1176297479.14322.69.camel@localhost.localdomain>
	<200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	<6632.1176200270@redhat.com>
	<1176257950.26372.50.camel@localhost.localdomain>
	<20070410194834.b688ce55.akpm@linux-foundation.org>
	<400.1176310986@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Apr 2007 18:03:06 +0100
David Howells <dhowells@redhat.com> wrote:

> > static inline bool range_over_limit(unsigned long start,
> > 				    unsigned long len,
> > 				    unsigned long limit)
> 
> I'm still not sure the name is entirely clear, but it's better.  I'd still
> stick the word "check" in there personally, perhaps check_range_limit(), but
> that's just my preference.

If we (crazily) agree that we should/coould/might grow a suite of range-handling
functions then we should stick to the range_foo() namespace for that.
