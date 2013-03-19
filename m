From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/2] tracing: syscall_regfunc() should not skip kernel threads
Date: Tue, 19 Mar 2013 15:10:26 +0000
Message-ID: <32387.1363705826@warthog.procyon.org.uk>
References: <1363548972.25967.137.camel@gandalf.local.home> <20130317182834.GA22989@redhat.com> <1363546493.25967.129.camel@gandalf.local.home> <20130317190438.GA24582@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137Ab3CSPKv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Mar 2013 11:10:51 -0400
In-Reply-To: <1363548972.25967.137.camel@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dhowells@redhat.com, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>

Steven Rostedt <rostedt@goodmis.org> wrote:

> Why? If we remove the tracepoint from the slowpath and use a table swap,
> then we wouldn't need to use the slowpath at all.

How are you engineering a table swap?  Do you patch the system call code to
change the immediate address loaded or do you put in a level of indirection?

David
