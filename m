Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40375 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfLQSEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2019 13:04:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so7614096lfo.7
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:04:49 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a21sm11109926lfg.44.2019.12.17.10.04.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:04:45 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id k8so632729ljh.5
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck>
In-Reply-To: <20191217170719.GA869@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2019 10:04:29 -0800
Message-ID: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20191217180429.Gu1mWY_m0YrlaW1M_GCznb2W4wmlO1rvEn6lURXcQ28@z>

On Tue, Dec 17, 2019 at 9:07 AM Will Deacon <will@kernel.org> wrote:
>
> However, I'm really banging my head against the compiler trying to get
> your trick above to work for pointer types when the pointed-to-type is
> not defined.

You are right, of course. The trick works fine with arithmetic types,
but since it does use arithmetic, it requires that pointer types be
not only declared, but defined. The addition wants the size of the
underlying type (even though with an addition of zero it wouldn't be
required - but that's not how C works).

Let me think about it.

             Linus
