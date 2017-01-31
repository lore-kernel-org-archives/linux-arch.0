From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
Date: Tue, 31 Jan 2017 14:17:10 -0800
Message-ID: <CA+55aFyn+pVeZKA1wEdbBMku_2UCL7BuUX1O_RvHpH5LJXEy5Q@mail.gmail.com>
References: <20170131165537.GC23970@htj.duckdns.org> <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
 <CA+55aFx0u8SpEYOkNymXBu7_q5uF-MitrjmpDx9+Uj3fgnxgRg@mail.gmail.com> <20170131221141.GA5379@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33599 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdAaW0b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2017 17:26:31 -0500
In-Reply-To: <20170131221141.GA5379@htj.duckdns.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dougmill@linux.vnet.ibm.com

On Tue, Jan 31, 2017 at 2:11 PM, Tejun Heo <tj@kernel.org> wrote:
>
> We have a similar mess with bitops too.  x86 is cleaned up to have
> bool returns but the generic implementation and a lot of other archs
> return the tested bit instead of 1/0.  It'd be great to make all the
> boolean functions actually return bool.

If they really do return the tested bit, then those architectures
absolutely _will_ contain known bugs.

Because there definitely have been users of the bitop routines that
assign the result to an "int", and I have some dim memory of us also
having had things like drivers that made their own "bool" variables
and use "char" for them.

But I'm not seeing it. The generic bitop pattern seems to be

    static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
    ...
        return (old & mask) != 0;

which is fine.

Just exactly what code did you look at?

                  Linus
