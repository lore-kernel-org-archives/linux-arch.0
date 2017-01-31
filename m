From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
Date: Tue, 31 Jan 2017 13:32:38 -0800
Message-ID: <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
References: <20170131165537.GC23970@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35384 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdAaVkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2017 16:40:18 -0500
In-Reply-To: <20170131165537.GC23970@htj.duckdns.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dougmill@linux.vnet.ibm.com

On Tue, Jan 31, 2017 at 8:55 AM, Tejun Heo <tj@kernel.org> wrote:
>
> Douglas found and fixed a ref leak bug in percpu_ref_tryget[_live]().
> The bug is caused by storing the return value of
> atomic_long_inc_not_zero() into an int temp variable before returning
> it as a bool.  The interim cast to int loses the upper bits and can
> lead to false negatives.  As percpu_ref uses a high bit to mark a
> draining counter, this can happen relatively easily.  Fixed by using
> bool for the temp variable.

I think this fix is wrong.

The fact is, atomic_long_inc_not_zero() shouldn't be returning
anything with high bits.. Casting to "int" should have absolutely no
impact. "int" is the traditional C truth value (with zero/nonzero
being false/true), and while we're generally moving towards "bool" for
true/false return values, I do think that code that assumes that these
functions can be cast to "int" are right.

For example, we used to have similar bugs in "test_bit()" returning
the actual bit value (which could be high).

And when users hit that problem, we fixed "test_bit()", not the users of it.

So I'd rather fix the places that (insanely) return a 64-bit value.

Is this purely a ppc64 issue, or does it happen somewhere else too?
Basically, the functions

  atomic*_sub_and_test()
  atomic*_dec_and_test()
  atomic*_inc_and_test()
  atomic*_add_negative()
  atomic*_add_unless()

should all be returning a proper bool/int truth value (preferably 0/1
so that we don't need to worry about it), not some random crazy value.

I've pulled this, but I really think it's papering over the real
issue. Adding "linux-arch" mailing list to ask architecture
maintainers to check their implementation of the atomic ops that
return a truth value.

                      Linus
