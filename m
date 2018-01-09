From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Mon, 8 Jan 2018 19:42:14 -0800
Message-ID: <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <87lgh7n2tf.fsf@xmission.com>
Sender: netdev-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 8, 2018 at 7:11 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> Static analysis reports that 'index' may be a user controlled value that
>> is used as a data dependency reading 'rt' from the 'platform_label'
>> array.  In order to avoid potential leaks of kernel memory values, block
>> speculative execution of the instruction stream that could issue further
>> reads based on an invalid 'rt' value.
>
>
> In detail.
> a) This code is fast path packet forwarding code.  Introducing an
>    unconditional pipeline stall is not ok.
>
>    AKA either there is no speculation and so this is invulnerable
>    or there is speculation and you are creating an unconditional
>    pipeline stall here.
>
>    My back of the napkin caluculations say that a pipeline stall
>    is about 20 cycles.  Which is about the same length of time
>    as a modern cache miss.
>
>    On a good day this code will perform with 0 cache misses. On a less
>    good day 1 cache miss.  Which means you are quite possibly doubling
>    the runtime of mpls_forward.
>
> b) The array is dynamically allocated which should provide some
>    protection, as it will be more difficult to predict the address
>    of the array which is needed to craft an malicious userspace value.
>
> c) The code can be trivially modified to say:
>
> static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
> {
>         struct mpls_route *rt = NULL;
>
>         if (index < net->mpls.platform_labels) {
>                 struct mpls_route __rcu **platform_label =
>                         rcu_dereference(net->mpls.platform_label);
>                 rt = rcu_dereference(platform_label[index & ((1 << 20) - 1)]);
>         }
>         return rt;
> }
>
> AKA a static mask will ensure that there is not a primitive that can be
> used to access all of memory.  That is max a 1 cycle slowdown in the
> code, which is a much better trade off.
>
> d) If we care more it is straight forward to modify
>    resize_platform_label_table() to ensure that the size of the array
>    is always a power of 2.
>
> e) The fact that a pointer is returned from the array and it is treated
>    like a pointer would seem to provide a defense against the
>    exfiltration technique of using the value read as an index into
>    a small array, that user space code can probe aliased cached
>    lines of, to see which value was dereferenced.
>
>
> So to this patch in particular.
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> This code path will be difficult to exploit.  This change messes with
> performance.  There are ways to make this code path useless while
> preserving the performance of the code.
>

Thanks, Eric understood. The discussion over the weekend  came to the
conclusion that using a mask will be the default approach. The
nospec_array_ptr() will be defined to something similar to the
following, originally from Linus and tweaked by Alexei and I:

#define __nospec_array_ptr(base, idx, sz)                               \
({                                                                      \
        union { typeof(&base[0]) _ptr; unsigned long _bit; } __u;       \
        unsigned long _i = (idx);                                       \
        unsigned long _m = (max);                                       \
        unsigned long _mask = ~(long)(_m - 1 - _i) >> BITS_PER_LONG - 1;\
        OPTIMIZER_HIDE_VAR(_mask);                                      \
        __u._ptr = &base[_i & _mask];                                   \
        __u._bit &= _mask;                                              \
        __u._ptr;                                                       \
})

Does that address your performance concerns?
