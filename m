From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v3 0/6] ARCv2 port to Linux - (C) perf
Date: Mon, 24 Aug 2015 17:20:17 +0300
Message-ID: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:46192 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbbHXOUl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2015 10:20:41 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, peterz@infradead.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

Hi Peter,

This mini-series adds perf support for ARCv2 based cores, which brings in
overflow interupts and SMP. Additionally now raw events are supported as well.

Please review !

Compared to v2 this series has:
 [1] Removed patch with raw-events support.
     It needs some rework and let's then discuss it separately.
     Still I plan to send it shortly.
 [2] Merged "set usable max period as a half of real max period" into
     "implement "event_set_period".
 [3] Fixed arc_pmu_event_set_period() in regard of incorrect
     "hwc->period_left" setup.
 [4] Moved interrupts enabling from arc_pmu_add() to arc_pmu_start()

Compared to v1 this series has:
 [1] Addressed review comments
 [2] More verbose commit messages and comments in sources
 [3] Minor cosmetics

Thanks,
Alexey

Alexey Brodkin (4):
  ARCv2: perf: implement "event_set_period"
  ARCv2: perf: Support sampling events using overflow interrupts
  ARCv2: perf: implement exclusion of event counting in user or kernel
    mode
  ARCv2: perf: SMP support

Vineet Gupta (2):
  ARC: perf: cap the number of counters to hardware max of 32
  ARCv2: perf: Finally introduce HS perf unit

 .../devicetree/bindings/arc/archs-pct.txt          |  17 ++
 MAINTAINERS                                        |   2 +-
 arch/arc/include/asm/perf_event.h                  |  21 +-
 arch/arc/kernel/perf_event.c                       | 271 ++++++++++++++++++---
 4 files changed, 275 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt

-- 
2.4.3
