Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:13887 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760441AbYDKRbh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2008 13:31:37 -0400
Received: by wr-out-0506.google.com with SMTP id c48so645068wra.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2008 10:31:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <2225.1207929050@redhat.com>
References: <1207927166.22001.91.camel@brick>
	 <1207885132.22001.85.camel@brick> <15208.1207908688@redhat.com>
	 <2225.1207929050@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 10:31:39 -0700
Message-ID: <1207935099.22001.94.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080411173139.ph8qYkt-eGTMRuzSz8jJt1Aem71xXa2H9o7YiPJrXTw@z>

On Fri, 2008-04-11 at 16:50 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > Consistency with every other arch..no other reason.
> 
> But not M68K(NOMMU), Alpha, Blackfin, Cris, H8300, MN10300, ..., but generally
> consistent with the other FRV headers (some other people have added differ).
> 
> Hmmm...  It looks like MIPS is weird.  That says __ASM_GENERIC_UNALIGNED_H,
> which is probably wrong.
> 
> David

Well, now's the time to decide on something as I'm changing every arch.

What is the general pattern used for this kind of thing?  Or am I just
asking what color to paint this bikeshed?

Harvey

