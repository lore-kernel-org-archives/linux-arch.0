Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:31406 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751419AbWETQSz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 May 2006 12:18:55 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k4KGIsa25414
	for <linux-arch@vger.kernel.org>; Sat, 20 May 2006 12:18:54 -0400
Subject: Problem with sg_dma_address() on ia64, sh and sh64
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Date: Sat, 20 May 2006 11:18:53 -0500
Message-Id: <1148141933.3529.25.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is the defined accessor to our struct scatterlist.  These three
architectures define it in asm/pci.h rather than asm/scatterlist.h.
This means that one doesn't get the accessor simply by including
linux/scatterlist.h, which one should.  This means that non-pci uses
don't work (like our budding libsrp).

Could you all move it to where it should be?

Thanks,

James


