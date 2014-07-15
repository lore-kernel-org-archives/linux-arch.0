From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFA][PATCH 16/27] ftrace: x86: Remove check of obsolete variable
 function_trace_stop
Date: Tue, 15 Jul 2014 08:48:02 -0700
Message-ID: <53C54D32.6000000@zytor.com>
References: <20140626165221.736847419@goodmis.org> <20140626165851.883708348@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56060 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbaGOPsX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 11:48:23 -0400
In-Reply-To: <20140626165851.883708348@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, "H. Peter Anvin" <hpa@linux.intel.com>

On 06/26/2014 09:52 AM, Steven Rostedt wrote:
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> Nothing sets function_trace_stop to disable function tracing anymore.
> Remove the check for it in the arch code.
> 
> Cc: H. Peter Anvin <hpa@linux.intel.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
