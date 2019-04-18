Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfDRVYt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 17:24:49 -0400
Date: Thu, 18 Apr 2019 17:24:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch V2 01/29] tracing: Cleanup stack trace code
Message-ID: <20190418172443.30ec83e3@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1904182313470.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de>
        <20190418084253.142712304@linutronix.de>
        <20190418135721.5vwd6ngxagrrrrtt@treble>
        <alpine.DEB.2.21.1904182313470.3174@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418212443.MLsQBB9Z7Q-Bj_57FVtCWgi2jk6xZQVROJEZqeokrKc@z>

On Thu, 18 Apr 2019 23:14:45 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 18 Apr 2019, Josh Poimboeuf wrote:
> 
> > On Thu, Apr 18, 2019 at 10:41:20AM +0200, Thomas Gleixner wrote:  
> > > - Remove the extra array member of stack_dump_trace[]. It's not required as
> > >   the stack tracer stores at max array size - 1 entries so there is still
> > >   an empty slot.  
> > 
> > What is the empty slot used for?  
> 
> I was trying to find an answer but failed. Maybe it's just historical
> leftovers or Steven knows where the magic is in this maze.
>

I believe it was for historical leftovers (there was a time it was
required), and left there for "paranoid" sake. But let me apply the
patch and see if it is really needed.

-- Steve
