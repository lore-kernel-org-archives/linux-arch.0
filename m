Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdFHF5B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2017 01:57:01 -0400
Date: Thu, 8 Jun 2017 07:56:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
Message-ID: <20170608055655.GB19269@kroah.com>
References: <20170608025831.GA43608@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608025831.GA43608@beast>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170608055655.738y8FkYJ0lgcU12r29iUiUA8HhZw9aRJedjcDguBMo@z>

On Wed, Jun 07, 2017 at 07:58:31PM -0700, Kees Cook wrote:
> Many subsystems will not use refcount_t unless there is a way to build the
> kernel so that there is no regression in speed compared to atomic_t. This
> adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
> which has the validation but is slightly slower. When not enabled,
> refcount_t uses the basic unchecked atomic_t routines, which results in
> no code changes compared to just using atomic_t directly.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
