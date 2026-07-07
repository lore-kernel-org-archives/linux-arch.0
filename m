Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53C3A8723
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2026 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406139; cv=none; b=YUWhVu2WQwNPcqUrnP8OHClQfdN0ZrtA3XoA58e2PEjKyNOpNkpJSBAF5Qctah2+mzDlestIsb9d5l5/4D7ttE+7d3x/Mbyd7cEzxLxbbIuQEwL/u2Nw8txtcqNrEP8zTkplcDbJMviTikwiU/VVQUXeLabUVgkIseYizDJipio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406139; c=relaxed/simple;
	bh=7KByo2k1jRw+/UfuG46eqR9zMJ28BsbJ7X4nn1mfw9E=;
	h=Date:References:In-Reply-To:Content-Type:From:Mime-Version:
	 Subject:Message-Id:To:Cc; b=dF4B7cOHS/1qPiC/T1IY7wSKXJAuMj2ypvzOeaD+rPz5CZS1oveFmInU9GGQqnnhe/TjYqWtlShv83GH35FJ1p9g6rLBGhse+um3xd3OSPxhfQSSKB/3133p7WkaOeW64knZEbh//wEi+uvHAYiRlsAr/ppWYYzXK0RJW2HEcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IQ5QUc3w; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IQ5QUc3w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783406132; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PEQ1AygSkZ1h9ZNMH4VmEmsGwkTKSxKVM+P1NAp7kx8=;
 b=IQ5QUc3wr4fVtMTlv/Uqgj+nRUEu3jW9E5tGtaWt1c/ywCJ8zD0DcEqw5vSENTtUIHKY9P
 sF1sJW7erCV2Z0I+IU1sT36YyE0nZNLPszJaQuAREbVgPzRENenmrJz0hwtUFk5WnujSWC
 Kze1OgNz970BuhylOagOEcbk+HjLw+ESoP7QXpmU4TkQTmYOszv3KBnKKGpjCIi30pnh/F
 3m9aWL6iu1Ow00cf/g3D6obk6kvz5HcDavea0Mw/Lq/HAMjpz9qEe/rZGLuXOmbr3SdP39
 EO2SlAfC8WaLbz+AaRJWsjS7kSM5d+JaPGaglM0wPRSbhxQF6WmteksMpr5VIQ==
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Tue,  7 Jul 2026 14:35:07 +0800
References: <akxc3nMedKYo7Xdv@nvdebian.thelocal>
In-Reply-To: <akxc3nMedKYo7Xdv@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a4c9e32+e26402+vger.kernel.org+lizhe.67@bytedance.com>
Subject: Re: [PATCH v4 0/8] mm: speed up ZONE_DEVICE memmap initialization
Message-Id: <20260707063507.40206-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
To: <apopple@nvidia.com>
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>

On Tue, 7 Jul 2026 12:12:02 +1000, apopple@nvidia.com wrote:

> On 2026-06-05 at 19:52 +1000, Li Zhe <lizhe.67@bytedance.com> wrote...
> > On Thu, 4 Jun 2026 18:14:05 +1000, apopple@nvidia.com wrote:
> >
> > > On 2026-06-03 at 18:01 +1000, Li Zhe <lizhe.67@bytedance.com> wrote...
> > > > memmap_init_zone_device() can spend a substantial amount of time
> > > > initializing large ZONE_DEVICE ranges because it repeats nearly
> > > > identical struct page setup for every PFN.
> > > >
> > > > This series reduces that overhead in eight steps.
> > > >
> > > > The first patch fixes a stale comment in __init_zone_device_page() so
> > > > the documented refcount policy matches the current ZONE_DEVICE code.
> > > >
> > > > The second patch factors the reusable pieces out of
> > > > __init_zone_device_page() so later patches can share the same logic
> > > > without changing the existing slow path.
> > > >
> > > > The third patch adds set_page_section_from_pfn(), so callers that want
> > > > to refresh section bits from a PFN no longer need to open-code
> > > > SECTION_IN_PAGE_FLAGS handling.
> > > >
> > > > The fourth patch adds a template-based fast path for ZONE_DEVICE head
> > > > pages. Instead of rebuilding the same struct page state for every PFN,
> > > > it prepares one reusable template through the existing slow path,
> > > > refreshes the PFN-dependent fields in that template, and copies it to
> > > > each destination page.
> > > >
> > > > The fifth patch extends the same template-based approach to compound
> > > > tails, so pfns_per_compound > 1 can also benefit from the fast path.
> > > >
> > > > The sixth patch introduces memcpy_streaming() and
> > > > memcpy_streaming_drain() as a generic interface for write-once copies.
> > > > Architectures that do not provide a specialized backend, or cases that
> > > > cannot safely use one, fall back to memcpy().
> > > >
> > > > The seventh patch extends x86 memcpy_flushcache() small fixed-size
> > > > fastpaths so struct-page-sized streaming copies can stay on the inline
> > > > path when alignment permits.
> > > >
> > > > The last patch switches the ZONE_DEVICE template-copy path over to
> > > > memcpy_streaming(). It keeps pageblock-aligned PFNs on regular memcpy(),
> > > > uses memcpy_streaming() for the remaining write-once copies, and drains
> > > > streaming stores before later metadata updates that may depend on them.
> > > >
> > > > This is not intended as a steady-state data-path optimization. Its
> > > > benefit is in pmem bring-up paths where memmap_init_zone_device()
> > > > dominates device online / rebind latency, such as:
> > > >   - fsdax or devdax namespace creation and reconfiguration
> > > >   - nd_pmem / dax_pmem driver bind or rebind
> > > >
> > > > In those paths, the kernel initializes a large vmemmap range once and
> > > > does not immediately benefit from keeping the copied struct page state
> > > > hot in cache. Reducing write-allocate traffic in that one-time setup
> > > > path can therefore reduce end-to-end device bring-up latency.
> > > >
> > > > The optimized path is disabled when the page_ref_set tracepoint is
> > > > enabled, and sanitized builds remain on the slow path so their
> > > > instrumented stores are preserved.
> > > >
> > > > Testing
> > > > =======
> > > >
> > > > Tests were run in a VM on an Intel Ice Lake server.
> > > >
> > > > Two PMEM configurations were used:
> > > >   - a 100 GB fsdax namespace configured with map=dev, which exercises
> > > >     the nd_pmem rebind path (pfns_per_compound == 1)
> > > >   - a 100 GB devdax namespace configured with align=2097152, which
> > > >     exercises the dax_pmem rebind path (pfns_per_compound > 1)
> > > >
> > > > For each configuration, the corresponding driver was unbound and
> > > > rebound 30 times. Memmap initialization latency was collected from the
> > > > pr_debug() output of memmap_init_zone_device().
> > > >
> > > > The first bind is reported separately, and the average of subsequent
> > > > rebinds is used as the steady-state result.
> > > >
> > > > Performance
> > > > ===========
> > > >
> > > > nd_pmem rebind, 100 GB fsdax namespace, map=dev
> > > >   Base(v7.1-rc6):
> > > >     First binding: 1466 ms
> > > >     Average of subsequent rebinds: 262.12 ms
> > > >   Full series:
> > > >     First binding: 1359 ms
> > > >     Average of subsequent rebinds: 108.36 ms
> > > >
> > > > dax_pmem rebind, 100 GB devdax namespace, align=2097152
> > > >   Base(v7.1-rc6):
> > > >     First binding: 1430 ms
> > > >     Average of subsequent rebinds: 229.12 ms
> > > >   Full series:
> > > >     First binding: 1273 ms
> > > >     Average of subsequent rebinds: 100.17 ms
> > >
> > > The results here are impressive, but I've been having trouble replicating them
> > > with hmm_test on my local development machines. Both an older AMD machine and
> > > a newer Arrow Lake based machine shows ~3% worse performance with this series
> > > applied doing ZONE_DEVICE_PRIVATE.
> > >
> > > This is based on measuring the memremap_pages() call when inserting test_hmm.ko
> > > in a VM using the following hack to measure 10 64GB memremaps. Is there an easy
> > > way for me to replicate your results in a VM? Or is there something in my
> > > testing that I'm missing here?
> > >
> > > ---
> > >
> > > diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> > > index 213504915737..a1d5463dbc86 100644
> > > --- a/lib/test_hmm.c
> > > +++ b/lib/test_hmm.c
> > > @@ -34,7 +34,7 @@
> > >
> > >  #define DMIRROR_NDEVICES		4
> > >  #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
> > > -#define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
> > > +#define DEVMEM_CHUNK_SIZE		(64 * 1024 * 1024 * 1024UL)
> > >  #define DEVMEM_CHUNKS_RESERVE		16
> > >
> > >  /*
> > > @@ -565,6 +565,8 @@ static int dmirror_allocate_chunk(struct dmirror_device *mdevice,
> > >  	unsigned long pfn_last;
> > >  	void *ptr;
> > >  	int ret = -ENOMEM;
> > > +	int i;
> > > +	u64 t0, total = 0;
> > >
> > >  	devmem = kzalloc_obj(*devmem);
> > >  	if (!devmem)
> > > @@ -613,6 +615,22 @@ static int dmirror_allocate_chunk(struct dmirror_device *mdevice,
> > >  		mdevice->devmem_capacity = new_capacity;
> > >  		mdevice->devmem_chunks = new_chunks;
> > >  	}
> > > +
> > > +	for (i = 0; i < 10; i++) {
> > > +		t0 = ktime_get_ns();
> > > +		ptr = memremap_pages(&devmem->pagemap, numa_node_id());
> > > +		total += ktime_get_ns() - t0;
> > > +		if (IS_ERR_OR_NULL(ptr)) {
> > > +			if (ptr)
> > > +				ret = PTR_ERR(ptr);
> > > +			else
> > > +				ret = -EFAULT;
> > > +			goto err_release;
> > > +		}
> > > +		memunmap_pages(&devmem->pagemap);
> > > +	}
> > > +	pr_info("avg memremap %llu ns\n", total / i);
> > > +
> > >  	ptr = memremap_pages(&devmem->pagemap, numa_node_id());
> > >  	if (IS_ERR_OR_NULL(ptr)) {
> > >  		if (ptr)
> > > @@ -629,7 +647,7 @@ static int dmirror_allocate_chunk(struct dmirror_device *mdevice,
> > >
> > >  	mutex_unlock(&mdevice->devmem_lock);
> > >
> > > -	pr_info("added new %u MB chunk (total %u chunks, %u MB) PFNs [0x%lx 0x%lx)\n",
> > > +	pr_info("added new %lu MB chunk (total %u chunks, %lu MB) PFNs [0x%lx 0x%lx)\n",
> > >  		DEVMEM_CHUNK_SIZE / (1024 * 1024),
> > >  		mdevice->devmem_count,
> > >  		mdevice->devmem_count * (DEVMEM_CHUNK_SIZE / (1024 * 1024)),
> >
> > Thanks for the feedback and for sharing your test results.
> 
> Sorry for the delay, this got lost in my inbox.
> 
> > I reran the measurements on my side using two setups. I do not
> > currently have access to physical PMEM hardware on my side, and the
> > target use case for this work is a virtualized environment. So my
> > measurements were taken in a guest using a 100G emulated pmem device
> > backed by a regular file on the host filesystem.
> >
> > First, I followed your modified test_hmm.c approach, i.e. looping
> > over memremap_pages() / memunmap_pages() and measuring the average
> > memremap time in the MEMORY_DEVICE_PRIVATE case, where the vmemmap
> > backing comes from normal system RAM. On this setup, I got:
> >
> > - base kernel: avg memremap 222.0 ms
> > - patches 1-5 only: avg memremap 206.9 ms
> > - full 8-patch series: avg memremap 264.1 ms
> >
> > I also enabled the pr_debug() timing inside memmap_init_zone_device()
> > for the same setup, and the numbers tracked that closely:
> >
> > - base kernel: 221.0 ms
> > - patches 1-5 only: 206.0 ms
> > - full 8-patch series: 260.1 ms
> >
> > So on this path, patches 1-5 seem to help, but the full 8-patch series
> > does not.
> 
> Interesting. Thanks for replicating my testing, it's good to have confirmation.
> 
> > Second, I also tested a benchmark-only setup corresponding to the
> > FS_DAX map=dev case, where the memmap itself is allocated from the dax
> > altmap range rather than normal DRAM. On that setup, I got:
> >
> > - base kernel: avg memremap 200.8 ms, pr_debug 196.4 ms
> > - full 8-patch series: avg memremap 117.2 ms, pr_debug 113.5 ms
> >
> > So on my side, the full series shows a clear gain in the
> > FS_DAX + altmap case, but not in the MEMORY_DEVICE_PRIVATE / DRAM-backed
> > vmemmap case.
> >
> > If convenient, could you also try the same kind of measurement from my
> > cover letter, or at least enable the pr_debug() in
> > memmap_init_zone_device(), to check whether the delta is visible there
> > on your setup as well?
> 
> Will do.
> 
> > Also, if you have time, could you please try your modified test_hmm.c
> > setup with patches 1-5 only? On my side that configuration still shows
> > a measurable improvement.
> 
> Unfortunately I'm unlikely to get time this week or next, but I will try.
> 
> > Given these results, I would also appreciate your advice on how best
> > to evolve the series. My current understanding is that patches 1-5 are
> > a more generic optimization, while patches 6-8 are only beneficial in
> > some cases. Do you think patches 1-5 alone would already be a
> > reasonable candidate for upstreaming?
> 
> I'm looking at v5 now, but they generally seemed like a nice clean-up overall
> anyway so should be ok to upstream.
> 
> > For patches 6-8, I am not yet sure what the right direction is. Would
> > it make more sense to expose some explicit opt-in mechanism so that
> > the movnti-based path is selected only when desired, or does it make
> > more sense to use that path unconditionally for FS_DAX map=dev case?
> 
> I think it's better to keep things simple and do it unconditionally - even if it
> sometimes results in a small (~3%) degredation for the DEVICE_PRIVATE/COHERENT
> cases I think that's an ok cost to pay as these are typically only initialised
> once at driver load.
> 
> > I would also be interested in your view on why the FS_DAX + altmap
> > case shows a large gain while the DRAM-backed vmemmap case shows a
> > regression with the full series. I do not think I fully understand
> > that difference yet.
> 
> I'm not familiar with the hardware used here but I wonder if it's simply that
> the performance difference between movnti vs. mov is much greater for pmem
> backed memory rather than DRAM? In other words this only shows real benefits for
> altmap+pmem and doesn't make much difference for DRAM?

Thanks for following up on this. I later reran the same test_hmm-style
measurement on a physical x86_64 host, and the results were positive
there as well. I also added those physical-host results to the v5 cover
letter together with the fsdax/devdax measurements.

I still do not have a firm explanation for why the earlier VM results on
that path were not as good, but the physical-host measurements were
stable and consistently positive on my side, so I am inclined to trust
those results more for this target workload. Given that, please do not
feel you need to spend more time on additional testing for this from my
side.

Thanks,
Zhe
