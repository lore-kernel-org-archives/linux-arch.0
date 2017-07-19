From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v6 2/2] x86/refcount: Implement fast refcount overflow
 protection
Date: Wed, 19 Jul 2017 18:30:24 -0500
Message-ID: <20170719233024.nt5yr5xoc5woelbk@treble>
References: <1500422614-94821-1-git-send-email-keescook@chromium.org>
 <1500422614-94821-3-git-send-email-keescook@chromium.org>
 <20170719193718.bvkkde5apbboudrk@treble>
 <CAGXu5j+EkpmO2tB71n9rEjb_6GfWza3qBLUDTuhjZwnAYTX5WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932317AbdGSXa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Jul 2017 19:30:28 -0400
Content-Disposition: inline
In-Reply-To: <CAGXu5j+EkpmO2tB71n9rEjb_6GfWza3qBLUDTuhjZwnAYTX5WA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.>

On Wed, Jul 19, 2017 at 04:12:37PM -0700, Kees Cook wrote:
> On Wed, Jul 19, 2017 at 12:37 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > +#define ASM_UNREACHABLE                                                        \
> > +       "999: .pushsection .discard.unreachable\n\t"                    \
> > +       ".long 999b - .\n\t"                                            \
> > +       ".popsection\n\t"
> 
> Will this end up running into the same bug fixed with
> 3d1e236022cc1426b0834565995ddee2ca231cee and the __LINE__ macro? I
> could tell under which conditions gcc would do this kind of merging...

I hope not, but objtool should complain about it if it does.

We could involve the __LINE__ macro, or some other way to make the
labels unique, but that might complicate the code a bit, so we can delay
doing that unless necessary.

-- 
Josh
