From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [patch] parisc, iommu: add missing include for prefetchw()
Date: Sat, 15 Oct 2011 18:48:19 -0500
Message-ID: <1318722499.7271.54.camel@dabdike.int.hansenpartnership.com>
References: <20111013233818.GB26654@one.firstfloor.org>
	 <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
	 <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, 2011-10-15 at 15:38 -0700, David Rientjes wrote:
> prefetchw() requires it to be defined by linux/prefetch.h, or it results
> in a compile error:
> 
> In file included from drivers/parisc/sba_iommu.c:916:0:
> drivers/parisc/iommu-helpers.h: In function 'iommu_fill_pdir':
> drivers/parisc/iommu-helpers.h:62:4: error: implicit declaration of function 'prefetchw'
> 
> Include linux/prefetch.h.

This isn't physically possible on the parisc platform: prefetch.h is
included by processor.h which, amongst other things, goes into
spinlock.h which is above this file in sba_iommu.c

How did you try to compile this file?

James
