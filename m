From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 2/3] x86/asm: Add suffix macro for GEN_*_RMWcc()
Date: Wed, 31 May 2017 13:13:09 +0200
Message-ID: <20170531111309.3kyfgxu5dkthu2dn@hirez.programming.kicks-ass.net>
References: <1496180392-98718-1-git-send-email-keescook@chromium.org>
 <1496180392-98718-3-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37744 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdEaLNZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2017 07:13:25 -0400
Content-Disposition: inline
In-Reply-To: <1496180392-98718-3-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, PaX Team <pageexec@freemail.hu>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>

On Tue, May 30, 2017 at 02:39:51PM -0700, Kees Cook wrote:
> The coming x86 refcount protection needs to be able to add trailing
> instructions to the GEN_*_RMWcc() operations. This extracts the
> difference between the goto/non-goto cases so the helper macros
> can be defined outside the #ifdef cases. Additionally adds argument
> naming to the resulting asm for referencing from suffixed
> instructions, and adds clobbers for "cc", and "cx" to let suffixes
> use _ASM_CX, and retain any set flags.

Another option is to simply require __GCC_ASM_FLAG_OUTPUT__ for the fast
refcount stuff. That would result in simpler and more readable code.
