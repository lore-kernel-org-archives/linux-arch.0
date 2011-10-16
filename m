From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] parisc, iommu: add missing include for prefetchw()
Date: Sat, 15 Oct 2011 18:15:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1110151810220.5728@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com> <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com> <1318722499.7271.54.camel@dabdike.int.hansenpartnership.com>
 <alpine.DEB.2.00.1110151739330.5728@chino.kir.corp.google.com> <1318726615.7271.59.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:30915 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab1JPBP4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2011 21:15:56 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p9G1Ftw5020695
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 18:15:55 -0700
Received: from pzk2 (pzk2.prod.google.com [10.243.19.130])
	by wpaz29.hot.corp.google.com with ESMTP id p9G1F2TD001140
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 18:15:53 -0700
Received: by pzk2 with SMTP id 2so7042905pzk.8
        for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 18:15:53 -0700 (PDT)
In-Reply-To: <1318726615.7271.59.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, 15 Oct 2011, James Bottomley wrote:

> > > How did you try to compile this file?
> > > 
> > 
> > make allyesconfig
> > make drivers/parisc/sba_iommu.o
> 
> OK, so just take one of the standard configs ... I don't think anyone's
> tried much randconfig testing over parisc, most of the configuration
> lore is handed down from the mountain on stone tablets.
> 

This isn't randconfig, it's allyesconfig, and this is the only compile 
error that I got while trying to reproduce your percpu.c compile failure.  
Everything else works fine.
