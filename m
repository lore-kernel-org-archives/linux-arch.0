Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46205 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389754AbfDRT7B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 15:59:01 -0400
Message-ID: <014a7564d606b249a5e50bef0fedf266977a935b.camel@linux.intel.com>
Subject: Re: [patch V2 20/29] tracing: Simplify stacktrace retrieval in
 histograms
From: Tom Zanussi <tom.zanussi@linux.intel.com>
Date: Thu, 18 Apr 2019 14:58:55 -0500
In-Reply-To: <20190418094014.7d457f29@gandalf.local.home>
References: <20190418084119.056416939@linutronix.de>
         <20190418084254.910579307@linutronix.de>
         <20190418094014.7d457f29@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Alexander Potapenko <glider@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arch@vger.kernel.org
Message-ID: <20190418195855.kMzGyrxupua1BFA-5W329nvilax9H3YQbuTHpq4tvV8@z>

On Thu, 2019-04-18 at 09:40 -0400, Steven Rostedt wrote:
> [ Added Tom Zanussi ]
> 
> On Thu, 18 Apr 2019 10:41:39 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > The indirection through struct stack_trace is not necessary at all.
> > Use the
> > storage array based interface.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Looks fine to me
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
>  But...
> 
> Tom,
> 
> Can you review this too?

Looks good to me too!

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>


> 
> Patch series starts here:
> 
>   http://lkml.kernel.org/r/20190418084119.056416939@linutronix.de
> 
> Thanks,
> 
> -- Steve
> 
> > ---
> >  kernel/trace/trace_events_hist.c |   12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -5186,7 +5186,6 @@ static void event_hist_trigger(struct ev
> >  	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
> >  	char compound_key[HIST_KEY_SIZE_MAX];
> >  	struct tracing_map_elt *elt = NULL;
> > -	struct stack_trace stacktrace;
> >  	struct hist_field *key_field;
> >  	u64 field_contents;
> >  	void *key = NULL;
> > @@ -5198,14 +5197,9 @@ static void event_hist_trigger(struct ev
> >  		key_field = hist_data->fields[i];
> >  
> >  		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
> > -			stacktrace.max_entries = HIST_STACKTRACE_DEPTH;
> > -			stacktrace.entries = entries;
> > -			stacktrace.nr_entries = 0;
> > -			stacktrace.skip = HIST_STACKTRACE_SKIP;
> > -
> > -			memset(stacktrace.entries, 0,
> > HIST_STACKTRACE_SIZE);
> > -			save_stack_trace(&stacktrace);
> > -
> > +			memset(entries, 0, HIST_STACKTRACE_SIZE);
> > +			stack_trace_save(entries,
> > HIST_STACKTRACE_DEPTH,
> > +					 HIST_STACKTRACE_SKIP);
> >  			key = entries;
> >  		} else {
> >  			field_contents = key_field->fn(key_field, elt,
> > rbe, rec);
> > 
> 
> 
