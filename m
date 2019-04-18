Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfDRVu1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 17:50:27 -0400
Date: Thu, 18 Apr 2019 17:50:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch V2 01/29] tracing: Cleanup stack trace code
Message-ID: <20190418175022.4e222d07@gandalf.local.home>
In-Reply-To: <20190418172443.30ec83e3@gandalf.local.home>
References: <20190418084119.056416939@linutronix.de>
        <20190418084253.142712304@linutronix.de>
        <20190418135721.5vwd6ngxagrrrrtt@treble>
        <alpine.DEB.2.21.1904182313470.3174@nanos.tec.linutronix.de>
        <20190418172443.30ec83e3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418215022.fLVhUjcX5_orQg2-4kpuUzQDUgb3T9cc9W4todDT2i0@z>

On Thu, 18 Apr 2019 17:24:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I believe it was for historical leftovers (there was a time it was
> required), and left there for "paranoid" sake. But let me apply the
> patch and see if it is really needed.

I removed the +1 on the max_entries and set SET_TRACE_ENTRIES to 5 (a
bit extreme). Then I ran the stack tracing with KASAN enabled and it
never complained.

As stated, it was there for historical reasons and I felt 500 was way
more than enough and left the buffer there just out of laziness and
paranoia.

Feel free to remove that if you want.

-- Steve
