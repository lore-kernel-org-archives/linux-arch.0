Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14877 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755114AbYC1VST convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Mar 2008 17:18:19 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: down_spin() implementation
Date: Fri, 28 Mar 2008 14:16:55 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843ECF237C0@orsmsx424.amr.corp.intel.com>
In-reply-to: <20080328124517.GQ16721@parisc-linux.org>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <1FE6DD409037234FAB833C420AA843ECE9EB1C@orsmsx424.amr.corp.intel.com> <20080327141508.GL16721@parisc-linux.org> <200803281101.25037.nickpiggin@yahoo.com.au> <20080328124517.GQ16721@parisc-linux.org>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20080328211655.LokatlyhiqbR0S_TmSGiFvD5Z0UKJNoteqae1Nadlak@z>

> So it makes little sense to add this to semaphores.  Better to introduce
> a spinaphore, as you say.

> struct {
>   atomic_t cur;
>   int max;
> } ss_t;

Could this API sneak into the bottom of one or the other of
linux/include/{spinlock,semaphore}.h ... or should it get its own
spinaphore.h file?

Or should I follow Alan's earlier advice and keep this as an ia64
only thing (since I'll be the only user).

-Tony
