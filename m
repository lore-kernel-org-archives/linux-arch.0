Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbeLJTdg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Dec 2018 14:33:36 -0500
Message-ID: <20181210193334.710041488@goodmis.org>
Date: Mon, 10 Dec 2018 14:30:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/6] fgraph: Add comment to describe ftrace_graph_get_ret_stack
References: <20181210193007.655970639@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20181210193008.b4L_3CLWD30qlH31JTLZlnHlhjfLf5Lw9_UYoCOkNqw@z>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ret_stack should not be accessed directly via the curr_ret_stack
variable on the task_struct. This is because the ret_stack is going to be
converted into a series of longs and not an array of ret_stack structures.
The way that a ret_stack should be retrieved is via the
ftrace_graph_get_ret_stack structure, but it needs to be documented on how
to use it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a3704ec8b599..d4f04f0ca646 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -232,6 +232,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	return ret;
 }
 
+/**
+ * ftrace_graph_get_ret_stack - return the entry of the shadow stack
+ * @task: The task to read the shadow stack from
+ * @idx: Index down the shadow stack
+ *
+ * Return the ret_struct on the shadow stack of the @task at the
+ * call graph at @idx starting with zero. If @idx is zero, it
+ * will return the last saved ret_stack entry. If it is greater than
+ * zero, it will return the corresponding ret_stack for the depth
+ * of saved return addresses.
+ */
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-- 
2.19.1
