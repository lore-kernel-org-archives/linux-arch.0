From: David Rientjes <rientjes@google.com>
Subject: Re: Please include const-sections into linux-next
Date: Sat, 15 Oct 2011 16:03:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1110151543220.25063@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:51092 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab1JOXD0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2011 19:03:26 -0400
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
	by smtp-out.google.com with ESMTP id p9FN3PMN029297
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 16:03:25 -0700
Received: from pzk1 (pzk1.prod.google.com [10.243.19.129])
	by wpaz17.hot.corp.google.com with ESMTP id p9FN3FnD023809
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 16:03:24 -0700
Received: by pzk1 with SMTP id 1so962449pzk.5
        for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 16:03:23 -0700 (PDT)
In-Reply-To: <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, 14 Oct 2011, James Bottomley wrote:

> It's not incredibly trivial: it causes a compile failure on parisc:
> 
> mm/percpu.c:1372: error: __setup_str_percpu_alloc_setup causes a section
> type conflict
> make[1]: *** [mm/percpu.o] Error 1
> 
> I have no idea why, though.
> 

Not sure why this would only happen on parisc, but I haven't looked at it 
closely.  It means something qualified with const is being defined in a 
section with other definitions that are not const, or vice versa.

For example:

	static int x __attribute__((__section__("foo"))) = 1;
	static const int y __attribute__((__section__("foo"))) = 2;

will result in the same error.  Since __setup_param() places 
__setup_str_percpu_alloc_setup in .init.rodata as const, it means 
something else has already been defined in .init.rodata without being 
qualified as such.
