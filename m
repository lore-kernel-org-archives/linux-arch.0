From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Mon, 15 May 2017 23:58:19 +0300
Message-ID: <20170515205819.womvfygyo55hbua6@yury-N73SV>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
 <20170514180917.bil7xr4bqtfk6fzj@gmail.com>
 <20170515154728.amzw3d67tw722wmu@yury-N73SV>
 <CAK8P3a3vLW+bX4PcZ6J6At49ptFnyqEM8FxCRKVDBD9wv2YyKQ@mail.gmail.com>
 <20170515161708.aatms7fcwlguxkri@yury-N73SV>
 <CAK8P3a2z=aM0bJCQ_ykjxUGC8Z93sOEk99jaKuFQGB0qnmBA_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2z=aM0bJCQ_ykjxUGC8Z93sOEk99jaKuFQGB0qnmBA_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>
List-Id: linux-arch.vger.kernel.org

On Mon, May 15, 2017 at 10:31:17PM +0200, Arnd Bergmann wrote:
> On Mon, May 15, 2017 at 6:17 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > On Mon, May 15, 2017 at 06:06:18PM +0200, Arnd Bergmann wrote:
> >> On Mon, May 15, 2017 at 5:47 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> >> > On Sun, May 14, 2017 at 08:09:17PM +0200, Ingo Molnar wrote:
> >> >
> >> > I also think that sched_find_first_bit() may be faster that find_first_bit()
> >> > because it's inlined in the caller. We can do so for find_first_bit() if
> >> > it takes small sizes at compile time, and so all parts of kernel will
> >> > use fast find_first_bit, not only sched.
> >>
> >> I suspect the first step would be to 'select GENERIC_FIND_FIRST_BIT'
> >> on ARM64, which should already improve the performance for those
> >> files that never call the 'next' variants.
> >>
> >> Adding an inline version of find_first_{,zero_}bit could also help, but
> >> is harder to quantify.
> >>
> >
> > I checked again, and in fact I measured on top of this patch:
> > https://lkml.org/lkml/2017/5/13/137
> > So find_first_bit is already enabled.
> 
> Ok. I've played around with this for a bit more and came to a generic
> version that is almost as good as the current sched_find_first_bit()
> on x86 (one extra comparison):
> 
> +#define sched_find_first_bit(b) find_first_bit(b, 128)
> -extern unsigned long find_first_bit(const unsigned long *addr,
> +extern unsigned long __find_first_bit(const unsigned long *addr,
>                                     unsigned long size);
> 
> +static inline unsigned long find_first_bit(const unsigned long *addr,
> +                                   unsigned long size)
> +{
> +       unsigned long idx;
> +
> +       if (!__builtin_constant_p(size))
> +               return __find_first_bit(addr, size);
> +
> +       idx = 0;
> +       switch (size) {
> +       case BITS_PER_LONG * 4:
> +               if (addr[0])
> +                       return __ffs(addr[0]) + idx;
> +               addr++;
> +               idx += BITS_PER_LONG;
> +       case BITS_PER_LONG * 3:
> +               if (addr[0])
> +                       return __ffs(addr[0]) + idx;
> +               addr++;
> +               idx += BITS_PER_LONG;
> +       case BITS_PER_LONG * 2:
> +               if (addr[0])
> +                       return __ffs(addr[0]) + idx;
> +               addr++;
> +               idx += BITS_PER_LONG;
> +       case BITS_PER_LONG * 1:
> +               if (addr[0])
> +                       return __ffs(addr[0]) + idx;
> +               addr++;
> +               idx += BITS_PER_LONG;
> +               return idx;
> +       }
> +
> +       return __find_first_bit(addr, size);
> +}
> 
Yes, something like this. But size is not the multiple of BITS_PER_LONG in
general. This should work better:

       switch (round_up(size), BITS_PER_LONG) {
       case BITS_PER_LONG * 4:
               if (addr[0])
                       goto ret;
               addr++;
               idx += BITS_PER_LONG;
       case BITS_PER_LONG * 3:
               if (addr[0])
                       goto ret;
               addr++;
               idx += BITS_PER_LONG;
       case BITS_PER_LONG * 2:
               if (addr[0])
                       goto ret;
               addr++;
               idx += BITS_PER_LONG;
       case BITS_PER_LONG * 1:
               if (addr[0])
                       goto ret;
               addr++;
               idx += BITS_PER_LONG;
               return idx;
       }

       return __find_first_bit(addr, size);

ret:
       return idx + min(__ffs(addr[0]), size % BITS_PER_LONG;
       }

(I didn't test it yet though)

> However, on architectures that rely on
> include/asm-generic/bitops/__ffs.h or something
> similarly verbose, this would just add needless bloat
> to the size rather than actually making a difference
> in performance.
> 
>         Arnd
