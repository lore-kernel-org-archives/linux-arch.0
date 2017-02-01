From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
Date: Tue, 31 Jan 2017 16:32:09 -0800
Message-ID: <CA+55aFxonFBHA8g_fBxCBuHQh=bakmM+np7RYDn2BY09Nd=7Nw@mail.gmail.com>
References: <20170131165537.GC23970@htj.duckdns.org> <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
 <CA+55aFx0u8SpEYOkNymXBu7_q5uF-MitrjmpDx9+Uj3fgnxgRg@mail.gmail.com>
 <20170131221141.GA5379@htj.duckdns.org> <CA+55aFyn+pVeZKA1wEdbBMku_2UCL7BuUX1O_RvHpH5LJXEy5Q@mail.gmail.com>
 <20170131222707.GA5919@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170131222707.GA5919@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dougmill@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 31, 2017 at 2:27 PM, Tejun Heo <tj@kernel.org> wrote:
>
> My bad.  I misread the generic test_bit() code and was reading the
> inner helper of ppc, DEFINE_TESTOP macro, which returns the masked
> value.  We used to have this problem, right?  I seem to have a memory
> of hitting this issue.

Yes. We used to haev the problem, but that's long ago.

> Is there a reason we don't make these functions explicitly return
> bool?  To avoid unnecessary boolean conversion by the compiler?  If
> so, there gotta be a way to avoid that.

We could certainly encourage people to do it on a case-by-case basis,
but yes, on some architectures it ends up not being convenient.

Take that i386 case of "atomic64_add_unless()", for example: the
assembly code really *does* end up returning a "bool", but we can't
tell the C compiler that, because we (due to the special calling
conventions) call it from an inline asm. And we pass in the input
values as a 64-bit register pair (%eax:%edx), gcc gets unhappy if we
then get the return value in just %eax (at least some versions did).

So to make gcc happy, we "lie" and say that the inline asm writes to
the 64-bit register pair, and then that "(int)" cast is to just
discard the upper bits in %edx, so that it just returns %eax. Which is
the end result we want.

But casting it to bool would make gcc generate a totally pointless
extra comparison against 0. Of course, as long as everybody just tests
the value, that's fine (you need the compare anyway for the test), but
the code we have now is basically correct and better.

Of course, for even better code, we might just change the asm code to
return the conditional in ZF instead, which avoids the whole "return
register is used as part of a register pair for input" issue entirely,
and would allow us to use the nifty condition code output logic in
gcc, generating even better code, _and_ would allow us to just specify
the return value as "bool" the way we do on x86-64.

But the condition code output feature is fairly new, and somebody
would need to rewrite both the cmpxchg64 and the non-atomic versions
to do the proper thing. So in the meantime the x86-32 version actually
*does* the right thing and returns 0/1, but doesn't show it as a
"bool" type.

The ppc64 code problem might be fixed by just changing the ppc code to
use a "bool" return value, and haev the compiler generate the test
that it currently doesn't (and that causes the problem with high
bits).

                       Linus
