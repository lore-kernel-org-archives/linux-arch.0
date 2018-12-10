From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/6] tracing / arch: Remove direct use of curr_ret_stack
Date: Mon, 10 Dec 2018 14:30:07 -0500
Message-ID: <20181210193007.655970639@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org


Folks, I'm working on rewriting the function graph tracer. In order to
do so, some changes need to be done that affect architecture specific
code. I'm only able to compile test these changes. I would like to
have folks check out my repo and give them a test.

The shadow stack of ret_stack is going to be modified to allow multiple
users of function graph tracer. It can no longer be referenced directly
as an array. A new utility "ftrace_graph_ret_stack()" is available to
get the ret_stack entry of a given frame of the shadow stack that
architectures can now use. This series converts all users to use the
new interface.


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

Head SHA1: 51584396cff54aaf57ed0bd353767d71429f77b4


Steven Rostedt (VMware) (6):
      fgraph: Add comment to describe ftrace_graph_get_ret_stack
      x86/ftrace: Do not call function graph from dynamic trampolines
      powerpc/frace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sparc64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      sh: ftrace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
      arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack

----
 arch/arm64/kernel/perf_callchain.c |  2 +-
 arch/arm64/kernel/process.c        |  2 +-
 arch/arm64/kernel/return_address.c |  2 +-
 arch/arm64/kernel/stacktrace.c     | 12 +++++++-----
 arch/arm64/kernel/time.c           |  2 +-
 arch/arm64/kernel/traps.c          |  2 +-
 arch/powerpc/kernel/process.c      | 13 +++++++++----
 arch/sh/kernel/dumpstack.c         | 11 +++++++----
 arch/sh/kernel/dwarf.c             |  9 +++++----
 arch/sparc/kernel/perf_event.c     |  8 +++++---
 arch/sparc/kernel/stacktrace.c     |  8 +++++---
 arch/sparc/kernel/traps_64.c       |  7 ++++---
 arch/x86/kernel/ftrace.c           | 40 +++++++++++++++++++++-----------------
 arch/x86/kernel/ftrace_64.S        |  8 ++++----
 kernel/trace/fgraph.c              | 11 +++++++++++
 15 files changed, 84 insertions(+), 53 deletions(-)
