Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37185 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDEQPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Apr 2019 12:15:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so4789600lfl.4
        for <linux-arch@vger.kernel.org>; Fri, 05 Apr 2019 09:15:32 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c15sm4506596lfi.14.2019.04.05.09.15.28
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 09:15:29 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 10so4779484lfr.8
        for <linux-arch@vger.kernel.org>; Fri, 05 Apr 2019 09:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com> <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
 <20190405160919.GA7857@fuggles.cambridge.arm.com>
In-Reply-To: <20190405160919.GA7857@fuggles.cambridge.arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Apr 2019 06:15:12 -1000
Message-ID: <CAHk-=wiBQwAL5hoLD9-EmCAf1N9CUmUkuj_jJhUCsboNLy-uLw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Remove Mysterious Macro Intended to Obscure
 Weird Behaviours (mmiowb())
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405161512.1Zq2vJBHy6nlzWnSDB7of4He-IV0gV2NATst_cSvMfY@z>

On Fri, Apr 5, 2019 at 6:09 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Or did I miss something? I think the ia64() mb/rmb/wmb stuff only
> > works on normal memory on ia64.
>
> I was worried about RISC-V, but actually their wmb() is "fence ow,ow"
> which I think is stronger than their mmiowb() "fence o,w" implementation.

Also with smp_store_release -> smp_load_acquire kind of ordering?

Again, this is not at all a NAK - I think we should do this - just
perhaps a request to add a note to the commit and make people aware of
the issue.

I suspect very few drivers use non-locking serialization to begin with.

                 Linus
