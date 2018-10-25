From: Nick Hu <nickhu@andestech.com>
Subject: [PATCH v4 0/4] nds32: Perf support
Date: Thu, 25 Oct 2018 10:24:13 +0800
Message-ID: <cover.1540430861.git.nickhu@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ebiederm@xmission.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, zong@andestech.com, alankao@andestech.com, deanbo422@gmail.com
Cc: green.hu@gmail.com, Nick Hu <nickhu@andestech.com>
List-Id: linux-arch.vger.kernel.org

These four commits are perf supporting for nds32.
There are three perfomance counters in nds32, and
each of them can counts different events. You can
use 'perf list' to show the available events that
can be used.

Changes in V2:
        1. Change the definition 'PFM_CTL_xxx' to
array form.

        2. Simplify the PMU driver.

        3. Stop all counters when handling irq
caused by performance counters overflow.

        4. Rename the compatible string in
devicetree.

Changes in V3:
        Fix the typo in Documentation/devicetree/
bindings/nds32/pmu.txt.

Changes in V4:
	Move 'Documentation/devicetree/bindings/nds32/pmu.txt'
to 'Documentation/devicetree/bindings/perf/nds32v3-pmu.txt'.

Nickhu (4):
  nds32: Fix bug in bitfield.h
  nds32: Perf porting
  nds32: Add perf call-graph support.
  nds32: Add document for NDS32 PMU.

 .../devicetree/bindings/perf/nds32v3-pmu.txt  |   17 +
 arch/nds32/Kconfig                            |    1 +
 arch/nds32/boot/dts/ae3xx.dts                 |    5 +
 arch/nds32/include/asm/Kbuild                 |    1 +
 arch/nds32/include/asm/bitfield.h             |    4 +-
 arch/nds32/include/asm/perf_event.h           |   16 +
 arch/nds32/include/asm/pmu.h                  |  386 +++++
 arch/nds32/include/asm/stacktrace.h           |   39 +
 arch/nds32/kernel/Makefile                    |    3 +-
 arch/nds32/kernel/perf_event_cpu.c            | 1522 +++++++++++++++++
 arch/nds32/mm/fault.c                         |   13 +-
 tools/include/asm/barrier.h                   |    2 +
 tools/perf/arch/nds32/Build                   |    1 +
 tools/perf/arch/nds32/util/Build              |    1 +
 tools/perf/arch/nds32/util/header.c           |   29 +
 tools/perf/pmu-events/arch/nds32/mapfile.csv  |   15 +
 .../pmu-events/arch/nds32/n13/atcpmu.json     |  290 ++++
 17 files changed, 2337 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
 create mode 100644 arch/nds32/include/asm/perf_event.h
 create mode 100644 arch/nds32/include/asm/pmu.h
 create mode 100644 arch/nds32/include/asm/stacktrace.h
 create mode 100644 arch/nds32/kernel/perf_event_cpu.c
 create mode 100644 tools/perf/arch/nds32/Build
 create mode 100644 tools/perf/arch/nds32/util/Build
 create mode 100644 tools/perf/arch/nds32/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/nds32/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json

-- 
2.17.0
