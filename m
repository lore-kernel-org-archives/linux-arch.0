From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFA][PATCH 05/27] ftrace/x86: Add call to ftrace_graph_is_dead()
 in function graph code
Date: Tue, 15 Jul 2014 08:47:36 -0700
Message-ID: <53C54D18.3020602@zytor.com>
References: <20140626165221.736847419@goodmis.org> <20140626165848.832117370@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56046 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbaGOPsF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 11:48:05 -0400
In-Reply-To: <20140626165848.832117370@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>

On 06/26/2014 09:52 AM, Steven Rostedt wrote:
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> ftrace_stop() is going away as it disables parts of function tracing
> that affects users that should not be affected. But ftrace_graph_stop()
> is built on ftrace_stop(). Here's another example of killing all of
> function tracing because something went wrong with function graph
> tracing.
> 
> Instead of disabling all users of function tracing on function graph
> error, disable only function graph tracing. To do this, the arch code
> must call ftrace_graph_is_dead() before it implements function graph.
> 
> Cc: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
