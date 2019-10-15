From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
Date: Tue, 15 Oct 2019 12:00:34 -0700
Message-ID: <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
References: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk> <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk> <20191015180846.GA31707@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191015180846.GA31707@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 15, 2019 at 11:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Another question: right now we have
>         if (!access_ok(uaddr, sizeof(u32)))
>                 return -EFAULT;
>
>         ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
>         if (ret)
>                 return ret;
> in kernel/futex.c.  Would there be any objections to moving access_ok()
> inside the instances and moving pagefault_disable()/pagefault_enable() outside?

I think we should remove all the "atomic" versions, and just make the
rule be that if you want atomic, you surround it with
pagefault_disable()/pagefault_enable().

That covers not just the futex ops (where "atomic" is actually
somewhat ambiguous - the ops themselves are atomic too, so the naming
might stay, although arguably the "futex" part makes that pointless
too), but also copy_to_user_inatomic() and the powerpc version of
__get_user_inatomic().

So we'd aim to get rid of all the "inatomic" ones entirely.

Same ultimately probably goes for the NMI versions. We should just
make it be a rule that we can use all of the user access functions
with pagefault_{dis,en}able() around them, and they'll be "safe" to
use in atomic context.

One issue with the NMI versions is that they actually want to avoid
the current value of set_fs().  So copy_from_user_nmi() (at least on
x86) is special in that it does

        if (__range_not_ok(from, n, TASK_SIZE))
                return n;

instead of access_ok() because of that issue.

NMI also has some other issues (nmi_uaccess_okay() on x86, at least),
but those *probably* could be handled at page fault time instead.

Anyway, NMI is so special that I'd suggest leaving it for later, but
the non-NMI atomic accesses I would suggest you clean up at the same
time.

I think the *only* reason we have the "inatomic()" versions is that
the regular ones do that "might_fault()" testing unconditionally, and
might_fault() _used_ to be just a might_sleep() - so it's not about
functionality per se, it's about "we have this sanity check that we
need to undo".

We've already made "might_fault()" look at pagefault_disabled(), so I
think a lot of the reasons for inatomic are entirely historical.

                Linus
