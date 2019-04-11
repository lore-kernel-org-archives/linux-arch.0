Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38480 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDKWex (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Apr 2019 18:34:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so7019094ljg.5
        for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2019 15:34:52 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j27sm7741774lfk.97.2019.04.11.15.34.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:34:49 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id u17so5948261lfi.3
        for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2019 15:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-2-will.deacon@arm.com>
 <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
In-Reply-To: <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2019 15:34:33 -0700
Message-ID: <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190411223433.EPcyGz3u1la9YfN0SvlJwIjJW0GifOZ1XTIsP0z6VMo@z>

On Thu, Apr 11, 2019 at 3:13 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Minor nit... I would have said "All readX() and writeX() accesses _from
> the same CPU_ to the same peripheral... and then s/the CPU/this CPU.

Maybe talk about "same thread" rather than "same cpu", with the
understanding that scheduling/preemption has to include the
appropriate cross-CPU IO barrier?

                   Linus
