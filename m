Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54996 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKLBB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Apr 2019 07:01:01 -0400
Date: Thu, 11 Apr 2019 13:00:56 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190411110056.GA3894@gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
 <20190410105833.GA116161@gmail.com>
 <20190410122834.GB21169@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410122834.GB21169@fuggles.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190411110056.-odAM9CpyJc6XX03yDUp3-3V2UEIAy9doIeKaN-g3Ic@z>


* Will Deacon <will.deacon@arm.com> wrote:

> Anyway, please take a look at the diff below and let me know if you're
> happy with it. The original commit is currently at the bottom of my mmiowb
> tree, so I'll probably put this on top as an extra commit with your
> Reported-by.

Sure - and the changes look good to me:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
