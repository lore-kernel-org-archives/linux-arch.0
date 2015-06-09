From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/8] ARCv2 port to Linux - (C) perf
Date: Tue, 9 Jun 2015 17:49:24 +0530
Message-ID: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52334 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbbFIMWt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:22:49 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Peter,

This mini-series adds perf support for ARCv2 based cores, which brings in
overflow interupts and SMP. Additionally now raw events are supported as well.

This is part of series which adds ARCv2 ISA support to linux.

Please see [1] for prep patches and [2] for actual port. I've CC'ed you
for some of the patches related to barriers, atomic ops in [2].

Some more info at
 - www.synopsys.com/dw/ipdir.php?ds=arc-hs38-processor
 - http://news.synopsys.com/2014-10-14-New-DesignWare-ARC-HS38-Processor-Doubles-Performance-for-Embedded-Linux-Applications
 - http://www.embedded.com/electronics-news/4435975/Synopsys-ARC-HS38-core-gives-2X-boost-to-Linux-based-apps

Please review !

Thx,
-Vineet

[1] https://lkml.org/lkml/2015/6/7/25
[2] http://www.spinics.net/lists/kernel/msg2009508.html

Alexey Brodkin (6):
  ARC: perf: support RAW events
  ARCv2: perf: implement "event_set_period" for future use with
    interrupts
  ARCv2: perf: Support sampling events using overflow interrupts
  ARCv2: perf: set usable max period as a half of real max period
  ARCv2: perf: implement exclusion of event counting in user or kernel
    mode
  ARCv2: perf: SMP support

Vineet Gupta (2):
  ARC: perf: cap the number of counters to hardware max of 32
  ARCv2: perf: Finally introduce HS perf unit

 .../devicetree/bindings/arc/archs-pct.txt          |  17 ++
 arch/arc/include/asm/perf_event.h                  |  24 +-
 arch/arc/kernel/perf_event.c                       | 310 +++++++++++++++++++--
 3 files changed, 326 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt

-- 
1.9.1
