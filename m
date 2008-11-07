From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC patch 07/18] Trace clock core
Date: Thu, 6 Nov 2008 22:26:56 -0800
Message-ID: <20081106222656.8e35d9d5.akpm@linux-foundation.org>
References: <20081107052336.652868737@polymtl.ca>
	<20081107053349.699011457@polymtl.ca>
	<20081106215256.a9f01ec4.akpm@linux-foundation.org>
	<20081107061643.GA798@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39999 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898AbYKGG2P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Nov 2008 01:28:15 -0500
In-Reply-To: <20081107061643.GA798@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Nicolas Pitre <nico@cam.org>, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

On Fri, 7 Nov 2008 01:16:43 -0500 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> > Is there something we should be fixing in m68k?
> > 
> 
> Yes, but I fear it's going to go deep into include hell :-(

Oh, OK.  I thought that the comment meant that m68k's on_each_cpu()
behaves differently at runtime from other architectures (and wrongly).

If it's just some compile-time #include snafu then that's far less
of a concern.
