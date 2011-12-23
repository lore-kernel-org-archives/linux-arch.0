From: Christoph Lameter <cl@linux.com>
Subject: Re: [GIT PULL] slab fixes for 3.2-rc4
Date: Fri, 23 Dec 2011 10:55:08 -0600 (CST)
Message-ID: <alpine.DEB.2.00.1112231031001.3482@router.home>
References: <alpine.LFD.2.02.1111292001420.4019@tux.localdomain> <CA+55aFz23nN4EALZKf1uptn3a+LKU8wehEnxXO7WA8J5WAyPAQ@mail.gmail.com> <CAOJsxLEHT4D4rfMvWe5iPFpunOaLWZD9fJxbOJ6_qMwt_rd7eg@mail.gmail.com> <20111220162315.GC10752@google.com>
 <CA+55aFwwjAtiiM5V3LfebmtKAOzxZXk-VzJ3U7PJAc1VjxK69Q@mail.gmail.com> <20111220202854.GH10752@google.com> <alpine.DEB.2.00.1112210851230.9601@router.home> <20111221170535.GB9213@google.com> <alpine.DEB.2.00.1112220854440.31315@router.home>
 <20111222160822.GE17084@google.com> <alpine.DEB.2.00.1112221154380.11787@router.home> <CA+55aFzY_6QYVyjAmP+w8D0Xy1Pq++XEUaBJRcCN9SbDE-pOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp109.prem.mail.ac4.yahoo.com ([76.13.13.92]:21692 "HELO
	smtp109.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752371Ab1LWQzM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Dec 2011 11:55:12 -0500
In-Reply-To: <CA+55aFzY_6QYVyjAmP+w8D0Xy1Pq++XEUaBJRcCN9SbDE-pOhw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Thu, 22 Dec 2011, Linus Torvalds wrote:

> As far as I can tell, there are just a couple of users of that
> horrible interface, it really isn't worth it. Just remove it and
> opencode it. They are actually broken on x86 ('xadd' only exists if
> CONFIG_X86_XADD is on - i386 didn't have it), and while most people
> probably don't care (i386? What's that?), I note that the x86
> add_return stuff doesn't take that into account.

There is an #ifndef CONFIG_M386 around the implementation of these for
x86. Use on i386 will not generate an xadd instructions but fallback to a
generic implementation.

The add_return stuff was already available with the earlier per cpu apis
(local_t and percpu) that this_cpu replaces and is still available through
the atomic operations.

If one wants to exploit the per cpu atomicity then one may want to know
what the result was. Inspecting the value is not possible later in the
execution path if there are potential races on the processor through
preemption as well as interrupts. The _return variants also avoid
additional load instructions and thereby reduce code path size.
