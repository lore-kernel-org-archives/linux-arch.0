Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:51888 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab1DTVmd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2011 17:42:33 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p3KLgUbf028360
	for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2011 14:42:31 -0700
Received: from pxi9 (pxi9.prod.google.com [10.243.27.9])
	by wpaz13.hot.corp.google.com with ESMTP id p3KLgSTP027900
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2011 14:42:29 -0700
Received: by pxi9 with SMTP id 9so937798pxi.14
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2011 14:42:28 -0700 (PDT)
Date: Wed, 20 Apr 2011 14:42:26 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3] mm: make expand_downwards symmetrical to
 expand_upwards
In-Reply-To: <alpine.DEB.2.00.1104201018360.9266@router.home>
Message-ID: <alpine.DEB.2.00.1104201437180.31768@chino.kir.corp.google.com>
References: <20110420102314.4604.A69D9226@jp.fujitsu.com>  <BANLkTi=mxWwLPEnB+rGg29b06xNUD0XvsA@mail.gmail.com>  <20110420161615.462D.A69D9226@jp.fujitsu.com>  <BANLkTimfpY3gq8oY6bPDajBW7JN6Hp+A0A@mail.gmail.com>  <20110420112020.GA31296@parisc-linux.org>
 <BANLkTim+m-v-4k17HUSOYSbmNFDtJTgD6g@mail.gmail.com>  <1303308938.2587.8.camel@mulgrave.site>  <alpine.DEB.2.00.1104200943580.9266@router.home> <1303311779.2587.19.camel@mulgrave.site> <alpine.DEB.2.00.1104201018360.9266@router.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Pekka Enberg <penberg@kernel.org>, Matthew Wilcox <matthew@wil.cx>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-parisc@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, x86 maintainers <x86@kernel.org>, linux-arch@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
Message-ID: <20110420214226.zqBdQ2KG3hAZ2MGnX3rYL84FB3xm6EfQusYYWDcHI-U@z>

On Wed, 20 Apr 2011, Christoph Lameter wrote:

> There is barely any testing going on at all of this since we have had this
> issue for more than 5 years and have not noticed it. The absence of bug
> reports therefore proves nothing. Code inspection of the VM shows
> that this is an issue that arises in multiple subsystems and that we have
> VM_BUG_ONs in the page allocator that should trigger for these situations.
> 
> Usage of DISCONTIGMEM and !NUMA is not safe and should be flagged as such.
> 

We don't actually have any bug reports in front of us that show anything 
else in the VM other than slub has issues with this configuration, so 
marking them as broken is probably premature.  The parisc config that 
triggered this debugging enables CONFIG_SLAB by default, so it probably 
has gone unnoticed just because nobody other than James has actually tried 
it on hppa64.

Let's see if KOSAKI-san's fixes to Kconfig (even though I'd prefer the 
simpler and implicit "config NUMA def_bool ARCH_DISCONTIGMEM_ENABLE" over 
his config NUMA) and my fix to parisc to set the bit in N_NORMAL_MEMORY 
so that CONFIG_SLUB initializes kmem_cache_node correctly works and then 
address issues in the core VM as they arise.  Presumably someone has been 
running DISCONTIGMEM on hppa64 in the past five years without issues with 
defconfig, so the issue here may just be slub.
