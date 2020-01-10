From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Date: Fri, 10 Jan 2020 12:14:45 -0800
Message-ID: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org> <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41493 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgAJUPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 15:15:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so3390389ljc.8
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 12:15:04 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j22sm1540185lfh.93.2020.01.10.12.15.01
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 12:15:01 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id r14so2428634lfm.5
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 12:15:01 -0800 (PST)
In-Reply-To: <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Fri, Jan 10, 2020 at 11:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Isn't the read_barrier_depends() the only reason for actually needing
> the temporary local variable that must not be volatile?
>
> If you make alpha provide its own READ_ONCE() as the first
> step, it would seem that the rest of the series gets much easier
> as the others can go back to the simple statement from your

Hmm.. The union still would cause that "take the address of a volatile
thing on the stack" problem, wouldn't it? And that was what caused
most of the issues.

I think the _real_ issue is how KASAN forces that odd pair of inline
functions in order to have the annotations on the accesses.

                Linus
