Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41976 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbYB0PCT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Feb 2008 10:02:19 -0500
Date: Wed, 27 Feb 2008 16:02:10 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [rfc][patch] x86-64 new smp_call_function design
Message-ID: <20080227150210.GA21610@elte.hu>
References: <20080227124217.GA1340@wotan.suse.de> <20080227132713.GA13681@elte.hu> <20080227135041.GC1340@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080227135041.GC1340@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org


* Nick Piggin <npiggin@suse.de> wrote:

> > the two structures are quite similar in size and role - why not have 
> > a type field and handle them largely together? I think we should try 
> > to preserve a single queue and a single vector - that would remove a 
> > number of ugly special-cases from the patch.
> 
> A single queue will kill one of the big fundamental scalability 
> improvements of the call_single. That's the problem.

hm, indeed. Then how about the other way around: couldnt the normal 
all-cpus SMP function call be implemented transparently via using 
smp_call_single() calls? The vector duplication is really ugly and feels 
wrong.

	Ingo
