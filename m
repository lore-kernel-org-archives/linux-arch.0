Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268293AbUIWTEM@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:51360 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268225AbUIWTEM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 15:04:12 -0400
Subject: Re: [PATCH] I/O space write barrier
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <200409231448.21887.jbarnes@engr.sgi.com>
References: <200409231448.21887.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 23 Sep 2004 15:03:51 -0400
Message-Id: <1095966238.3043.26.camel@mulgrave>
Mime-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-09-23 at 14:48, Jesse Barnes wrote:
> -	RD_REG_WORD(&reg->ictrl);	/* PCI Posted Write flush */
> +	mmiowb(); /* make sure this write arrives before any others */

What's going on here?  In your docs you say this mmiowb() is explicitly
to prevent write ordering problems and doesn't affect posting.  However
in this patch you're using it to replace a posting flush read.

>  	ha->flags.ints_enabled = 1;

The result will be that we can get to here, but the write that enables
the interrupt may still be posted in a bridge somewhere.

James
