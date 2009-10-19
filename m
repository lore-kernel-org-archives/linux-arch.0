Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50891 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbZJSFKA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 19 Oct 2009 01:10:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MzkVQ-0007wF-6G
	for linux-arch@vger.kernel.org; Mon, 19 Oct 2009 07:10:04 +0200
Received: from 59.96.63.58 ([59.96.63.58])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-arch@vger.kernel.org>; Mon, 19 Oct 2009 07:10:04 +0200
Received: from harinath by 59.96.63.58 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-arch@vger.kernel.org>; Mon, 19 Oct 2009 07:10:04 +0200
From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [RFC][PATCH 2/4] mm: stack based kmap_atomic
Date: Mon, 19 Oct 2009 08:38:12 +0530
Message-ID: <87tyxw13oj.fsf@hariville.hurrynot.org>
References: <20091008232226.768382977@chello.nl>
	<20091008232528.365592989@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20091019030812.Fj90PTFQjFEg1uHF_Q3kfIaqYE-GZH_X3IxNGDglTzo@z>

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

