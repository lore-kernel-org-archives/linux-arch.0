Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757029AbeD0Cj6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Apr 2018 22:39:58 -0400
Date: Fri, 27 Apr 2018 11:39:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v2 4/7] kprobes: Replace %p with other pointer
 types
Message-ID: <20180427113951.8e3192af570c0bae925b2a71@kernel.org>
In-Reply-To: <20180426211351.419d3502@vmware.local.home>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <152473020349.8819.11597612324633031612.stgit@devbox>
        <20180426211351.419d3502@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
Message-ID: <20180427023951.alO6widDNdty8VWTzlt-Yr2ikYi7hW-h-Jw-bZz3lN4@z>

On Thu, 26 Apr 2018 21:13:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Apr 2018 17:10:03 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Replace %p with appropriate pointer types (or just remove it)
> >  - Use %pS if possible
> >  - Use %px only for the function right before BUG().
> >  - Remove unneeded error message.
> 
> I'm not sure "right before BUG()" is legitimate for using %px. Why not
> still use %pS?

Since BUG() will dump all registers and stacks which includes
raw address information and reboot the system (means reset the
kaslr base offset), I thought it may not add additional damage.

Anyway, for this patch we can use %pS. For the next [5/7] patch,
I'm not sure %pS is good for dumping a stack address...

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
