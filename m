Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:46507 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753788AbbLZAFL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Dec 2015 19:05:11 -0500
Message-ID: <1451088307.12498.3.camel@perches.com>
Subject: Re: [PATCH v2 15/16] checkpatch: Add warning on deprecated
 walk_iomem_res
From: Joe Perches <joe@perches.com>
Date: Fri, 25 Dec 2015 16:05:07 -0800
In-Reply-To: <1451081365-15190-15-git-send-email-toshi.kani@hpe.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
	 <1451081365-15190-15-git-send-email-toshi.kani@hpe.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>, akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Message-ID: <20151226000507.zISaADyhmqKlPQ6mwHUD6oWnANB5IQSMu3FZrY9JE6Q@z>

On Fri, 2015-12-25 at 15:09 -0700, Toshi Kani wrote:
> Use of walk_iomem_res() is deprecated in new code.  Change
> checkpatch.pl to check new use of walk_iomem_res() and suggest
> to use walk_iomem_res_desc() instead.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3424,6 +3424,12 @@ sub process {
>  			}
>  		}
>  
> +# check for uses of walk_iomem_res()
> +		if ($line =~ /\bwalk_iomem_res\(/) {
> +			WARN("walk_iomem_res",
> +			     "Use of walk_iomem_res is deprecated, please use walk_iomem_res_desc instead\n" . $herecurr)
> +		}
> +
>  # check for new typedefs, only function parameters and sparse annotations
>  # make sense.
>  		if ($line =~ /\btypedef\s/ &&

There are 6 uses of this function in the entire kernel tree.
Why not just change them, remove the function and avoid this?

