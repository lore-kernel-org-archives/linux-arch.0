Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfBYMMx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Feb 2019 07:12:53 -0500
Date: Mon, 25 Feb 2019 12:12:46 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 08/20] m68k: io: Remove useless definition of mmiowb()
Message-ID: <20190225121246.GB17076@fuggles.cambridge.arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-9-will.deacon@arm.com>
 <CAMuHMdXq5N1e+=dTPUu+AtSgh4QzuDzmhBowG_HFoVHwmndvkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXq5N1e+=dTPUu+AtSgh4QzuDzmhBowG_HFoVHwmndvkg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Linux/m68k <linux-m68k@vger.kernel.org>
Message-ID: <20190225121246.HyYZsWf5XYQbmObBGQ4PRNRhziZHs6Zw1yOMtdhY_6I@z>

On Mon, Feb 25, 2019 at 10:25:52AM +0100, Geert Uytterhoeven wrote:
> On Fri, Feb 22, 2019 at 7:51 PM Will Deacon <will.deacon@arm.com> wrote:
> > m68k includes asm-generic/io.h, which provides a dummy definition of
> > mmiowb() if one isn't already provided by the architecture.
> >
> > Remove the useless definition.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks!
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Do you want me to queue this in the m68k tree for v5.2, or would
> you prefer to apply the whole series?
> In case of the latter:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Cheers, Geert! For now, I think it's best to keep all the patches together
since I anticipate a few rounds of rework before I have a good idea about
what the final series will look like.

Will
