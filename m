From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 04/10] percpu: make 4k first chunk allocator map memory
Date: Mon, 13 Jul 2009 11:12:53 +0100
Message-ID: <24253.1247479973@redhat.com>
References: <1245850216-31653-5-git-send-email-tj@kernel.org> <1245850216-31653-1-git-send-email-tj@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:38815 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbZGMKV0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2009 06:21:26 -0400
In-Reply-To: <1245850216-31653-5-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de, cl@linux-foundation.org, akpm@linux-foundation.org

Tejun Heo <tj@kernel.org> wrote:

> +	pr_info("PERCPU: %d 4k pages per cpu, static data %zu bytes\n",
> +		pcpu4k_unit_pages, static_size);

It occurs to me that this is may include a bad assumption.  Page size need not
be 4K.  I don't know that it matters, but looking at this:

> +	vm.size = num_possible_cpus() * pcpu4k_unit_pages << PAGE_SHIFT;
> +	vm_area_register_early(&vm, PAGE_SIZE);

It might.

David
