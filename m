From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
Date: Mon, 11 Feb 2019 14:34:31 -0800
Message-ID: <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211172948.3322-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 11, 2019 at 9:30 AM Will Deacon <will.deacon@arm.com> wrote:
>
> +
> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +       writes by the CPU to a particular device will arrive in program order.

Hmm. I'd like more people look at strengthening this one wrt across
CPUs and locking.

Right now we document mmiowb(), but that "documentation" is really
just a fairy tale. Very *very* few drivers actually do mmiowb() on
their own.

IOW, we should seriously just consider making the rule be that locking
will order mmio too. Because that's practically the rule anyway.

Powerpc already does it. IO within a locked region will serialize with the lock.

                Linus
