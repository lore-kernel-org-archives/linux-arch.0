Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:12497 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265776AbUFRX0j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jun 2004 19:26:39 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/linuxconf) with ESMTP id i5INQci03378
	for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2004 19:26:38 -0400
Subject: Accessing memory remote across the bus in the same way as local
	memory
From: James Bottomley <James.Bottomley@SteelEye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 18 Jun 2004 18:26:37 -0500
Message-Id: <1087601198.2134.206.camel@mulgrave>
Mime-Version: 1.0
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

The question has come up [in the DMA API issues thread on lkml] of
whether we can access on chip memory areas as though they were normal
memory (i.e. use normal reads and writes to access it).

The memory regions in question would have to be accessible via MMIO
cycles on the bus and be aligned and sized as multiples of PAGE_SIZE.

The question is given the constraints, can we pull page table tricks on
every platform to make this bus remote memory look like real memory?

I know ioremap() read[bwl]/write[bwl] etc. is what we currently tell
people to do, but I'm curious to know if there's actually a platform
that has some type of limitation that requires bus remote memory to be
treated differently.  Rather than simply being a convenience, like we
use it as on parisc today.

James
