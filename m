Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:46457 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab1JPAln (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2011 20:41:43 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p9G0fetj029725
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 17:41:41 -0700
Received: from pzk4 (pzk4.prod.google.com [10.243.19.132])
	by wpaz21.hot.corp.google.com with ESMTP id p9G0fQTq025993
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 17:41:39 -0700
Received: by pzk4 with SMTP id 4so4025070pzk.6
        for <linux-arch@vger.kernel.org>; Sat, 15 Oct 2011 17:41:39 -0700 (PDT)
Date: Sat, 15 Oct 2011 17:41:36 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] parisc, iommu: add missing include for prefetchw()
In-Reply-To: <1318722499.7271.54.camel@dabdike.int.hansenpartnership.com>
Message-ID: <alpine.DEB.2.00.1110151739330.5728@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com> <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com> <1318722499.7271.54.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20111016004136.KGlnVpsy6CGZl4Vex43DzxCck_W7w4s-prIEbU_mGWs@z>

On Sat, 15 Oct 2011, James Bottomley wrote:

> This isn't physically possible on the parisc platform: prefetch.h is
> included by processor.h which, amongst other things, goes into
> spinlock.h which is above this file in sba_iommu.c
> 

asm/prefetch.h is included in processor.h, not linux/prefetch.h.  Thus, 
it's undefined for CONFIG_PA20=n.

> How did you try to compile this file?
> 

make allyesconfig
make drivers/parisc/sba_iommu.o
