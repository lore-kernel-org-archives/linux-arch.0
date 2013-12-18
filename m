Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56752 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab3LRTRT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2013 14:17:19 -0500
Date: Wed, 18 Dec 2013 20:16:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 1/4] qrwlock: A queue read/write lock implementation
Message-ID: <20131218191652.GD16438@laptop.programming.kicks-ass.net>
References: <1385147087-26588-1-git-send-email-Waiman.Long@hp.com>
 <1385147087-26588-2-git-send-email-Waiman.Long@hp.com>
 <20131217192128.GA15969@linux.vnet.ibm.com>
 <52B1ED2D.3020000@hp.com>
 <20131218185910.GS19211@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131218185910.GS19211@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Waiman Long <waiman.long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, aswin@hp.com, Scott J Norton <scott.norton@hp.com>
Message-ID: <20131218191652.tnJRKvaWU33J1Urrx7FWZVuZ4bpE5dy8blQaqXWg3Y0@z>

On Wed, Dec 18, 2013 at 10:59:10AM -0800, Paul E. McKenney wrote:
> I am hoping that it makes it into -tip soon, as I also have a patch that
> depends on it.

Just send out the hopefully final version.

lkml.kernel.org/r/20131218190806.370008594@infradead.org
