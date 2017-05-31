From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v5 0/3] Implement fast refcount overflow protection
Date: Wed, 31 May 2017 05:27:32 -0700
Message-ID: <20170531122732.GA24923@linux-80c1.suse>
References: <1496180392-98718-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57535 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751090AbdEaM1w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 May 2017 08:27:52 -0400
Content-Disposition: inline
In-Reply-To: <1496180392-98718-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, PaX Team <pageexec@freemail.hu>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>

On Tue, 30 May 2017, Kees Cook wrote:

>A new patch has been added at the start of this series to make the default
>refcount_t implementation just use an unchecked atomic_t implementation,
>since many kernel subsystems want to be able to opt out of the full
>validation, since it includes a small performance overhead. When enabling
>CONFIG_REFCOUNT_FULL, the full validation is used.
>
>The other two patches provide overflow protection on x86 without incurring
>a performance penalty. The changelog for patch 3 is reproduced here for
>details:

To be sure I'm getting this right, after this all archs with the exception
of x86 will use the regular atomic_t ("unsecure") flavor, right?

Thanks,
Davidlohr
