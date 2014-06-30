From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFA][PATCH 20/27] parisc: ftrace: Remove check of obsolete
 variable function_trace_stop
Date: Mon, 30 Jun 2014 10:11:41 -0400
Message-ID: <20140630101141.07d53971@gandalf.local.home>
References: <20140626165221.736847419@goodmis.org>
	<20140626165852.497955187@goodmis.org>
	<20140626133548.03f7b90a@gandalf.local.home>
	<53B08317.7010501@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B08317.7010501@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, 29 Jun 2014 23:20:23 +0200
Helge Deller <deller@gmx.de> wrote:

> Sadly the arch-related tracing code in parisc is really broken.
> It doesn't even compile cleanly on parisc (at least on 64bit), and as I wrote you in another mail
> I really need to fix this soon (which I already started on).
> 
> But your patches look clean, so to get the basics right, I'm happy to give a 
> Acked-by: Helge Deller <deller@gmx.de>
> for the two patches which affect parisc, which are:
> [PATCH 08/27] parisc: ftrace: Add call to ftrace_graph_is_dead() in function graph code
> [PATCH 20/27] parisc: ftrace: Remove check of obsolete variable function_trace_stop

Thanks!

> 
> It would be good if you can push them through your tree.
> I assume your tree is: 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> with branch ftrace/next. 
> Is this correct?
> If yes, I can build my patches upon this tree...
> 

Actually the patches are in my branch: rfc/remove-function-trace-stop


-- Steve
