From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 00/12] trace: add the ability to parse sizeof()
Date: Wed, 31 May 2017 16:56:41 -0500
Message-ID: <20170531215653.3240-1-jeremy.linton@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbdEaV4z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 May 2017 17:56:55 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org

There are a few cases of sizeof() embedded in TRACE_EVENT()
macros. That is a problem because the sizeof(structure) gets
passed to userspace which doesn't know how to decode the
size of kernel data structures. This is a similar problem
to enums which were being passed in their symbolic form to
userspace.

Rather than recreating much of that infrastructure lets
simply extend it, and append additional symbols into the
enum_map that can translate string sizeof() calls into
values. Of course that means that much of the infrastructure
is now poorly named so we go through and replace instances
describing "enum" with "eval" to indicate a generic C
expression to numerical evaluation routine.

Jeremy Linton (12):
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
  tracing: Rename update the enum_map file

 arch/arm64/kvm/trace.h                     |   2 +
 include/asm-generic/vmlinux.lds.h          |   6 +-
 include/linux/module.h                     |   4 +-
 include/linux/tracepoint.h                 |   7 +-
 include/trace/events/xen.h                 |  13 +-
 include/trace/trace_events.h               |  26 +++-
 kernel/module.c                            |   6 +-
 kernel/trace/Kconfig                       |  22 ++--
 kernel/trace/trace.c                       | 194 ++++++++++++++---------------
 kernel/trace/trace.h                       |   4 +-
 kernel/trace/trace_events.c                |  24 ++--
 samples/trace_events/trace-events-sample.h |   7 ++
 12 files changed, 175 insertions(+), 140 deletions(-)

-- 
2.9.4
