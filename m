Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:47073 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYScj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2018 14:32:39 -0400
MIME-Version: 1.0
References: <cover.1540430861.git.nickhu@andestech.com>
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 25 Oct 2018 17:59:59 +0800
Message-ID: <CAEbi=3epEazp30TE=dgVtAU8kye49a3z7uZig88q0zngxAmitg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] nds32: Perf support
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nickhu <nickhu@andestech.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-arm-kernel@lists.infradead.org, DTML <devicetree@vger.kernel.org>, Zong Li <zong@andestech.com>, alankao@andestech.com, Vincent Chen <deanbo422@gmail.com>
Message-ID: <20181025095959.s4x8AgVTvLnzHnp4-A5Uh3oHG7u9hnrJY6y2UXnIgYI@z>

Nick Hu <nickhu@andestech.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> These four commits are perf supporting for nds32.
> There are three perfomance counters in nds32, and
> each of them can counts different events. You can
> use 'perf list' to show the available events that
> can be used.
>
> Changes in V2:
>         1. Change the definition 'PFM_CTL_xxx' to
> array form.
>
>         2. Simplify the PMU driver.
>
>         3. Stop all counters when handling irq
> caused by performance counters overflow.
>
>         4. Rename the compatible string in
> devicetree.
>
> Changes in V3:
>         Fix the typo in Documentation/devicetree/
> bindings/nds32/pmu.txt.
>
> Changes in V4:
>         Move 'Documentation/devicetree/bindings/nds32/pmu.txt'
> to 'Documentation/devicetree/bindings/perf/nds32v3-pmu.txt'.
>
> Nickhu (4):
>   nds32: Fix bug in bitfield.h
>   nds32: Perf porting
>   nds32: Add perf call-graph support.
>   nds32: Add document for NDS32 PMU.
>
>  .../devicetree/bindings/perf/nds32v3-pmu.txt  |   17 +
>  arch/nds32/Kconfig                            |    1 +
>  arch/nds32/boot/dts/ae3xx.dts                 |    5 +
>  arch/nds32/include/asm/Kbuild                 |    1 +
>  arch/nds32/include/asm/bitfield.h             |    4 +-
>  arch/nds32/include/asm/perf_event.h           |   16 +
>  arch/nds32/include/asm/pmu.h                  |  386 +++++
>  arch/nds32/include/asm/stacktrace.h           |   39 +
>  arch/nds32/kernel/Makefile                    |    3 +-
>  arch/nds32/kernel/perf_event_cpu.c            | 1522 +++++++++++++++++
>  arch/nds32/mm/fault.c                         |   13 +-
>  tools/include/asm/barrier.h                   |    2 +
>  tools/perf/arch/nds32/Build                   |    1 +
>  tools/perf/arch/nds32/util/Build              |    1 +
>  tools/perf/arch/nds32/util/header.c           |   29 +
>  tools/perf/pmu-events/arch/nds32/mapfile.csv  |   15 +
>  .../pmu-events/arch/nds32/n13/atcpmu.json     |  290 ++++
>  17 files changed, 2337 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.tx=
t
>  create mode 100644 arch/nds32/include/asm/perf_event.h
>  create mode 100644 arch/nds32/include/asm/pmu.h
>  create mode 100644 arch/nds32/include/asm/stacktrace.h
>  create mode 100644 arch/nds32/kernel/perf_event_cpu.c
>  create mode 100644 tools/perf/arch/nds32/Build
>  create mode 100644 tools/perf/arch/nds32/util/Build
>  create mode 100644 tools/perf/arch/nds32/util/header.c
>  create mode 100644 tools/perf/pmu-events/arch/nds32/mapfile.csv
>  create mode 100644 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
>
Hi Nick,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
