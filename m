Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267807AbUIXFDU@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:31463 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267804AbUIXFDU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Sep 2004 01:03:20 -0400
Date: Thu, 23 Sep 2004 22:03:14 -0700
From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20040924050314.GA158288@sgi.com>
References: <200409231448.21887.jbarnes@engr.sgi.com> <1095966238.3043.26.camel@mulgrave> <200409231507.26672.jbarnes@engr.sgi.com> <1095967651.2157.42.camel@mulgrave> <20040923222250.GB157288@sgi.com> <1095982621.1572.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095982621.1572.4.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 23, 2004 at 07:36:52PM -0400, James Bottomley wrote:
> On Thu, 2004-09-23 at 18:22, Jeremy Higdon wrote:
> > James, is this what you want?
> > I think these are the only writes that need ordering, as opposed to flushing.
> > Being not certain what was intended in the other cases, it's safer to leave
> > them be.
> 
> Well, these two are just the kicks to tell the card that we have filled
> a consistent memory slot with a SCSI command.  The ordering, I assume,
> is because we want SCSI commands issued in the order they went down to
> queuecommand in, so the mmiowb() preserves that order?  Could we have a
> comment to that effect.

Okay, I'll add a comment there.  On the qla1280, it's worse than just
out of order.  If the write order is switched, the chip will issue an
entire queue's worth of stale commands.

> My objection isn't so much that what the original patch did would result
> in errors, merely that we have enough trouble explaining these issues to
> device driver writers, so whatever you do in your patches demonstrating
> use has to be really exemplary.

I think there was also the issue of whether we wanted a flush or just
ordering for the interrupt enable/disable.  Since we don't really know,
and since it's not a performance path, it's safer to leave it a flush
after those.

Is the following diff what you're thinking of, James?
I'm not entirely happy with it, and could spend more time on it.

===== drivers/scsi/qla1280.c 1.65 vs edited =====
--- 1.65/drivers/scsi/qla1280.c	2004-07-28 20:59:10 -07:00
+++ edited/drivers/scsi/qla1280.c	2004-09-23 21:58:40 -07:00
@@ -3398,7 +3398,18 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+
+	/*
+	 * A Memory Mapped I/O Write Barrier is needed to ensure that this write
+	 * of the request queue in register is ordered ahead of writes issued
+	 * after this one by other CPUs.  Access to the register is protected
+	 * by the host_lock.  Without the mmiowb, however, it is possible for
+	 * this CPU to release the host lock, another CPU acquire the host lock,
+	 * and write to the request queue in, and have the second write make it
+	 * to the chip first.  See Documentation/DocBook/deviceiobook.tmpl for
+	 * more information.
+	 */
+	mmiowb(); /* posted write ordering */
 
  out:
 	if (status)
@@ -3666,7 +3677,18 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+
+	/*
+	 * A Memory Mapped I/O Write Barrier is needed to ensure that this write
+	 * of the request queue in register is ordered ahead of writes issued
+	 * after this one by other CPUs.  Access to the register is protected
+	 * by the host_lock.  Without the mmiowb, however, it is possible for
+	 * this CPU to release the host lock, another CPU acquire the host lock,
+	 * and write to the request queue in, and have the second write make it
+	 * to the chip first.  See Documentation/DocBook/deviceiobook.tmpl for
+	 * more information.
+	 */
+	mmiowb(); /* posted write ordering */
 
 out:
 	if (status)
@@ -3778,7 +3800,18 @@
 
 	/* Set chip new ring index. */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+
+	/*
+	 * A Memory Mapped I/O Write Barrier is needed to ensure that this write
+	 * of the request queue in register is ordered ahead of writes issued
+	 * after this one by other CPUs.  Access to the register is protected
+	 * by the host_lock.  Without the mmiowb, however, it is possible for
+	 * this CPU to release the host lock, another CPU acquire the host lock,
+	 * and write to the request queue in, and have the second write make it
+	 * to the chip first.  See Documentation/DocBook/deviceiobook.tmpl for
+	 * more information.
+	 */
+	mmiowb(); /* posted write ordering */
 
 	LEAVE("qla1280_isp_cmd");
 }
