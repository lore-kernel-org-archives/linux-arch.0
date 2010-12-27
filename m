From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RESEND percpu#for-next] percpu: align percpu readmostly
 subsection to cacheline
Date: Mon, 27 Dec 2010 12:17:57 -0800
Message-ID: <4D18F475.8090604@zytor.com>
References: <20101227133719.GD488@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59964 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab0L0USJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Dec 2010 15:18:09 -0500
In-Reply-To: <20101227133719.GD488@htj.dyndns.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, eric.dumazet@gmail.com, linux-arch@vger.kernel.org

On 12/27/2010 05:37 AM, Tejun Heo wrote:
> Currently percpu readmostly subsection may share cachelines with other
> percpu subsections which may result in unnecessary cacheline bounce
> and performance degradation.
> 
> This patch adds @cacheline parameter to PERCPU() and PERCPU_VADDR()
> linker macros, makes each arch linker scripts specify its cacheline
> size and use it to align percpu subsections.
> 
> This is based on Shaohua's x86 only patch.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Shaohua Li <shaohua.li@intel.com>
> ---
> Shaohua, can you please verify this achieves the same result?  If no
> one objects, I'll route it through the percpu tree.
> 

For x86:

Acked-by: H. Peter Anvin <hpa@zytor.com>
