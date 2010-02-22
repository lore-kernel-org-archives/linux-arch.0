From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [RFC patch] introduce sys_membarrier(): process-wide memory	barrier
 (v9)
Date: Mon, 22 Feb 2010 12:38:18 -0600
Message-ID: <4B82CF1A.3010501@nortel.com>
References: <20100212224606.GA30280@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zrtps0kp.nortel.com ([47.140.192.56]:41186 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0BVSi4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Feb 2010 13:38:56 -0500
In-Reply-To: <20100212224606.GA30280@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Nicholas Miell <nmiell@comcast.net>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, josh@joshtriplett.org, dvhltc@us.ibm.com, niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org, Valdis.Kletnieks@vt.edu, dhowells@redhat.com

On 02/12/2010 04:46 PM, Mathieu Desnoyers wrote:

> Editorial question: 
> 
> This synchronization only takes care of threads using the current process memory
> map. It should not be used to synchronize accesses performed on memory maps
> shared between different processes. Is that a limitation we can live with ?

It makes sense for an initial version.  It would be unfortunate if this
were a permanent limitation, since using separate processes with
explicit shared memory is a useful way to mitigate memory trampler issues.

If we were going to allow that, it might make sense to add an address
range such that only those processes which have mapped that range would
execute the barrier.  Come to think of it, it might be possible to use
this somehow to avoid having to execute the barrier on *all* threads
within a process.

Chris
