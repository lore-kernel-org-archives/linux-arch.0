From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Thu, 8 Jun 2017 07:53:04 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B6FF0E5C7@IRSMSX102.ger.corp.intel.com>
References: <20170608025831.GA43608@beast>
 <20170608065809.GC14568@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608065809.GC14568@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Kees Cook <keescook@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, "arozansk@redhat.com" <arozansk@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, x86@kernel.
List-Id: linux-arch.vger.kernel.org

> On Wed, Jun 07, 2017 at 07:58:31PM -0700, Kees Cook wrote:
> > Many subsystems will not use refcount_t unless there is a way to build the
> > kernel so that there is no regression in speed compared to atomic_t. This
> > adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
> > which has the validation but is slightly slower. When not enabled,
> > refcount_t uses the basic unchecked atomic_t routines, which results in
> > no code changes compared to just using atomic_t directly.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > This is v2 of this patch, which I've split from the arch-specific
> > alternative implementation for x86. Getting this patch in will unblock
> > atomic_t -> refcount_t conversion, and the x86 alternative implementation
> > can be developed in parallel. Changes from v1: use better atomic ops,
> > thanks to Elena and Peter.
> 
> Yeah, can we get this in ASAP?  Without having to always incur the over
> this will allow us to convert subsystems to refcount_t broadly.

+1. If this gets in, I can refresh the rest of the patches in net, mm, ipc, block, etc. and send them for review again. 

Best Regards,
Elena
