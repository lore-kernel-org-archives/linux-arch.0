From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
Date: Fri, 10 Jan 2020 18:35:02 +0100
Message-ID: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-2-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:36223 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgAJRfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 12:35:21 -0500
In-Reply-To: <20200110165636.28035-2-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
>
> Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> discarding the 'volatile' qualifier:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> We've been working around this using some nasty hacks which make
> READ_ONCE() both horribly complicated and also prevent us from enforcing
> that it is only used on scalar types. Since GCC 4.8 is pretty old for
> kernel builds now, emit a warning if we detect it during the build.

No objection to recommending gcc-4.8, but I think this should either
just warn once during the kernel build instead of for every file, or
it should become a hard requirement.

       Arnd
