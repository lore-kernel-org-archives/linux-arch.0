Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46047 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZTDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 14:03:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id d24so11479538ljc.12
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 11:03:10 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w3sm3707892lfe.18.2019.02.26.11.03.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:03:07 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id v10so11777827lji.3
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 11:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <20190226182624.GC28709@fuggles.cambridge.arm.com> <20190226183335.GN2861@worktop.programming.kicks-ass.net>
In-Reply-To: <20190226183335.GN2861@worktop.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Feb 2019 11:02:50 -0800
Message-ID: <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190226190250.bw4fTGXtwR_v4BHyjz9mj_Qa-B1YP-VUdxdmnFuvsJQ@z>

On Tue, Feb 26, 2019 at 10:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Arguably we could fix that for __this_cpu_xchg(), which isn't IRQ-safe.

Yeah, I guess x86 _should_ really do __this_cpu_xchg() as just a
read-write pair.

In general, a read-write pair is probably always the right thing to
do, and the only reason we can't just do it in an
architecture-independent way is that we'd want to avoid doing the
address generation twice (for architectures where that is an issue).

                  Linus
