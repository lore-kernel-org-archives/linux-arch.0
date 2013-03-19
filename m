From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] tracing: syscall_regfunc() should not skip kernel
 threads
Date: Tue, 19 Mar 2013 11:36:36 -0400
Message-ID: <1363707396.5938.32.camel@gandalf.local.home>
References: <1363548972.25967.137.camel@gandalf.local.home>
	 <20130317182834.GA22989@redhat.com>
	 <1363546493.25967.129.camel@gandalf.local.home>
	 <20130317190438.GA24582@redhat.com>
	 <32387.1363705826@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20855 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab3CSPgh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Mar 2013 11:36:37 -0400
In-Reply-To: <32387.1363705826@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>

On Tue, 2013-03-19 at 15:10 +0000, David Howells wrote:
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Why? If we remove the tracepoint from the slowpath and use a table swap,
> > then we wouldn't need to use the slowpath at all.
> 
> How are you engineering a table swap?  Do you patch the system call code to
> change the immediate address loaded or do you put in a level of indirection?

Patching the call site would probably be the easiest method.

We've gotten pretty good at doing that ;-)

-- Steve
