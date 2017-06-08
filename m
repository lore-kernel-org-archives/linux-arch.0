From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Wed, 7 Jun 2017 23:58:09 -0700
Message-ID: <20170608065809.GC14568@infradead.org>
References: <20170608025831.GA43608@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46085 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdFHG6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2017 02:58:13 -0400
Content-Disposition: inline
In-Reply-To: <20170608025831.GA43608@beast>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartner>

On Wed, Jun 07, 2017 at 07:58:31PM -0700, Kees Cook wrote:
> Many subsystems will not use refcount_t unless there is a way to build the
> kernel so that there is no regression in speed compared to atomic_t. This
> adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
> which has the validation but is slightly slower. When not enabled,
> refcount_t uses the basic unchecked atomic_t routines, which results in
> no code changes compared to just using atomic_t directly.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is v2 of this patch, which I've split from the arch-specific
> alternative implementation for x86. Getting this patch in will unblock
> atomic_t -> refcount_t conversion, and the x86 alternative implementation
> can be developed in parallel. Changes from v1: use better atomic ops,
> thanks to Elena and Peter.

Yeah, can we get this in ASAP?  Without having to always incur the over
this will allow us to convert subsystems to refcount_t broadly.
