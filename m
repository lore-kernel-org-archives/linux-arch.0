From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 0/8] ARCv2 port to Linux - (C) perf
Date: Mon, 10 Aug 2015 08:29:30 +0000
Message-ID: <1439195370.4848.1.camel@synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Content-Language: en-US
Content-ID: <44858027808A9A4E907D77831F5FAA08@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

Hi Peter,

On Wed, 2015-08-05 at 18:13 +-0300, Alexey Brodkin wrote:
+AD4- Hi Peter,
+AD4- 
+AD4- This mini-series adds perf support for ARCv2 based cores, which brings in
+AD4- overflow interupts and SMP. Additionally now raw events are supported as well.
+AD4- 
+AD4- Please review +ACE-
+AD4- 
+AD4- Compared to v1 this series has:
+AD4-  +AFs-1+AF0- Addressed review comments
+AD4-  +AFs-2+AF0- More verbose commit messages and comments in sources
+AD4-  +AFs-3+AF0- Minor cosmetics
+AD4- 
+AD4- Thanks,
+AD4- Alexey
+AD4- 
+AD4- 
+AD4- Alexey Brodkin (6):
+AD4-   ARC: perf: support RAW events
+AD4-   ARCv2: perf: implement +ACI-event+AF8-set+AF8-period+ACI- for future use with
+AD4-     interrupts
+AD4-   ARCv2: perf: Support sampling events using overflow interrupts
+AD4-   ARCv2: perf: set usable max period as a half of real max period
+AD4-   ARCv2: perf: implement exclusion of event counting in user or kernel
+AD4-     mode
+AD4-   ARCv2: perf: SMP support
+AD4- 
+AD4- Vineet Gupta (2):
+AD4-   ARC: perf: cap the number of counters to hardware max of 32
+AD4-   ARCv2: perf: Finally introduce HS perf unit
+AD4- 
+AD4-  .../devicetree/bindings/arc/archs-pct.txt          +AHw-  17 +-
+AD4-  MAINTAINERS                                        +AHw-   2 +--
+AD4-  arch/arc/include/asm/perf+AF8-event.h                  +AHw-  24 +--
+AD4-  arch/arc/kernel/perf+AF8-event.c                       +AHw- 350 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----
+AD4-  4 files changed, 345 insertions(+-), 48 deletions(-)
+AD4-  create mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt
+AD4- 

Any chance for this series respin to be reviewed sometime soon?

-Alexey