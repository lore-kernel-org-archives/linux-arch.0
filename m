Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:45198 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbYB0N1Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Feb 2008 08:27:25 -0500
Date: Wed, 27 Feb 2008 14:27:13 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [rfc][patch] x86-64 new smp_call_function design
Message-ID: <20080227132713.GA13681@elte.hu>
References: <20080227124217.GA1340@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080227124217.GA1340@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org


* Nick Piggin <npiggin@suse.de> wrote:

> This isn't finished yet, however I'd just like to ask for comments.

looks really interesting!

only one fundamental observation:

> +struct call_data {
> +	spinlock_t lock;
> +	struct list_head list;
>  	void (*func) (void *info);
>  	void *info;
> +	unsigned int flags;
> +	unsigned int refs;
> +	cpumask_t cpumask;
> +	struct rcu_head rcu_head;
>  };

> +struct call_single_data {
> +	struct list_head list;
> +	void (*func) (void *info);
> +	void *info;
> +	unsigned int flags;
> +};

the two structures are quite similar in size and role - why not have a 
type field and handle them largely together? I think we should try to 
preserve a single queue and a single vector - that would remove a number 
of ugly special-cases from the patch.

	Ingo
