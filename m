Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:27849 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266510AbUFQOI4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jun 2004 10:08:56 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/linuxconf) with ESMTP id i5HE8ti21499
	for <linux-arch@vger.kernel.org>; Thu, 17 Jun 2004 10:08:55 -0400
Subject: Proposal for new generic device API: dma_get_required_mask()
From: James Bottomley <James.Bottomley@SteelEye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 17 Jun 2004 09:08:54 -0500
Message-Id: <1087481335.2090.28.camel@mulgrave>
Mime-Version: 1.0
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[This is for notice only.  There's a thread on linux-kernel with the
same contents, lets hold the debate in public]

Background:

We have a large number of devices in scsi: aacraid, aic7xxx, qla1280,
qla2xxx which can all do full 64 bit DMA, but which pay a performance
penalty for using the larger descriptors (aic7xxx is stranger in that it
has three modes of operation: 32 bit, 39 bit and 64 bit each with an
increasing performance penalty).

What all these devices would like to do is instead of simply trying the
64 bit mask first and having the platform accept it, even if it only has
< 4GB of memory, they'd like to be able to have the platform tell them,
given my current dma mask setting, what's the actual number of bits you
need me to DMA to.

This is precisely what the API would do.  It would return a bit mask
(never over the current dma_mask) that the platform considers optimal. 
The platform has complete freedom in this: it may return a mask covering
the total physical memory, or a mask covering all the bits it needs
setting for some weird numa scheme.

If the driver decides to use the mask, it would do another
dma_set_mask() to confirm it (this gives the platform the opportunity if
it so chooses to return a mask that doesn't quite cover memory, but
would be more optimal...say for platforms that have all memory under 4GB
bar one small chunk at 64GB or something).

Once the driver has the platform's optimal mask, it can use this to
decide on the correct descriptor size.

Comments?

James
