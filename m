From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 31/34] tile: Use generic idle loop
Date: Fri, 29 Mar 2013 12:24:27 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303291224130.22263@ionos>
References: <20130321214930.752934102@linutronix.de> <20130321215235.348460344@linutronix.de> <515464B0.8080704@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44997 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3C2LYa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2013 07:24:30 -0400
In-Reply-To: <515464B0.8080704@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>

On Thu, 28 Mar 2013, Srivatsa S. Bhat wrote:
> 
> That doesn't look quite right, since it returns -1 (instead of 0) when
> str == poll.

Stupid me.
