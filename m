From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Fri, 30 May 2008 14:56:12 +0900
Message-ID: <20080530145612.fd930335.kamezawa.hiroyu@jp.fujitsu.com>
References: <20080530035620.587204923@sgi.com>
	<20080530040011.084909898@sgi.com>
	<20080529215833.469c3cbe.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0805292203240.12107@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35794 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYE3Fva (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 01:51:30 -0400
In-Reply-To: <Pine.LNX.4.64.0805292203240.12107@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

On Thu, 29 May 2008 22:10:25 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 29 May 2008, Andrew Morton wrote:
> 
> > > +config CPU_ALLOC_SIZE
> > > +	int "Size of cpu alloc area"
> > > +	default "30000"
> > 
> > strange choice of a default?  I guess it makes it clear that there's no
> > particular advantage in making it a power-of-two or anything like that.
> 
> The cpu alloc has a cpu_bytes field in vmstat that shows how much memory 
> is being used. 30000 seemed to be reasonable after staring at these 
> numbers for awhile.
> 

30000 is suitable for both of 32bits/64bits arch ?

Thanks,
-kame
