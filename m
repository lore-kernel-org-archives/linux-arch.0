Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:57307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbXDJKSb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Apr 2007 06:18:31 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> 
References: <200704062127.l36LRMA7019394@shell0.pdx.osdl.net> 
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch added to -mm tree 
Date: Tue, 10 Apr 2007 11:17:50 +0100
Message-ID: <6632.1176200270@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

akpm@linux-foundation.org wrote:

> + * @limit: the first invalid value

If this is the case, ...

> + *
> + * Like val + len > limit, except with overflow checking.
> + */
> +static inline bool val_outside(unsigned long val, unsigned long len,
> +			       unsigned long limit)
> +
> +{
> +	return val + len > limit || val + len < val;

... then shouldn't that be "val + len >= limit"?

David
