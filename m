From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [RFA][PATCH 17/27] tile: ftrace: Remove check of obsolete variable
 function_trace_stop
Date: Thu, 3 Jul 2014 09:53:37 -0400
Message-ID: <53B56061.3050601@tilera.com>
References: <20140626165221.736847419@goodmis.org> <20140626165852.012558348@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:26974 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbaGCNxj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2014 09:53:39 -0400
In-Reply-To: <20140626165852.012558348@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, Tony Lu <zlu@tilera.com>

On 6/26/2014 12:52 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (Red Hat)"<rostedt@goodmis.org>
>
> Nothing sets function_trace_stop to disable function tracing anymore.
> Remove the check for it in the arch code.
>
> [ Please test this on your arch ]
>
> Cc: Chris Metcalf<cmetcalf@tilera.com>
> Signed-off-by: Steven Rostedt<rostedt@goodmis.org>

I forwarded this internally to the guy who did the work at Tilera and he's happy with the change.

Acked-by: Zhigang Lu<zlu@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
