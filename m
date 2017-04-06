From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Thu, 6 Apr 2017 08:16:19 -0700
Message-ID: <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com> <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com> <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com> <20170406141352.GF18204@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36075 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdDFPQU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2017 11:16:20 -0400
In-Reply-To: <20170406141352.GF18204@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, David Miller <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Peter Zijlstra <peterz@infradead.org>

On Thu, Apr 6, 2017 at 7:13 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> We've wrapped this up in the arm64 code as __cmpwait, and we use that
> to build smp_cond_load_acquire. It would be nice to use the same machinery
> for the conditional spinning here, unless you anticipate that we're only
> going to be spinning for a handful of iterations anyway?

I suspect most of these loops aren't set up for the WFE kind of
spinning, because they look for more than one variable.

.. and the ones that _are_ set up for this probably should just be
rewritten to use smp_cond_load_acquire() anyway, because the "wait for
value" special case is fairly special.

In theory x86 could use monitor/mwait for it too, in practice I think
it tends to still be too high latency (because it was originally just
designed for the idle loop). mwait got extended to actually be useful,
but I'm not sure what the latency is for the modern one.

               Linus
