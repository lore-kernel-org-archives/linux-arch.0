Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35239 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbcCELxB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Mar 2016 06:53:01 -0500
Date: Sat, 5 Mar 2016 12:52:55 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] x86: PAT: Documentation: rewrite "MTRR effects on PAT
 / non-PAT systems"
Message-ID: <20160305115255.GA11846@gmail.com>
References: <20160304210900.GT3577@linux.vnet.ibm.com>
 <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: paulmck@linux.vnet.ibm.com, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com, toshi.kani@hp.com, airlied@redhat.com, benh@kernel.crashing.org, mst@redhat.com, vinod.koul@intel.com, jgross@suse.com, daniel.vetter@ffwll.ch, luto@amacapital.net, davem@davemloft.net, ben@decadent.org.uk, benjamin.poirier@gmail.com, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net
Message-ID: <20160305115255.H7ElDmEL7dNI_vfR5ZBBYyIJGa4T6tJisYDrlfpIyYg@z>


* Luis R. Rodriguez <mcgrof@kernel.org> wrote:

> The current documentation refers to using set_memory_wc() as a
> possible hole strategy when you have overlapping ioremap() regions,

The whole explanation should talk about virtual aliases over the same physical 
address, not some 'overlapping regions'.

I see where this talk about 'overlap' comes: the memtype rbtree in 
arch/x86/mm/pat_rbtree.c indeed has memtype ranges that may overlap on the 
physical side. But it is highly confusing to call this 'overlapping' on the driver 
API documentation level without making it really clear what it's about.

Thanks,

	Ingo
