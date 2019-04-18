Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbfDRUNs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 16:13:48 -0400
Date: Thu, 18 Apr 2019 16:13:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch V2 20/29] tracing: Simplify stacktrace retrieval in
 histograms
Message-ID: <20190418161342.34f4abca@gandalf.local.home>
In-Reply-To: <014a7564d606b249a5e50bef0fedf266977a935b.camel@linux.intel.com>
References: <20190418084119.056416939@linutronix.de>
        <20190418084254.910579307@linutronix.de>
        <20190418094014.7d457f29@gandalf.local.home>
        <014a7564d606b249a5e50bef0fedf266977a935b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418201342.nvQL3lUydrVJo2RCC-xr2ETOl7S_pRGqd6CsDYweo90@z>

On Thu, 18 Apr 2019 14:58:55 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> > Tom,
> > 
> > Can you review this too?  
> 
> Looks good to me too!
> 
> Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> 

Would you be OK to upgrade this to a Reviewed-by tag?

Thanks!

-- Steve
