From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Query on I/O accessors used by Xilinx SystemACE Driver
Date: Mon, 21 Jan 2013 18:50:51 +0530
Message-ID: <50FD40B3.804@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:45127 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3AUNVN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 08:21:13 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Simek <monstr@monstr.eu>, Geert Uytterhoeven <geert@linux-m68k.org>

Synopsys has Xilinx ML50x boards with our internal FPGA workflows, which we
sometimes use for internal development and customer evaluations. In that light
Alexey has been working on getting the stock systemACE driver to work with ARC
Linux Port.
One of things that he wants me to fix is introduce the PPC/m68k/microblaze style
in_8, in_le16, .... I/O accessors in ARC port, used specifically by driver.

I'm not an expert in that driver or the specific needs of those accessors on
respective arches, but was wondering, if it would be possible to convert the
driver to use the vanilla IO accessors (read{b,w,l}. Microblaze at least,  seem to
be defining them as straight wrappers over the standard raw accessors.

Ben, Geert could you please comment ?

Thx,
-Vineet
