Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42761 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMWBc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 17:01:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so347122lfl.9
        for <linux-arch@vger.kernel.org>; Fri, 13 Dec 2019 14:01:30 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p18sm5818490ljp.39.2019.12.13.14.01.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 14:01:27 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id m30so350809lfp.8
        for <linux-arch@vger.kernel.org>; Fri, 13 Dec 2019 14:01:26 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com> <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
In-Reply-To: <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Dec 2019 14:01:10 -0800
Message-ID: <CAHk-=wgsN+0i8mF_1L8zDvY0XJEkZNumT1dH0NBiSbecZZ3+HA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20191213220110.J7XVrw1HffTqv_FWiyS_lZs9-YCmcJCDQeU14tnymjQ@z>

On Fri, Dec 13, 2019 at 1:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> A few hundred randconfig (x86, arm32 and arm64) builds later I
> still only found one other instance:

Just send me the pull request to READ_ONCE() and WRITE_ONCE() be
arithmetic types, and your two trivial fixes, and let's get this over
with.

With that, you can remove the 'volatile' with my simple
'typeof(0+*(p))' trick, and we're all good, and we don't need to worry
about compiler versions either.

I'm willing to take that after the merge window as a "sanity fix".

             Linus
