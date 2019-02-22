Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45772 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVVzj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 16:55:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id h10so2808968lfc.12
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 13:55:38 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 21sm704059ljw.95.2019.02.22.13.55.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:55:37 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m11so2836310lfc.6
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 13:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
In-Reply-To: <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Feb 2019 13:55:20 -0800
Message-ID: <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222215520.6_cjo6-NLU5cZUmRuZDIJ7t41qjwYghgPnM4_Yk-T6A@z>

On Fri, Feb 22, 2019 at 1:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The case we want to go fast is the spin-lock and unlock case, not the
> "set pending" case.
>
> And the way you implemented this, it's exactly the wrong way around.

Oh, one more comment: couldn't we make that mmiowb flag be right next
to the preemption count?

Because that's the common case anyway, where a spinlock increments the
preemption count too. If we put the mmiowb state in the same
cacheline, we don't cause extra cache effects, which is what really
matters, I guess.

I realize this is somewhat inconvenient, because some architectures
put preempt count in the thread structure, and others do it as a
percpu variable. But maybe the architecture could just declare where
the mmiowb state is?

                 Linus
