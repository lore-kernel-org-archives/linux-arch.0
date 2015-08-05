From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2 0/8] ARCv2 port to Linux - (C) perf
Date: Wed,  5 Aug 2015 18:13:26 +0300
Message-ID: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39845 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751487AbbHEPNu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2015 11:13:50 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, peterz@infradead.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

Hi Peter,

This mini-series adds perf support for ARCv2 based cores, which brings in
overflow interupts and SMP. Additionally now raw events are supported as well.

Please review !

Compared to v1 this series has:
 [1] Addressed review comments
 [2] More verbose commit messages and comments in sources
 [3] Minor cosmetics

Thanks,
Alexey


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

 .../devicetree/bindings/arc/archs-pct.txt          |  17 +
 MAINTAINERS                                        |   2 +-
 arch/arc/include/asm/perf_event.h                  |  24 +-
 arch/arc/kernel/perf_event.c                       | 350 ++++++++++++++++++---
 4 files changed, 345 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt

-- 
2.4.3
