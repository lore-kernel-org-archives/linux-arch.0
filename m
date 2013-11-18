From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 3/5] qrwlock: Enable fair queue read/write lock
Date: Mon, 18 Nov 2013 10:55:37 -0800
Message-ID: <CA+55aFwhX-6DzxKMPk=NTmSGt1GNHE6XTHZcss+Q=hC-epC7cQ@mail.gmail.com>
References: <1384267735-43213-1-git-send-email-Waiman.Long@hp.com>
	<1384267735-43213-5-git-send-email-Waiman.Long@hp.com>
	<CA+55aFxXu7eC1WGfZ=_JQbLLJHM5HYRkJPjm3jBDC51SL66Ecw@mail.gmail.com>
	<20131118183433.GB29695@two.firstfloor.org>
	<CA+55aFyH_BUrrzft-1JGZ5zL=KxGrUESBBOZnzT=nQm6Ld0V+Q@mail.gmail.com>
	<20131118184644.GC29695@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131118184644.GC29695@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 18, 2013 at 10:46 AM, Andi Kleen <andi@firstfloor.org> wrote:
>> Why would it make sense here?
>
> There may be cases were switching all read locks to unfair may make
> concerete workloads slower.

Sorry, but I don't believe in "may be" as an excuse for complexity.
Especially since the "may be" faster performance is often coupled with
"known latency problems due to unfairness".

I'd want numbers for real loads if we really want the extra complexity.

Right now, the real numbers I can point to is in the size of the
patch, and the extra code complexity. Yes, I see the microbenchmark
numbers, but those are pretty much irrelevant to real loads.

                    Linus
