Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268225AbUIWT1m@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:13769 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268158AbUIWT1m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 15:27:42 -0400
Subject: Re: [PATCH] I/O space write barrier
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <200409231507.26672.jbarnes@engr.sgi.com>
References: <200409231448.21887.jbarnes@engr.sgi.com>
	<1095966238.3043.26.camel@mulgrave>
	<200409231507.26672.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 23 Sep 2004 15:27:24 -0400
Message-Id: <1095967651.2157.42.camel@mulgrave>
Mime-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-arch@vger.kernel.org, jeremy@sgi.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-09-23 at 15:07, Jesse Barnes wrote:
> If we're waiting for an interrupt here, I don't think it matters if we flush 
> or order, we'll wait the same amount of time regardless.

I don't think so.  Your ordering barrier doesn't cause a posted write
flush.  Posted writes have theoretically no upper limit defined in the
spec for the time they may remain posted, so in the former case, you are
guaranteed that by the time you set the flag and exit the function that
interrupts are enabled in the qla1280.  If you apply the patch you sent
in, this guarantee is broken and you don't really know how much longer
after exiting the function it will be before interrupts become enabled
(although in practice it's probably only of the order of ms).

James
