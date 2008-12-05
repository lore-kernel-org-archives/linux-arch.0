From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 5 Dec 2008 11:43:12 +1100
Message-ID: <18744.31008.944385.467622@cargo.ozlabs.ibm.com>
References: <20081204225345.654705757@linutronix.de>
	<49387463.5070100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:39994 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbYLEAnT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 4 Dec 2008 19:43:19 -0500
In-Reply-To: <49387463.5070100@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

H. Peter Anvin writes:

> First of all, let me say I really like what I've seen so far.  The file
> descriptor paradigm seems really elegant to me.

I have to say, without intending any disrespect, that it looks to me
like it was designed by someone who hasn't actually ever done much
serious performance analysis or tuning using these hardware
facilities.  If I'm wrong about that, I'm willing to be corrected.

Paul.
