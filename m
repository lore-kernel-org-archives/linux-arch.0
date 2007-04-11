Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:32895 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbXDKKtb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 06:49:31 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070410194834.b688ce55.akpm@linux-foundation.org> 
References: <20070410194834.b688ce55.akpm@linux-foundation.org>  <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com> <1176257950.26372.50.camel@localhost.localdomain> 
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added to -mm tree 
Date: Wed, 11 Apr 2007 11:49:19 +0100
Message-ID: <14926.1176288559@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@linux-foundation.org> wrote:

> To me, "val_outside" means "true if the value is outside":
> 
> bool val_outside(val, start, len)
> {
> 	return val < start || val > (start+len-1);
> }
> 
> that's what my function does.

Seconded.  Again, I would suggest calling it something like limit_check() or
range_check().

David
