From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Tue, 9 Jan 2018 19:27:56 -0800
Message-ID: <CA+55aFzHNQjPojSEwWfLfSXkhjvCBddT-bY2kj8Fk=vVzZ5V8g@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com> <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
 <CA+55aFwDZ_K1uzuTq95hUXUVLFsCPCqGAMHpwa4PLCRvszmqkQ@mail.gmail.com> <CAPcyv4it+Nasf1mp-+ydGP6rjHkyNKJXDTMyPrERk4V5g4yP7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4it+Nasf1mp-+ydGP6rjHkyNKJXDTMyPrERk4V5g4yP7A@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 9, 2018 at 4:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> I looks like there is another problem, or I'm misreading the
> cleverness.

I think you were misreading it.

I was basically saying that this:

        unsigned long _mask = ~(long)(_m - 1 - _i) >> BITS_PER_LONG - 1;\

doesn't work, and that the "_m -1 - _i" needs to be replaced by "_i |
_m -1 -_i".

So you have

        unsigned long _mask = ~(long)(_i (_m - 1 - _i)) >> BITS_PER_LONG - 1;\

which should give the right result. No?

But as mentioned, I think you can do it with two instructions if you
do an architecture-specific inline asm:

        unsigned long mask;

        asm("cmpq %1,%2; sbbq %0,%0"
                :"=r" (mask)
                :"g" (max),"r" (idx));

which is likely much faster, and has much better register usage ("max"
can be a constant or loaded directly from memory, and "mask" could be
assigned the same register as idx).

But once again, I didn't really test it.

Note that the "cmpq/sbbq" version works regardless of max/idx values,
since it literally does the math in BITS_ION_LONG+1 bits.

In contrast, the "binary or with idx" version only works if the high
bit set in idx cannot be valid (put another way: 'max' must not be
bigger than MAXLONG+1).

           Linus
