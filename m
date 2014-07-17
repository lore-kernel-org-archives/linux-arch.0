From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 21/29] nios2: Futex operations
Date: Thu, 17 Jul 2014 13:07:54 +0200
Message-ID: <12323898.sHjczXbE7P@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <alpine.DEB.2.10.1407151201170.24854@nanos> <CAFiDJ5-UQ4pu1Hkc444yaA6cbttTXM7KM2eProGUkYgjqvOSUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ5-UQ4pu1Hkc444yaA6cbttTXM7KM2eProGUkYgjqvOSUg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 17 July 2014 18:55:49 Ley Foon Tan wrote:
> On Tue, Jul 15, 2014 at 6:03 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 15 Jul 2014, Ley Foon Tan wrote:
> >  +static inline int atomic_futex_op_xchg_set(int oparg, u32 __user *uaddr,
> >> +                                        int *oldval)
> >> +{
> >> +     unsigned long flags;
> >> +     int ret;
> >> +
> >> +     local_irq_save(flags);
> >> +
> >> +     ret = get_user(*oldval, uaddr);
> >> +     if (!ret)
> >> +             ret = put_user(oparg, uaddr);
> >
> > This is wrong as it gets. get_user() might fault and sleep.
> >
> > You need a proper implementation, which handles fault exceptions.
> I have checked that we use nios2 specific get_user() in [1]. This
> function will not sleep and it handles fault exception.
> I think this should be fine.

The get_user/put_user functions really need to be annotated might_fault(),
because that's what they do.

The whole point of get_user() is to access an unchecked user space
pointer, which 	can do a number of things based on what the pointer
points to:

- access a user space variable that resides in memory
- access a kernel pointer and fail because of the access_ok()
  check
- access a user space pointer that is not mapped and return
  through the __ex_table fixup.
- access a user space pointer that has a valid VMA but not PTE,
  causing a page fault to be resolved.

It's the last case that breaks here.

	Arnd
