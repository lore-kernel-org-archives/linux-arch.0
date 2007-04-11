Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60726 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbXDKKrw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 06:47:52 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1176257950.26372.50.camel@localhost.localdomain> 
References: <1176257950.26372.50.camel@localhost.localdomain>  <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> <6632.1176200270@redhat.com> 
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added to -mm tree 
Date: Wed, 11 Apr 2007 11:47:03 +0100
Message-ID: <14881.1176288423@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Rusty Russell <rusty@rustcorp.com.au> wrote:

> You're the second one to ask this.  I'm pretty sure it's still right
> (and it's what the old code used to do).

On reconsideration, I'll withdraw my objection.  I think you're right.

> Consider the case where limit is 0xC0000000, val is 0xBFFFFFFF and len
> is 1.

Better still, consider val=0, len=1 and limit=1 as it's much easier to do in
one's head.  I was thinking about the limit case only (I could see wrap-around
is taken care of).


It might be better to call your function something like limit_check().  You
don't really mean val_outside() you mean range_outside() or something.


Also, I agree that having a standard function to detect it is a good thing to
do.  We have to make this check so often, and occasionally it's got wrong.

A further thought for you... might it be worth having a wrapper macro that
casts the val argument (and possibly the limit) to unsigned long?  Quite often
what you want to check are pointers.


Anyway:

Acked-By: David Howells <dhowells@redhat.com>
