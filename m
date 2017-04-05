From: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Wed, 05 Apr 2017 07:01:57 -0700 (PDT)
Message-ID: <20170405.070157.871721909352646302.davem@davemloft.net>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
        <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
        <20170404130233.1f45115b@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404130233.1f45115b@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: npiggin@gmail.com
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@ozlabs.org
List-Id: linux-arch.vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 4 Apr 2017 13:02:33 +1000

> On Mon, 3 Apr 2017 17:43:05 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> But that depends on architectures having some pattern that we *can*
>> abstract. Would some "begin/in-loop/end" pattern like the above be
>> sufficient?
> 
> Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> for x86, and it looks like sparc64 too. So we could do that if you
> prefer.

Sparc64 has two cases, on older chips we can induce a cpu thread yield
with a special sequence of instructions, and on newer chips we have
a bonafide pause instruction.

So cpu_relax() all by itself pretty much works for us.
