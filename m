Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35795 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbfDRL7h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Apr 2019 07:59:37 -0400
Date: Thu, 18 Apr 2019 13:58:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 03/29] lib/stackdepot: Provide functions which operate
 on plain storage arrays
In-Reply-To: <20190418115152.GA13304@rapoport-lnx>
Message-ID: <alpine.DEB.2.21.1904181358030.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de> <20190418084253.337266121@linutronix.de> <20190418115152.GA13304@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418115845.WkO4WyXaSXD6Vlz5wSRCkdICpw1_h17dN3ocTbbAy7c@z>

On Thu, 18 Apr 2019, Mike Rapoport wrote:
> On Thu, Apr 18, 2019 at 10:41:22AM +0200, Thomas Gleixner wrote:
> > 
> > -void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
> > +/**
> > + * stack_depot_fetch - Fetch stack entries from a depot
> > + *
> 
> Nit: kernel-doc will complain about missing description of @handle.

Duh.

> > + * @entries:		Pointer to store the entries address
> > + */
> 
> Can you please s/Returns/Return:/ so that kernel-doc will recognize this as
> return section.

Sure thing.

Thanks,

	tglx
