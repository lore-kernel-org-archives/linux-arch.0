From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] x86: PAT: Documentation: update overlapping ioremap hack
 recommendation
Date: Thu, 3 Mar 2016 13:42:33 -0800
Message-ID: <20160303214233.GN3577@linux.vnet.ibm.com>
References: <1457040108-27358-1-git-send-email-mcgrof@kernel.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457040108-27358-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, toshi.kani@hp.com, airlied@redhat.com, benh@kernel.crashing.org, mst@redhat.com, vinod.koul@intel.com, jgross@suse.com, daniel.vetter@ffwll.ch, luto@amacapital.net, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 03, 2016 at 01:21:48PM -0800, Luis R. Rodriguez wrote:
> The current documentation refers to using set_memor_wc() as a
> possible hole strategy when you have overlapping ioremap() regions,
> that's incorrect as set_memory_*() helpers can only be used on RAM,
> not IO memory. This fixes that, and updates the documention to
> *strongly* discourage overlapping ioremap() memory uses, but also
> documents a possible solution should there really be no other
> option.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Given an Acked-by or better from the guys on the TO line, I would be
happy to queue it.

							Thanx, Paul

> ---
>  Documentation/x86/pat.txt | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
> index 54944c71b819..8a26b4cdccf6 100644
> --- a/Documentation/x86/pat.txt
> +++ b/Documentation/x86/pat.txt
> @@ -113,18 +113,21 @@ MTRR effects on PAT / non-PAT systems
>  -------------------------------------
> 
>  The following table provides the effects of using write-combining MTRRs when
> -using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
> -mtrr_add() usage will be phased out in favor of arch_phys_wc_add() which will
> -be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
> +using ioremap*() calls on x86 for both non-PAT and PAT systems. As of v4.3
> +mtrr_add() has been phased out in favor of arch_phys_wc_add(), these calls are
> +a no-op on PAT enabled systems. The region over which an arch_phys_wc_add()
>  is made, should already have been ioremapped with WC attributes or PAT entries,
> -this can be done by using ioremap_wc() / set_memory_wc().  Devices which
> -combine areas of IO memory desired to remain uncacheable with areas where
> -write-combining is desirable should consider use of ioremap_uc() followed by
> -set_memory_wc() to white-list effective write-combined areas.  Such use is
> -nevertheless discouraged as the effective memory type is considered
> -implementation defined, yet this strategy can be used as last resort on devices
> -with size-constrained regions where otherwise MTRR write-combining would
> -otherwise not be effective.
> +this can be done by using ioremap_wc(). Devices which combine areas of IO
> +memory desired to remain uncacheable with areas where write-combining is
> +desirable should consider use of ioremap_wc() followed by an overlapping
> +ioremap_uc() "hole". For an example of this strategy refer to commit 3cc2dac5be
> +("drivers/video/fbdev/atyfb: Replace MTRR UC hole with strong UC").
> +Such use is nevertheless heavily discouraged as the effective memory type is
> +considered implementation defined. This strategy should only be used used as a
> +last resort measure.
> +
> +Note you cannot use set_memory_*() helpers on ioremap'd regions, even though
> +its use currently gives no hint of an error.
> 
>  ----------------------------------------------------------------------
>  MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
> -- 
> 2.7.2
> 
