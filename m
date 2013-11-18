From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v6 3/5] qrwlock: Enable fair queue read/write lock
Date: Mon, 18 Nov 2013 19:46:44 +0100
Message-ID: <20131118184644.GC29695@two.firstfloor.org>
References: <1384267735-43213-1-git-send-email-Waiman.Long@hp.com>
 <1384267735-43213-5-git-send-email-Waiman.Long@hp.com>
 <CA+55aFxXu7eC1WGfZ=_JQbLLJHM5HYRkJPjm3jBDC51SL66Ecw@mail.gmail.com>
 <20131118183433.GB29695@two.firstfloor.org>
 <CA+55aFyH_BUrrzft-1JGZ5zL=KxGrUESBBOZnzT=nQm6Ld0V+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyH_BUrrzft-1JGZ5zL=KxGrUESBBOZnzT=nQm6Ld0V+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <andi@firstfloor.org>, Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>
List-Id: linux-arch.vger.kernel.org

> Why would it make sense here?

There may be cases were switching all read locks to unfair may make
concerete workloads slower.

The effect is very visible in (non kernel) lock micro benchmarks,
especially with HyperThreading.

With very high contention or long enough critical sections 
the ordered lock usually wins, but it loses with lower contention.

Unfortunately the "small critical section" case (even though it's
really bad for any contended lock) is reasonably common :-/
[IMHO all of these should be fixed or "batched" somehow, but in some 
cases it is quite hard]

However ordered locks definitely have more consistent performance.
If prioritizing consistency over potential slow down in some cases
is fine only having the ordered option is ok.

-Andi
