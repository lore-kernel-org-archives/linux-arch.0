From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Thu, 6 Apr 2017 10:59:58 +1000
Message-ID: <20170406105958.196c6977@roar.ozlabs.ibm.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
        <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
        <20170404130233.1f45115b@roar.ozlabs.ibm.com>
        <20170405.070157.871721909352646302.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34379 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbdDFBAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2017 21:00:10 -0400
In-Reply-To: <20170405.070157.871721909352646302.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@ozlabs.org

On Wed, 05 Apr 2017 07:01:57 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Tue, 4 Apr 2017 13:02:33 +1000
> 
> > On Mon, 3 Apr 2017 17:43:05 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> >> But that depends on architectures having some pattern that we *can*
> >> abstract. Would some "begin/in-loop/end" pattern like the above be
> >> sufficient?  
> > 
> > Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> > for x86, and it looks like sparc64 too. So we could do that if you
> > prefer.  
> 
> Sparc64 has two cases, on older chips we can induce a cpu thread yield
> with a special sequence of instructions, and on newer chips we have
> a bonafide pause instruction.
> 
> So cpu_relax() all by itself pretty much works for us.
> 

Thanks for taking a look. The default spin primitives should just
continue to do the right thing for you in that case.

Arm has a yield instruction, ia64 has a pause... No unusual
requirements that I can see.

If there are no objections, I'll send the arch-independent part of
this through the powerpc tree (the last one I sent, which follows
Linus' preferred pattern).

Thanks,
Nick
