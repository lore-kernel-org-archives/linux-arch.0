Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDXTph (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Apr 2019 15:45:37 -0400
Date: Wed, 24 Apr 2019 21:45:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 18/29] lockdep: Move stack trace logic into
 check_prev_add()
Message-ID: <20190424194505.GR11158@hirez.programming.kicks-ass.net>
References: <20190418084119.056416939@linutronix.de>
 <20190418084254.729689921@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418084254.729689921@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190424194505._4rY7n8LnKeND5iZgXWoPXvnQRM86F7sIVI4Bn1RrCk@z>

On Thu, Apr 18, 2019 at 10:41:37AM +0200, Thomas Gleixner wrote:
> There is only one caller of check_prev_add() which hands in a zeroed struct
> stack trace and a function pointer to save_stack(). Inside check_prev_add()
> the stack_trace struct is checked for being empty, which is always
> true. Based on that one code path stores a stack trace which is unused. The
> comment there does not make sense either. It's all leftovers from
> historical lockdep code (cross release).

I was more or less expecting a revert of:

ce07a9415f26 ("locking/lockdep: Make check_prev_add() able to handle external stack_trace")

And then I read the comment that went with the "static struct
stack_trace trace" that got removed (in the above commit) and realized
that your patch will consume more stack entries.

The problem is when the held lock stack in check_prevs_add() has multple
trylock entries on top, in that case we call check_prev_add() multiple
times, and this patch will then save the exact same stack-trace multiple
times, consuming static resources.

Possibly we should copy what stackdepot does (but we cannot use it
directly because stackdepot uses locks; but possible we can share bits),
but that is a patch for another day I think.

So while convoluted, perhaps we should retain this code for now.
