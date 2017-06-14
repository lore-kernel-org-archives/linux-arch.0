From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 00/13] trace: add the ability to parse sizeof()
Date: Wed, 14 Jun 2017 17:27:16 -0500
Message-ID: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdFNW1b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 18:27:31 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz

There are a few cases of sizeof() embedded in TRACE_EVENT()
macros. That is a problem because "sizeof(structure)" is
passed to userspace, which doesn't know how to decode the
size of kernel data structures. There was a similar problem
with enums.

Rather than recreating much of the enum infrastructure lets
simply extend it, and append additional symbols into the
enum_map that can translate string sizeof() calls into
values. Of course that means that much of the infrastructure
is now poorly named so we go through and replace instances
describing "enum" with "eval" to indicate a generic C
expression to numerical evaluation routine.

v1->v2:
  Modify the sample trace file to reflect a more reasonable example
  Add an additional TRACE_DEFINE_SIZEOF() for fjes_hw_request_info
  Add an additional patch to convert some hardcoded size values to sizeof

Jeremy Linton (13):
  trace: rename kernel enum section to eval
  trace: rename trace_enum_map to trace_eval_map
  trace: rename struct module entry for trace enums
  trace: rename trace enum data structures in trace.c
  trace: rename trace_enum_mutex to trace_eval_mutex
  trace: rename trace.c enum functions
  trace: rename enum_map functions
  tracing: Rename enum_replace to eval_replace
  tracing: define TRACE_DEFINE_SIZEOF() macro to map sizeof's to their
    values
  tracing: Update sample file to describe the new macro
  tracing: Add TRACE_DEFINE_SIZEOF() macros
  tracing: Replace some majic constants with sizeof()
  tracing: Rename and update the enum_map file

 arch/arm64/kvm/trace.h                         |   2 +
 drivers/net/fjes/fjes_trace.h                  |   2 +
 include/asm-generic/vmlinux.lds.h              |   6 +-
 include/linux/module.h                         |   4 +-
 include/linux/tracepoint.h                     |   7 +-
 include/trace/events/thermal.h                 |   4 +-
 include/trace/events/thermal_power_allocator.h |   4 +-
 include/trace/events/xen.h                     |  13 +-
 include/trace/trace_events.h                   |  26 +++-
 kernel/module.c                                |   6 +-
 kernel/trace/Kconfig                           |  22 +--
 kernel/trace/trace.c                           | 194 ++++++++++++-------------
 kernel/trace/trace.h                           |   4 +-
 kernel/trace/trace_events.c                    |  24 +--
 samples/trace_events/trace-events-sample.h     |  28 ++--
 sound/firewire/motu/amdtp-motu-trace.h         |  12 +-
 16 files changed, 202 insertions(+), 156 deletions(-)

-- 
2.9.4
