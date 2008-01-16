Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38964 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014AbYAPFYU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2008 00:24:20 -0500
Date: Tue, 15 Jan 2008 21:23:57 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <20080115.205152.153390863.davem@davemloft.net>
Message-ID: <alpine.LFD.1.00.0801152119000.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org> <20080116043728.GA7684@wotan.suse.de> <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org> <20080115.205152.153390863.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: npiggin@suse.de, hugh@veritas.com, jaredeh@gmail.com, cotte@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-arch@vger.kernel.org



On Tue, 15 Jan 2008, David Miller wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 15 Jan 2008 20:48:42 -0800 (PST)
> 
> > Can you give a pointer to some browsable archive?
> 
> http://marc.info/?l=linux-arch

.. and the discussion itself that actually explains why ARM has problems 
and why S390 suddenly _does_ have a bit for this after all?

(Not that I consider marc to be really "browsable" in the first place.. )

		Linus
