Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41531 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPz4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Apr 2019 11:55:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id 10so4735942lfr.8
        for <linux-arch@vger.kernel.org>; Fri, 05 Apr 2019 08:55:55 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m28sm4928410lfc.54.2019.04.05.08.55.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:55:54 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id f23so5742768ljc.0
        for <linux-arch@vger.kernel.org>; Fri, 05 Apr 2019 08:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Apr 2019 05:55:37 -1000
Message-ID: <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Remove Mysterious Macro Intended to Obscure
 Weird Behaviours (mmiowb())
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405155537.sQrsnd02aVarkQ-IzEwbohxqGP7bpUqjWiOPGrtrs_g@z>

On Fri, Apr 5, 2019 at 3:59 AM Will Deacon <will.deacon@arm.com> wrote:
>
> I've also pushed this series out here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/mmiowb
>
> and I would like to get it into -next once the first patch has been acked.

Ack on it all.

With the afore-mentioned slight worry about non-spinlocked IO
ordering, but I _think_ it's purely limited to ia64 and wmb() and
friends should work elsewhere?

Or did I miss something? I think the ia64() mb/rmb/wmb stuff only
works on normal memory on ia64.

      Linus
