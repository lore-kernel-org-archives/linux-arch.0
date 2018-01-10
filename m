From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Tue, 9 Jan 2018 17:57:14 -0800
Message-ID: <20180110015713.im4atka6sahz7ucx@ast-mbp>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com>
 <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
 <CA+55aFwDZ_K1uzuTq95hUXUVLFsCPCqGAMHpwa4PLCRvszmqkQ@mail.gmail.com>
 <CAPcyv4it+Nasf1mp-+ydGP6rjHkyNKJXDTMyPrERk4V5g4yP7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4it+Nasf1mp-+ydGP6rjHkyNKJXDTMyPrERk4V5g4yP7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 09, 2018 at 04:48:24PM -0800, Dan Williams wrote:
> 
> #define __nospec_array_ptr(base, idx, sz)                               \
> ({                                                                      \
>         union { typeof(&base[0]) _ptr; unsigned long _bit; } __u;       \
>         unsigned long _i = (idx);                                       \
>         unsigned long _s = (sz);                                        \
>         unsigned long _v = (long)(_i | _s - 1 - _i)                     \
>                                         >> BITS_PER_LONG - 1;           \
>         unsigned long _mask = _v * ~0UL;                                 \
>         OPTIMIZER_HIDE_VAR(_mask);                                      \
>         __u._ptr = &base[_i & _mask];                                   \
>         __u._bit &= _mask;                                              \
>         __u._ptr;                                                       \
> })

_v * ~0UL doesn't seem right and non intuitive.
What's wrong with:
  unsigned long _mask = ~(long)(_i | _s - 1 - _i) >> BITS_PER_LONG - 1;

and why OPTIMIZER_HIDE_VAR ?
Could you remove '&' ?
since in doesn't work for:
struct {
  int fd[4];
  ...
} *fdt;
it cannot be used as array_acces(fdt->fd, ...);

Could you please drop nospec_ prefix since it is misleading ?
This macro doesn't prevent speculation.
I think array_access() was the best name so far.
