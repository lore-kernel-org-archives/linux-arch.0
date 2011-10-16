From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] parisc, iommu: add missing include for prefetchw()
Date: Sat, 15 Oct 2011 17:41:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1110151739330.5728@chino.kir.corp.google.com>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com> <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com> <1318722499.7271.54.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318722499.7271.54.camel@dabdike.int.hansenpartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
