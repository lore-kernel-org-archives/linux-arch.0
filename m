From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFA][PATCH 24/27] Blackfin: ftrace: Remove check of obsolete
 variable function_trace_stop
Date: Thu, 26 Jun 2014 15:34:32 -0400
Message-ID: <20140626153432.69dbb7ca@gandalf.local.home>
References: <20140626165221.736847419@goodmis.org>
	<20140626165853.211937817@goodmis.org>
	<3144266.ziutPk5CNZ@vapier>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3144266.ziutPk5CNZ@vapier>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 26 Jun 2014 15:25:31 -0400
Mike Frysinger <vapier@gentoo.org> wrote:

> On Thu 26 Jun 2014 12:52:45 Steven Rostedt wrote:
> > From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> > 
> > Nothing sets function_trace_stop to disable function tracing anymore.
> > Remove the check for it in the arch code.
> > 
> > [ Please test this on your arch ]
> 
> i haven't tested, but the asm looks correct -- it's only using scratch 
> registers, and the rest of the code doesn't rely on the state in that ifdef 
> (by design).
> 
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> -mike

Thanks!

-- Steve
