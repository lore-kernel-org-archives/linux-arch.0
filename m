Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452325;
	b=r3ceZVhp2Nm5EXFOOwo8BXhwkrJ0ygoY0GJdunjaVehmHwuyW/T9NclTBDxKj2XBLXDw
	 X/DYw6/Xo5WQW6vEmYdjIXK1N4BzpGYX5XgCAXFSJxqAIdn8UJjFeBoG1ZB33gxl907ws
	 aujs47QBn9Lr9MMsnzLTHFoFWedcimfLsUbCILg0AKFEzgzImxy8HoQ4+DHvjeI124INr
	 9JegGAWHEmY5RKWsEXEf7K0A5aiDOpPstY3AJrL3G4Dkx9PyalHsdOpL7jwBkw99vN4sG
	 wJ5umEOHN0sF6qT3xJ8nFEnVy4tkjtyPnwCx11duF32ww/6c4vMliVHsN8B98ClkTTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452325;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=DlCGj8ptWIF4ii6TVWOvEmDJh3IVQQ32MuqZpES5RIo=;
	b=RCOIyI4SBFZiZeHbiHRwwNuA6Adkwvtxxu0PunphwjSf0iIKFsTOxvDNv2jBIgNwOMAd
	 Vh2qOZWslIoEh+WrzUxDj/B5T2HK6YrSm6NP+Ksk0HTgyoOAex5BLypRcv/XQCOTJFW2d
	 oW3frcSSlY0k8wErVBZdC+6NrEHUBsq2dxF92bRi2hMzeSuR0hwiBG6VvKp7EzBjY+P1l
	 RAItSWop69z6qvliQnhSpqDLTCwCyyEBLW5pPltRKuvBcCQqKaOLnV+gZqIv92vdbJcl9
	 49ctFwBPv2JHpdKtLQASCbLtSy82c0cmc7XRVUifVe70eDUy2mBwVa9FXZceBSmlJ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=JQRvnU8P;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4F606A31D;
	Sat, 31 Oct 2026 13:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEE4F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=JQRvnU8P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452324; x=1824988324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DlCGj8ptWIF4ii6TVWOvEmDJh3IVQQ32MuqZpES5RIo=;
  b=JQRvnU8Po7KcDc0IRWIh5J17qfJgOTn+B7w4A2cXgo2sD43w6ttazUHD
   aGrH8cHiTuotCs5LsecUxkQSaNrIYwODLVHvmlasfkdndcKGXaEqy7HaY
   aGxFcPje7KJyscjQYzLD3t8BdkaewqGfMROFrNODuXcufUFP4A9WKN5Gb
   FntEDo2SnJiPq6wlfdE70MoUlOJyullXr7GqUsdXnYuM6XSmITdX4HC+j
   gPnKim7ZoYS0eojblDan/1nWVX/oygcP6Qle+WFMiD9qplDj9WPnLMph8
   1fEnWtC6fXB88pJJHEnIPaeNf3Wv6yALu1+vIZTs36qmTTaDBIEKaZOtp
   g==;
X-CSE-ConnectionGUID: J/9NpWntTz+yiMiIgYRNwA==
X-CSE-MsgGUID: lJIhu+NpQBuYdVDslH9E5Q==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32650483"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:12:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:4226]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id 6818253c-f6a4-43f4-8e96-050e0060470c; Sat, 31 Oct 2026 13:12:04 +0000 (UTC)
X-Farcaster-Flow-ID: 6818253c-f6a4-43f4-8e96-050e0060470c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:04 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:03 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire
	<almagui@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, "Martin
 Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 08/13] tracing: parse the vmlinux BTF when BTF-typed output is enabled
Date: Sat, 31 Oct 2026 13:09:54 +0000
Message-ID: <20261031130959.23472-9-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031130959.23472-1-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ihor Solodrai <ihor.solodrai@linux.dev>

func-args of the function tracer, and funcgraph-args and
funcgraph-retval of the function_graph tracer, print arguments and
return values by their BTF types: print_function_args() and
btf_trim_retval() look the function up with btf_find_func_proto(),
which parses the vmlinux BTF if nobody has yet.  Since commit
42643ba35deb ("tracing: Avoid BTF lookup in atomic context") they do not
do that in atomic context, but they still can in the readers of the
trace: s_show() and tracing_read_pipe() print under trace_event_sem and
the trace access lock, while the tracer keeps recording, by default
into the buffer being read.

Today the BTF is always parsed at boot, so this cannot happen.  To keep
it that way once the vmlinux BTF can be parsed on first use
(CONFIG_DEBUG_INFO_BTF_LAZY, later in this series), parse it when such
output is enabled instead: trace_btf_prepare() is called from
select_trace_function() when func-args is set, from graph_trace_init()
when funcgraph-args or funcgraph-retval is set, and from
func_graph_set_flag() when either is turned on, all with
trace_types_lock held.  The two printers only peek at the BTF and fall
back to the output without it if it is not parsed, which then cannot
happen while the option is in effect.

"trace_options=" on the command line sets the options from
early_trace_init() in start_kernel(), with interrupts disabled and
before btf_alloc_id() can allocate; while the system is still booting
(system_state < SYSTEM_SCHEDULING) trace_btf_prepare() only records the
request, and a core_initcall parses the BTF.

Reading an event's btf_ids file looks the BTF up under event_mutex;
parse it before taking the mutex, as the CO-RE candidate lookup does
before cand_cache_mutex.

No functional change with today's eager parse, except that with such
an option on the command line the BTF is parsed at core_initcall time,
before the initcalls that would otherwise parse it.

TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
[moved trace_func_args_prepare() to trace_btf.c as trace_btf_prepare();
 extended it to funcgraph-retval and the btf_ids file; the printers check
 the BTF with bpf_peek_btf_vmlinux() in front of btf_find_func_proto()]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/trace/trace_btf.c             | 32 ++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h             |  3 +++
 kernel/trace/trace_events.c          |  4 ++++
 kernel/trace/trace_functions.c       |  4 ++++
 kernel/trace/trace_functions_graph.c | 15 +++++++++++--
 kernel/trace/trace_output.c          |  3 +++
 6 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index f0e0c04d58d9..693c1a1083c5 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -141,6 +142,34 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 	return member;
 }
 
+static bool trace_btf_deferred;
+
+/*
+ * func-args, funcgraph-args and funcgraph-retval print arguments and return
+ * values by their BTF types, and the readers of the trace use the vmlinux
+ * BTF only if it is parsed already: parse it when such output is enabled.
+ * With CONFIG_DEBUG_INFO_BTF_LAZY that may be its first use, which should
+ * not happen in a reader that holds the trace read locks while the tracer
+ * records its work.
+ */
+void trace_btf_prepare(void)
+{
+	/* trace_options= on the command line is applied by early_trace_init() */
+	if (system_state < SYSTEM_SCHEDULING) {
+		trace_btf_deferred = true;
+		return;
+	}
+	bpf_get_btf_vmlinux();
+}
+
+static int __init trace_btf_init(void)
+{
+	if (trace_btf_deferred)
+		bpf_get_btf_vmlinux();
+	return 0;
+}
+core_initcall(trace_btf_init);
+
 void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
 			int *fmt, bool hex)
 {
@@ -151,6 +180,9 @@ void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retv
 	bool signed_type;
 	int kind;
 
+	/* see trace_btf_prepare() */
+	if (IS_ERR_OR_NULL(bpf_peek_btf_vmlinux()))
+		return;
 	if (lookup_symbol_name(func, name))
 		return;
 
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index b3d408e6a7f6..47407eff1339 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -23,9 +23,12 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 #ifdef CONFIG_DEBUG_INFO_BTF
 void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
 		     int *fmt, bool hex);
+void trace_btf_prepare(void);
 #else
 static inline void btf_trim_retval(unsigned long func, unsigned long *retval,
 				   bool *print_retval, int *fmt, bool hex)
 {
 }
+
+static inline void trace_btf_prepare(void) { }
 #endif
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 49d135bc2fbf..adc422fbe16e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/bpf.h>
 #include <linux/btf.h>
 
 #include <kunit/visibility.h>
@@ -2282,6 +2283,9 @@ event_btf_ids_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppo
 	char buf[128];
 	int len;
 
+	/* parse the vmlinux BTF, if this is its first use, without event_mutex */
+	bpf_get_btf_vmlinux();
+
 	/* Module unload could free call->class and ids[] mid-read. */
 	scoped_guard(mutex, &event_mutex) {
 		file = event_file_file(filp);
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index acaba990aaaa..2cebaacda526 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 
 #include "trace.h"
+#include "trace_btf.h"
 
 static void tracing_start_function_trace(struct trace_array *tr);
 static void tracing_stop_function_trace(struct trace_array *tr);
@@ -115,6 +116,9 @@ void ftrace_destroy_function_files(struct trace_array *tr)
 
 static ftrace_func_t select_trace_function(u32 flags_val)
 {
+	if (flags_val & TRACE_FUNC_OPT_ARGS)
+		trace_btf_prepare();
+
 	switch (flags_val & TRACE_FUNC_OPT_MASK) {
 	case TRACE_FUNC_NO_OPTS:
 		return function_trace_call;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 78a608315dd3..cf5f433dd26e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -474,6 +474,10 @@ static int graph_trace_init(struct trace_array *tr)
 {
 	int ret;
 
+	if (tracer_flags_is_set(tr, TRACE_GRAPH_ARGS) ||
+	    tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_RETVAL))
+		trace_btf_prepare();
+
 	if (tracer_flags_is_set(tr, TRACE_GRAPH_ARGS))
 		tr->gops->entryfunc = trace_graph_entry_args;
 	else
@@ -507,10 +511,12 @@ static int ftrace_graph_trace_args(struct trace_array *tr, int set)
 {
 	trace_func_graph_ent_t entry;
 
-	if (set)
+	if (set) {
+		trace_btf_prepare();
 		entry = trace_graph_entry_args;
-	else
+	} else {
 		entry = trace_graph_entry;
+	}
 
 	/* See if there's any changes */
 	if (tr->gops->entryfunc == entry)
@@ -1746,6 +1752,11 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 
 	case TRACE_GRAPH_ARGS:
 		return ftrace_graph_trace_args(tr, set);
+
+	case TRACE_GRAPH_PRINT_RETVAL:
+		if (set)
+			trace_btf_prepare();
+		break;
 	}
 
 	return 0;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5ad76175d10..cdb926c9d4e2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -739,6 +739,9 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 	if (lookup_symbol_name(func, name))
 		goto out;
 
+	/* see trace_btf_prepare() */
+	if (IS_ERR_OR_NULL(bpf_peek_btf_vmlinux()))
+		goto out;
 	/* TODO: Pass module name here too */
 	t = btf_find_func_proto(name, &btf);
 	if (IS_ERR_OR_NULL(t))
-- 
2.47.3

