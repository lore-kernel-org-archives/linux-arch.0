Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:37709 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbdGSXMj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jul 2017 19:12:39 -0400
Received: by mail-io0-f175.google.com with SMTP id c74so5848011iod.4
        for <linux-arch@vger.kernel.org>; Wed, 19 Jul 2017 16:12:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719193718.bvkkde5apbboudrk@treble>
References: <1500422614-94821-1-git-send-email-keescook@chromium.org>
 <1500422614-94821-3-git-send-email-keescook@chromium.org> <20170719193718.bvkkde5apbboudrk@treble>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 19 Jul 2017 16:12:37 -0700
Message-ID: <CAGXu5j+EkpmO2tB71n9rEjb_6GfWza3qBLUDTuhjZwnAYTX5WA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] x86/refcount: Implement fast refcount overflow protection
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Message-ID: <20170719231237.GXwWwpfAvWbduLx33_InjAppkpVzIsJAcdQQfmT-1HU@z>

On Wed, Jul 19, 2017 at 12:37 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> +#define ASM_UNREACHABLE                                                        \
> +       "999: .pushsection .discard.unreachable\n\t"                    \
> +       ".long 999b - .\n\t"                                            \
> +       ".popsection\n\t"

Will this end up running into the same bug fixed with
3d1e236022cc1426b0834565995ddee2ca231cee and the __LINE__ macro? I
could tell under which conditions gcc would do this kind of merging...

-Kees

-- 
Kees Cook
Pixel Security
