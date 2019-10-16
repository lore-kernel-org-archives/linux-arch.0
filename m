Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:50136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392991AbfJPMYo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 08:24:44 -0400
Date: Wed, 16 Oct 2019 14:24:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] change of calling conventions for
 arch_futex_atomic_op_inuser()
In-Reply-To: <20191016121232.GA28742@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.1910161422200.2046@nanos.tec.linutronix.de>
References: <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com> <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com> <20191013191050.GL26530@ZenIV.linux.org.uk> <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com> <20191013195949.GM26530@ZenIV.linux.org.uk>
 <20191015180846.GA31707@ZenIV.linux.org.uk> <20191016121232.GA28742@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-arch@vger.kernel.org
Message-ID: <20191016122408.x3rgAg9FESn1GlkSlquXzoTGgfVSgSDbmPcPVOktw-k@z>

On Wed, 16 Oct 2019, Al Viro wrote:
> On Tue, Oct 15, 2019 at 07:08:46PM +0100, Al Viro wrote:
> > [futex folks and linux-arch Cc'd]
> 
> > Another question: right now we have
> >         if (!access_ok(uaddr, sizeof(u32)))
> >                 return -EFAULT;
> > 
> >         ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
> >         if (ret)
> >                 return ret;
> > in kernel/futex.c.  Would there be any objections to moving access_ok()
> > inside the instances and moving pagefault_disable()/pagefault_enable() outside?
> > 
> > Reasons:
> > 	* on x86 that would allow folding access_ok() with STAC into
> > user_access_begin().  The same would be doable on other usual suspects
> > (arm, arm64, ppc, riscv, s390), bringing access_ok() next to their
> > STAC counterparts.
> > 	* pagefault_disable()/pagefault_enable() pair is universal on
> > all architectures, really meant to by the nature of the beast and
> > lifting it into kernel/futex.c would get the same situation as with
> > futex_atomic_cmpxchg_inatomic().  Which also does access_ok() inside
> > the primitive (also foldable into user_access_begin(), at that).
> > 	* access_ok() would be closer to actual memory access (and
> > out of the generic code).
> > 
> > Comments?
> 
> FWIW, completely untested patch follows; just the (semimechanical) conversion
> of calling conventions, no per-architecture followups included.  Could futex
> folks ACK/NAK that in principle?

Makes sense and does not change any of the futex semantics. Go wild.

Thanks,

	tglx
