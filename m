Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:60899 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbXBPMu1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Feb 2007 07:50:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1HI2Xh-00045B-I6
	from <mingo@elte.hu>
	for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2007 13:50:25 +0100
Date: Fri, 16 Feb 2007 13:41:17 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] killing the NR_IRQS arrays.
Message-ID: <20070216124117.GB4218@elte.hu>
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> So I propose we remove all assumptions from the code that we actually 
> have an array of irqs.  That will allow for irq_desc to be dynamically 
> allocated instead of statically allocated saving memory and reducing 
> kernel complexity.

hm. I'd suggest to do this without changing request_irq() - and then we 
could avoid the 'massive, every driver affected' change, right?

i.e. because we'll (have to) have an nr_to_desc() and desc_to_nr() 
mapping facility anyway, lets just not change the driver APIs massively. 
There dont seem to be that many drivers that assume that irq_desc[] is 
an array - are there?

otherwise, in terms of the irqchips infrastructure and the API between 
genirq and the irqchip arch-level drivers, this change makes quite a bit 
of sense i think.

or am i missing something fundamental?

	Ingo
