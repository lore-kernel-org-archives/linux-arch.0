From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH RESEND percpu#for-next] percpu: align percpu readmostly
 subsection to cacheline
Date: Tue, 28 Dec 2010 08:48:21 +0800
Message-ID: <1293497301.10593.27.camel@sli10-conroe>
References: <20101227133719.GD488@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101227133719.GD488@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 2010-12-27 at 21:37 +0800, Tejun Heo wrote:
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
yes, the x86 part works.

Thanks,
Shaohua
