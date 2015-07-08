Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:48841 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933838AbbGHVRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2015 17:17:52 -0400
Date: Wed, 8 Jul 2015 15:17:50 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V3 3/5] mm: mlock: Introduce VM_LOCKONFAULT and add
 mlock flags to enable it
Message-ID: <20150708151750.75e65859@lwn.net>
In-Reply-To: <20150708203456.GC4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
	<1436288623-13007-4-git-send-email-emunson@akamai.com>
	<20150708132351.61c13db6@lwn.net>
	<20150708203456.GC4669@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150708211750.y-FcS0kBKBNcGvIiMT0BPr-gRrrCrai25IoZzIbzGg0@z>

On Wed, 8 Jul 2015 16:34:56 -0400
Eric B Munson <emunson@akamai.com> wrote:

> > Quick, possibly dumb question: I've been beating my head against these for
> > a little bit, and I can't figure out what's supposed to happen in this
> > case:
> > 
> > 	mlock2(addr, len, MLOCK_ONFAULT);
> > 	munlock2(addr, len, MLOCK_LOCKED);
> > 
> > It looks to me like it will clear VM_LOCKED without actually unlocking any
> > pages.  Is that the intended result?  
> 
> This is not quite right, what happens when you call munlock2(addr, len,
> MLOCK_LOCKED); is we call apply_vma_flags(addr, len, VM_LOCKED, false).
