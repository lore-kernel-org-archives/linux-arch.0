Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbYAPRPe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2008 12:15:34 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080113031013.GD22285@wotan.suse.de>
References: <20080113031013.GD22285@wotan.suse.de> <20080113030810.GB22285@wotan.suse.de>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Date: Wed, 16 Jan 2008 17:14:35 +0000
Message-ID: <16391.1200503675@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:

> Unfortunately, not all architectures can spare a bit in the pte for this. So
> add an ifdefs, depending on whether the arch can support it or not.  Although
> pte_special can remove all restrictions that pfn mappings currently have, we
> continue to enforce those restrictions even on architectures that have the new
> pte bit, for consistency.

FRV has a single bit to spare in its PTEs (xAMPRx_RESERVED13) that you could
use.

MN10300 (which is currently lurking in the -mm tree) has no spare bits unless
I can drop either the PAGE_ACCESSED or PAGE_NX bits.

David
