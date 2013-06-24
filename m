From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2 0/3] make Xilinx System ACE driver arch-independent
Date: Mon, 24 Jun 2013 12:26:01 +0400
Message-ID: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:53934 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3FXI0W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 04:26:22 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

In v2 I put together 3 patches:
1. Blind replace of PPC/Microblaze-specific accessors with generic ones.
2. Fix functions that access data via dedicated register in SystemACE controller
so now CPU accesses data with native endianess.
3. Remove dependency on PPC/Microblaze - i.e. make driver arch-independent.

Alexey Brodkin (3):
  drivers/block/xsysace - replace in(out)_8/in(out)_be16/in(out)_le16
    with generic iowrite(read)8/16(be)
  drivers/block/xsysace - use "_rep" accessors with CPU endianess for
    data
  drivers/block - make Xilinx SystemACE driver arch-independent

 drivers/block/Kconfig   |    1 -
 drivers/block/xsysace.c |   74 ++++++++++++++---------------------------------
 2 files changed, 21 insertions(+), 54 deletions(-)


Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Mischa Jonker <mjonker@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
-- 
1.7.10.4
