From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v3 0/6] ARCv2 port to Linux - (C) perf
Date: Wed, 26 Aug 2015 12:07:04 +0000
Message-ID: <1440590824.15478.38.camel@synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:37851 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbHZMHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2015 08:07:09 -0400
In-Reply-To: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
Content-Language: en-US
Content-ID: <4695F7299D0C3848B6A9CA24786C866B@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi Peter,

On Mon, 2015-08-24 at 17:20 +-0300, Alexey Brodkin wrote:
+AD4- Hi Peter,
+AD4- 
+AD4- This mini-series adds perf support for ARCv2 based cores, which brings in
+AD4- overflow interupts and SMP. Additionally now raw events are supported as well.
+AD4- 
+AD4- Please review +ACE-
+AD4- 
+AD4- Compared to v2 this series has:
+AD4-  +AFs-1+AF0- Removed patch with raw-events support.
+AD4-      It needs some rework and let's then discuss it separately.
+AD4-      Still I plan to send it shortly.
+AD4-  +AFs-2+AF0- Merged +ACI-set usable max period as a half of real max period+ACI- into
+AD4-      +ACI-implement +ACI-event+AF8-set+AF8-period+ACI-.
+AD4-  +AFs-3+AF0- Fixed arc+AF8-pmu+AF8-event+AF8-set+AF8-period() in regard of incorrect
+AD4-      +ACI-hwc-+AD4-period+AF8-left+ACI- setup.
+AD4-  +AFs-4+AF0- Moved interrupts enabling from arc+AF8-pmu+AF8-add() to arc+AF8-pmu+AF8-start()
+AD4- 
+AD4- Compared to v1 this series has:
+AD4-  +AFs-1+AF0- Addressed review comments
+AD4-  +AFs-2+AF0- More verbose commit messages and comments in sources
+AD4-  +AFs-3+AF0- Minor cosmetics
+AD4- 
+AD4- Thanks,
+AD4- Alexey
+AD4- 
+AD4- Alexey Brodkin (4):
+AD4-   ARCv2: perf: implement +ACI-event+AF8-set+AF8-period+ACI-
+AD4-   ARCv2: perf: Support sampling events using overflow interrupts
+AD4-   ARCv2: perf: implement exclusion of event counting in user or kernel
+AD4-     mode
+AD4-   ARCv2: perf: SMP support
+AD4- 
+AD4- Vineet Gupta (2):
+AD4-   ARC: perf: cap the number of counters to hardware max of 32
+AD4-   ARCv2: perf: Finally introduce HS perf unit
+AD4- 
+AD4-  .../devicetree/bindings/arc/archs-pct.txt          +AHw-  17 +-+-
+AD4-  MAINTAINERS                                        +AHw-   2 +--
+AD4-  arch/arc/include/asm/perf+AF8-event.h                  +AHw-  21 +--
+AD4-  arch/arc/kernel/perf+AF8-event.c                       +AHw- 271 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----
+AD4-  4 files changed, 275 insertions(+-), 36 deletions(-)
+AD4-  create mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt

Any chance for this re-spin to be reviewed sometime soon?

-Alexey