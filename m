From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Date: Wed, 4 Sep 2019 09:50:06 -0700
Message-ID: <201909040942.7BC809C5E@keescook>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
 <201908292224.007EB4D5@keescook>
 <20190830083415.GI27757@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830083415.GI27757@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 30, 2019 at 09:34:18AM +0100, Dave Martin wrote:
> Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> early-terminate the scan if we can, but my feeling so far was that the
> scan is cheap, the number of properties is unlikely to be more than a
> smallish integer, and the code separation benefits of just calling the
> arch code for every property probably likely outweigh the costs of
> having to iterate over every property.  We could always optimise it
> later if necessary.

I feel like there are already a lot of ways to burn CPU time with
mangled ELF files, so this potential inefficiently doesn't seem bad to
me. If we want to add limits here, perhaps cap the property scan depth
(right now, IIRC, the count is u32, which is big...)

> I need to double-check that there's no way we can get stuck in an
> infinite loop with the current code, though I've not seen it in my
> testing.  I should throw some malformed notes at it though.

I think the cursor only performs forward movement, yes? I didn't see a
loop, but maybe there's something with the program headers that I
missed.

> Do you have any objection to merging patch 1 with this one?  For
> upstreaming purposes, it seems overkill for that to be a separate patch.

I don't _object_ to it, but I did like having it separate for review.

> Do you have any opinion on the WARN_ON()s?  They should be un-hittable,
> so they're documenting assumptions rather than protecting against
> anything real.  Maybe I should replace them with comments.

I think they're fine as self-documentation. My rule of thumb has been:

- don't use BUG*() unless you can defend it to Linus who wants 0 BUG()s.
- don't use WARN*() if userspace can reach it (and if you're not sure,
  use the WARN*ONCE() version)
- use pr_*_ratelimited() if unprivileged userspace can reach it.

-- 
Kees Cook
