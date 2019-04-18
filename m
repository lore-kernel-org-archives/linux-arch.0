Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39157 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbfDRVP2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 17:15:28 -0400
Date: Thu, 18 Apr 2019 23:14:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 01/29] tracing: Cleanup stack trace code
In-Reply-To: <20190418135721.5vwd6ngxagrrrrtt@treble>
Message-ID: <alpine.DEB.2.21.1904182313470.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de> <20190418084253.142712304@linutronix.de> <20190418135721.5vwd6ngxagrrrrtt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418211445.TYaDd7NXS1MIxuAVBW2Od_uvkEe95IYkuD2qRnwMfIY@z>

On Thu, 18 Apr 2019, Josh Poimboeuf wrote:

> On Thu, Apr 18, 2019 at 10:41:20AM +0200, Thomas Gleixner wrote:
> > - Remove the extra array member of stack_dump_trace[]. It's not required as
> >   the stack tracer stores at max array size - 1 entries so there is still
> >   an empty slot.
> 
> What is the empty slot used for?

I was trying to find an answer but failed. Maybe it's just historical
leftovers or Steven knows where the magic is in this maze.

Thanks,

	tglx
