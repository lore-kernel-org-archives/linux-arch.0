From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Mon, 8 Jan 2018 20:13:20 -0800
Message-ID: <CA+55aFwDZ_K1uzuTq95hUXUVLFsCPCqGAMHpwa4PLCRvszmqkQ@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com> <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 8, 2018 at 7:42 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> originally from Linus and tweaked by Alexei and I:

Sadly, that tweak - while clever - is wrong.

>         unsigned long _mask = ~(long)(_m - 1 - _i) >> BITS_PER_LONG - 1;\

Why?

Because "(long)(_m-1-_i)" is not negative just because "i >= m". It
can still be positive.

Think "m = 100", "i=bignum". The subtraction will overflow and become
positive again, the shift will shift to zero, and then the mask will
become ~0.

Now, you can fix it, but you need to be a tiny bit more clever.  In
particular, just make sure that you retain the high bit of "_i",
basically making the rule be that a negative index is not ever valid.

And then instead of "(_m - 1 - _i)", you use "(_i | (_m - 1 - _i))".
Now the sign bit is set if _i had it set, _or_ if the subtraction
turned negative, and you don't have to worry about the overflow
situation.

But it does require that extra step to be trustworthy. Still purely
cheap arithmetic operations, although there is possibly some
additional register pressure there.

Somebody might be able to come up with something even more minimal (or
find a fault in my fix of your tweak).

Obviously, with architecture-specific code, you may well be able to do
better, using the carry flag of the subtraction.

For example, on x86, I think you could do it with just two instructions:

    # carry will be clear if idx >= max
    cmpq %idx,%max

    # mask will be clear if carry was clear, ~0 otherwise
    sbbq %mask,%mask

to generate mask directly. I might have screwed that up. Worth perhaps trying?

               Linus
