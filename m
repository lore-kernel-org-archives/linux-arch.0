Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267553AbUIWXhx@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:9353 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267548AbUIWXhQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 19:37:16 -0400
Subject: Re: [PATCH] I/O space write barrier
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20040923222250.GB157288@sgi.com>
References: <200409231448.21887.jbarnes@engr.sgi.com>
	<1095966238.3043.26.camel@mulgrave>
	<200409231507.26672.jbarnes@engr.sgi.com>
	<1095967651.2157.42.camel@mulgrave>  <20040923222250.GB157288@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 23 Sep 2004 19:36:52 -0400
Message-Id: <1095982621.1572.4.camel@mulgrave>
Mime-Version: 1.0
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-09-23 at 18:22, Jeremy Higdon wrote:
> James, is this what you want?
> I think these are the only writes that need ordering, as opposed to flushing.
> Being not certain what was intended in the other cases, it's safer to leave
> them be.

Well, these two are just the kicks to tell the card that we have filled
a consistent memory slot with a SCSI command.  The ordering, I assume,
is because we want SCSI commands issued in the order they went down to
queuecommand in, so the mmiowb() preserves that order?  Could we have a
comment to that effect.

My objection isn't so much that what the original patch did would result
in errors, merely that we have enough trouble explaining these issues to
device driver writers, so whatever you do in your patches demonstrating
use has to be really exemplary.

James
