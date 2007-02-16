Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:55038 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXBPMRD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Feb 2007 07:17:03 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] killing the NR_IRQS arrays.
Date: Fri, 16 Feb 2007 13:16:41 +0100
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702161316.41237.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>


> I expect the most it makes sense to aim for 2.6.22 are the genirq
> changes so the internal arch code is passing struct irq_desc
> everywhere internally. 

Are there any livetime issues with passing pointers around? 
e.g. what happens on APIC hotunplug etc.? We don't necessarily
support that yet, but for a big interface change it should 
be probably kept in mind first.

-Andi
