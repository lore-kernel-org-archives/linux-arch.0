Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759639AbYDKPu4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Apr 2008 11:50:56 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1207927166.22001.91.camel@brick>
References: <1207927166.22001.91.camel@brick> <1207885132.22001.85.camel@brick> <15208.1207908688@redhat.com>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 16:50:50 +0100
Message-ID: <2225.1207929050@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080411155050.i1g1Nv40bUw9Pp5LWw1fzy-cJ2YL3EXhnp02R8T5ILA@z>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Consistency with every other arch..no other reason.

But not M68K(NOMMU), Alpha, Blackfin, Cris, H8300, MN10300, ..., but generally
consistent with the other FRV headers (some other people have added differ).

Hmmm...  It looks like MIPS is weird.  That says __ASM_GENERIC_UNALIGNED_H,
which is probably wrong.

David
