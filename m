Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfDRPqf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 11:46:35 -0400
Date: Thu, 18 Apr 2019 11:46:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch V2 21/29] tracing: Use percpu stack trace buffer more
 intelligently
Message-ID: <20190418114629.023b63d7@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1904181743270.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de>
        <20190418084254.999521114@linutronix.de>
        <20190418105334.5093528d@gandalf.local.home>
        <alpine.DEB.2.21.1904181743270.3174@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418154629.BMo27cb3IoiS4O3GQ_jjJXFbmJuKs7S5613tv1tohoQ@z>

On Thu, 18 Apr 2019 17:43:59 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 18 Apr 2019, Steven Rostedt wrote:
> > On Thu, 18 Apr 2019 10:41:40 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> > > -static DEFINE_PER_CPU(struct ftrace_stack, ftrace_stack);
> > > +/* This allows 8 level nesting which is plenty */  
> > 
> > Can we make this 4 level nesting and increase the size? (I can see us
> > going more than 64 deep, kernel developers never cease to amaze me ;-)
> > That's all we need:
> > 
> >  Context: Normal, softirq, irq, NMI
> > 
> > Is there any other way to nest?  
> 
> Not that I know, but you are the tracer dude :)
>

There's other places I only test 4 deep, so it should be fine to limit
it to 4 then.

Thanks!

-- Steve
