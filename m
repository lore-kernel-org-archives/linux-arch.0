Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267518AbUIWWfE@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:44468 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267517AbUIWWdd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 18:33:33 -0400
Date: Thu, 23 Sep 2004 15:22:51 -0700
From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20040923222250.GB157288@sgi.com>
References: <200409231448.21887.jbarnes@engr.sgi.com> <1095966238.3043.26.camel@mulgrave> <200409231507.26672.jbarnes@engr.sgi.com> <1095967651.2157.42.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095967651.2157.42.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 23, 2004 at 03:27:24PM -0400, James Bottomley wrote:
> On Thu, 2004-09-23 at 15:07, Jesse Barnes wrote:
> > If we're waiting for an interrupt here, I don't think it matters if we flush 
> > or order, we'll wait the same amount of time regardless.
> 
> I don't think so.  Your ordering barrier doesn't cause a posted write
> flush.  Posted writes have theoretically no upper limit defined in the
> spec for the time they may remain posted, so in the former case, you are
> guaranteed that by the time you set the flag and exit the function that
> interrupts are enabled in the qla1280.  If you apply the patch you sent
> in, this guarantee is broken and you don't really know how much longer
> after exiting the function it will be before interrupts become enabled
> (although in practice it's probably only of the order of ms).
> 
> James

James, is this what you want?
I think these are the only writes that need ordering, as opposed to flushing.
Being not certain what was intended in the other cases, it's safer to leave
them be.


===== drivers/scsi/qla1280.c 1.65 vs edited =====
--- 1.65/drivers/scsi/qla1280.c	2004-07-28 20:59:10 -07:00
+++ edited/drivers/scsi/qla1280.c	2004-09-23 15:19:56 -07:00
@@ -3398,7 +3398,7 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	mmiowb(); /* posted write ordering */
 
  out:
 	if (status)
@@ -3666,7 +3666,7 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	mmiowb(); /* posted write ordering */
 
 out:
 	if (status)
@@ -3778,7 +3778,7 @@
 
 	/* Set chip new ring index. */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	mmiowb(); /* posted write ordering */
 
 	LEAVE("qla1280_isp_cmd");
 }
