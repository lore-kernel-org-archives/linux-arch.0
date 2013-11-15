Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailxx.hitachi.co.jp ([133.145.228.50]:46353 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab3KOE5r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2013 23:57:47 -0500
Subject: [PATCH -tip RFC v2 10/22] ftrace/kprobes: Allow probing on some
 preparation functions
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date: Fri, 15 Nov 2013 04:53:43 +0000
Message-ID: <20131115045343.27580.58030.stgit@kbuild-fedora.novalocal>
In-Reply-To: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
References: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131115045343.7zAOYWhMqtfgQkLn6Ho3uqtp7sb1z1sUhm0hJer-GRM@z>

There is no need to prohibit probing on the functions
used for preparation. Those are safely probed because
those are not invoked from breakpoint/fault/debug handlers,
there is no chance to cause recursive exceptions.

Following functions are now removed from the kprobes blacklist.
update_bitfield_fetch_param
free_bitfield_fetch_param
kprobe_register

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/trace/trace_kprobe.c |    2 +-
 kernel/trace/trace_probe.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 243f683..e0132b4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1151,7 +1151,7 @@ kretprobe_perf_func(struct trace_probe *tp, struct kretprobe_instance *ri,
  * kprobe_trace_self_tests_init() does enable_trace_probe/disable_trace_probe
  * lockless, but we can't race with this __init function.
  */
-static __kprobes
+static
 int kprobe_register(struct ftrace_event_call *event,
 		    enum trace_reg type, void *data)
 {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 412e959..43638a2 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -346,7 +346,7 @@ DEFINE_BASIC_FETCH_FUNCS(bitfield)
 #define fetch_bitfield_string		NULL
 #define fetch_bitfield_string_size	NULL
 
-static __kprobes void
+static void
 update_bitfield_fetch_param(struct bitfield_fetch_param *data)
 {
 	/*
@@ -359,7 +359,7 @@ update_bitfield_fetch_param(struct bitfield_fetch_param *data)
 		update_symbol_cache(data->orig.data);
 }
 
-static __kprobes void
+static void
 free_bitfield_fetch_param(struct bitfield_fetch_param *data)
 {
 	/*

