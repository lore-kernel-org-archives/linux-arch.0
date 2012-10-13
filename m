From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 20/25] sparc: Use Kbuild infrastructure to handle
 asm-generic headers
Date: Sat, 13 Oct 2012 18:00:51 -0400
Message-ID: <1350165651.24256.115.camel@gandalf.local.home>
References: <20121013022955.307620438@goodmis.org>
	 <20121012.231941.1930318153077157651.davem@davemloft.net>
	 <1350136440.24256.95.camel@gandalf.local.home>
	 <20121013.175400.1525893639346240797.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7270 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab2JMWAy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2012 18:00:54 -0400
In-Reply-To: <20121013.175400.1525893639346240797.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

On Sat, 2012-10-13 at 17:54 -0400, David Miller wrote:

> I really would like to take less rather than take more.
> 
> This whole UAPI, Kbuild, etc. stuff is just bogging subsystem
> maintainers down.  This kind of stuff should just go via the person
> who does all the work and knows how it all ties together and knows
> what dependencies, if any, exist in the series.
> 
> So please merge this yourself, thanks.

OK, will do.

-- Steve
