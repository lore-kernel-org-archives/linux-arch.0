Return-Path: <SRS0=BI31=6F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729590AbgDUSnS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 14:43:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC4DC061BD3
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:43:17 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m2so11935799lfo.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:43:17 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u13sm2685155lji.27.2020.04.21.11.43.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 11:43:13 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id m2so11935657lfo.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200421151537.19241-1-will@kernel.org>
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Apr 2020 11:42:56 -0700
Message-ID: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <20200421184256.acn9BNOrNkoN-3A8SxfnDs8BE-aLObqE33FLtZ7kVGc@z>

On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
>
> It's me again. This is version four of the READ_ONCE() codegen improvement
> patches [...]

Let's just plan on biting the bullet and do this for 5.8. I'm assuming
that I'll juet get a pull request from you?

> (I'm interpreting the silence as monumental joy)

By now I think we can take that for granted.

Because "monumental joy" is certainly exactly what I felt re-reading
that "unqualified scalar type" macro.

Or maybe it was just my breakfast trying to say "Hi!".

                 Linus
