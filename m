From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [RFC][PATCH 2/4] mm: stack based kmap_atomic
Date: Mon, 19 Oct 2009 08:38:12 +0530
Message-ID: <87tyxw13oj.fsf@hariville.hurrynot.org>
References: <20091008232226.768382977@chello.nl>
	<20091008232528.365592989@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755669AbZJSDjH@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

Peter Zijlstra <a.p.zijlstra@chello.nl> writes:

> @@ -74,7 +76,10 @@ EXPORT_SYMBOL(kmap_atomic);
>  void kunmap_atomic(void *kvaddr, enum km_type type)
>  {
>  	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
> -	unsigned int idx = type + KM_TYPE_NR * smp_processor_id();
> +	unsigned int idx;
> +
> +	type = kmap_atomic_idx_pop();
> +	idx = type + KM_TYPE_NR * smp_processor_id();

Maybe you can avoid the 4/4 patch and preserve clean bisects by renaming
the unused parameter here and elsewhere, and introduce the 'type' local
in this patch.

  void kunmap_atomic(void *kvaddr, enum km_type unused)
  {
    ...
    unsigned int idx, type;
    ...
  }

That way, patch 3/4 will remove a genuinely unused parameter, and thus
remain compile-able.

- Hari
