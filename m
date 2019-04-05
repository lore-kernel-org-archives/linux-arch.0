Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40551 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Apr 2019 11:50:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id a28so4726791lfo.7
        for <linux-arch@vger.kernel.org>; Fri, 05 Apr 2019 08:50:52 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w1sm4438295lfn.79.2019.04.05.08.50.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:50:49 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 10so4723691lfr.8
        for <linux-arch@vger.kernel.org>; Fri, 05 Apr 2019 08:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-18-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-18-will.deacon@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Apr 2019 05:50:32 -1000
Message-ID: <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] drivers: Remove explicit invocations of mmiowb()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405155032.ZmHPn5YG91SFFp83cn6XxnV9A6s-xhlxkoIW7GByl7E@z>

On Fri, Apr 5, 2019 at 4:01 AM Will Deacon <will.deacon@arm.com> wrote:
>
> mmiowb() is now implied by spin_unlock() on architectures that require
> it, so there is no reason to call it from driver code. This patch was
> generated using coccinelle:
>
>         @mmiowb@
>         @@
>         - mmiowb();

So I love the patch series, and think we should just do it, but I do
wonder if some of the drivers involved end up relying on memory
ordering things (store_release -> load_aquire) and IO ordering rather
than using locking...

Wouldn't such use now be broken on ia64 SN platforms? Do we care?

So it might be worth noting that a lot of the mmiowb()s here weren't
paired with spin_unlock?

                    Linus
