From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
Date: Wed, 22 Jul 2009 09:09:34 +0100
Message-ID: <23069.1248250174@redhat.com>
References: <1248241468.27348.47.camel@pasglop>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:45861 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755916AbZGVIKP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jul 2009 04:10:15 -0400
In-Reply-To: <1248241468.27348.47.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Linux Arch list <linux-arch@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Martin Schwidefsky compile tested on s390 and Michael Ellerman did some
> test builds on ia64, arm, sparc32, sparc64, i386 and x86_64
> 
> Nobody else reacted.

I did tests for MN10300 and FRV.

David
