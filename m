Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36997 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHBSy0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2017 14:54:26 -0400
Received: by mail-it0-f49.google.com with SMTP id v127so29591655itd.0
        for <linux-arch@vger.kernel.org>; Wed, 02 Aug 2017 11:54:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725205514.GA71165@beast>
References: <20170725205514.GA71165@beast>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 Aug 2017 11:54:24 -0700
Message-ID: <CAGXu5j+BRkTM3X6NuHoyU4FTs154wQtunOKF2cQDaHKyKNzpFQ@mail.gmail.com>
Subject: Re: [PATCH v9] x86/asm: Implement fast refcount overflow protection
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Message-ID: <20170802185424.tkN24FGsd9Kzlcrect2jw6q8GxjpPOGzp76llNOLsa0@z>

On Tue, Jul 25, 2017 at 1:55 PM, Kees Cook <keescook@chromium.org> wrote:
> This implements refcount_t overflow protection on x86 without a noticeable
> performance impact, though without the fuller checking of REFCOUNT_FULL.
> This is done by duplicating the existing atomic_t refcount implementation
> but with normally a single instruction added to detect if the refcount
> has gone negative (e.g. wrapped past INT_MAX or below zero). When detected,
> the handler saturates the refcount_t to INT_MIN / 2. With this overflow
> protection, the erroneous reference release that would follow a wrap back
> to zero is blocked from happening, avoiding the class of refcount-overflow
> use-after-free vulnerabilities entirely.

Hi Ingo,

Friendly ping. Is there anything remaining for this patch to go into -tip?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
