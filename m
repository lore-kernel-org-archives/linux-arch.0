Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfDSAkA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 20:40:00 -0400
Date: Thu, 18 Apr 2019 20:39:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch V2 01/29] tracing: Cleanup stack trace code
Message-ID: <20190418203954.631914cb@oasis.local.home>
In-Reply-To: <alpine.DEB.2.21.1904190040510.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de>
        <20190418084253.142712304@linutronix.de>
        <20190418181938.2e2a9a04@gandalf.local.home>
        <alpine.DEB.2.21.1904190040510.3174@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190419003954.hbjRVNNNEBkPZOM6xbzVezPZOR6k6VnOY4ljzmxlT-o@z>

On Fri, 19 Apr 2019 00:44:17 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 18 Apr 2019, Steven Rostedt wrote:
> > On Thu, 18 Apr 2019 10:41:20 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >   
> > > @@ -412,23 +404,20 @@ stack_trace_sysctl(struct ctl_table *tab
> > >  		   void __user *buffer, size_t *lenp,
> > >  		   loff_t *ppos)
> > >  {
> > > -	int ret;
> > > +	int ret, was_enabled;  
> > 
> > One small nit. Could this be:
> > 
> > 	int was_enabled;
> > 	int ret;
> > 
> > I prefer only joining variables that are related on the same line.
> > Makes it look cleaner IMO.  
> 
> If you wish so. To me it's waste of screen space :)

At least you didn't say it helps the compiler ;-)

> 
> > >  
> > >  	mutex_lock(&stack_sysctl_mutex);
> > > +	was_enabled = !!stack_tracer_enabled;
> > >    
> > 
> > Bah, not sure why I didn't do it this way to begin with. I think I
> > copied something else that couldn't do it this way for some reason and
> > didn't put any brain power behind the copy. :-/ But that was back in
> > 2008 so I blame it on being "young and stupid" ;-)  
> 
> The young part is gone for sure :)

I purposely set you up for that response.

> 
> > Other then the above nit and removing the unneeded +1 in max_entries:  
> 
> s/+1/-1/

That was an ode to G+

-- Steve
