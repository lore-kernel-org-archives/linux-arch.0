From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFA][PATCH 17/27] tile: ftrace: Remove check of obsolete
 variable function_trace_stop
Date: Thu, 3 Jul 2014 10:02:09 -0400
Message-ID: <20140703100209.394163c5@gandalf.local.home>
References: <20140626165221.736847419@goodmis.org>
	<20140626165852.012558348@goodmis.org>
	<53B56061.3050601@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B56061.3050601@tilera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, Tony Lu <zlu@tilera.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 3 Jul 2014 09:53:37 -0400
Chris Metcalf <cmetcalf@tilera.com> wrote:

> On 6/26/2014 12:52 PM, Steven Rostedt wrote:
> > From: "Steven Rostedt (Red Hat)"<rostedt@goodmis.org>
> >
> > Nothing sets function_trace_stop to disable function tracing anymore.
> > Remove the check for it in the arch code.
> >
> > [ Please test this on your arch ]
> >
> > Cc: Chris Metcalf<cmetcalf@tilera.com>
> > Signed-off-by: Steven Rostedt<rostedt@goodmis.org>
> 
> I forwarded this internally to the guy who did the work at Tilera and he's happy with the change.
> 
> Acked-by: Zhigang Lu<zlu@tilera.com>
> 

Thanks!

-- Steve
