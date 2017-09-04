From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core] locking/refcount: Create unchecked atomic_t
 implementation
Date: Mon, 4 Sep 2017 21:35:27 +0200
Message-ID: <20170904193527.GB17526@worktop.programming.kicks-ass.net>
References: <20170621200026.GA115679@beast>
 <tip-fd25d19f6b8da315332bb75936605fb45d3ea981@git.kernel.org>
 <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
 <CAGXu5jJdpFk0GNWiw6sswthf3=gAptmLi6xmQqMvUigUYDFsQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbdIDTfj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2017 15:35:39 -0400
Content-Disposition: inline
In-Reply-To: <CAGXu5jJdpFk0GNWiw6sswthf3=gAptmLi6xmQqMvUigUYDFsQg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, Manfred Spraul <manfred@colorfullife.com>, Rik van Riel <riel@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Eric Biggers <ebiggers3@gmail.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, Alexey Dobriyan <adobriyan@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Hans Liljestrand <ishkamiel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-founda>

On Mon, Sep 04, 2017 at 10:11:37AM -0700, Kees Cook wrote:
> On Mon, Sep 4, 2017 at 5:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Jun 28, 2017 at 09:58:15AM -0700, tip-bot for Kees Cook wrote:
> >> locking/refcount: Create unchecked atomic_t implementation
> >
> > This seems to do only half the job. Here's the rest.
> >
> > ---
> > Subject: locking/refcount: Finish unchecked atomic_t implementation
> >
> > For some reason the unchecked atomic_t implementation stopped half-way
> > through, complete it it.
> 
> Hmm? The reason is that the implementation of the remaining functions
> is unchanged between full, unchecked, and x86.

But they're wasted code if !arch because the existing atomic functions
are adequate (and I would argue better in case of atomic_add_unless).

And arch implementations would certainly want to reimplement dec_not_one.

Plus, you completely failed mention any of this.
