From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V4 REPOST 2/2] kbuild: run the pre-processor on *.dts
 files
Date: Sat, 27 Oct 2012 20:10:13 -0600
Message-ID: <508C9405.5030600@wwwdotorg.org>
References: <1351279797-16450-1-git-send-email-swarren@wwwdotorg.org> <1351279797-16450-2-git-send-email-swarren@wwwdotorg.org> <508AEB3E.6090405@gmail.com> <20121027220638.GK4564@opensource.wolfsonmicro.com> <fb065651-fd9d-4435-9a61-884dcb1da8d0@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59573 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab2J1CKP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Oct 2012 22:10:15 -0400
In-Reply-To: <fb065651-fd9d-4435-9a61-884dcb1da8d0@email.android.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>, Jon Loeliger <jdl@jdl.com>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Stephen Warren <swarren@nvidia.com>

On 10/27/2012 07:06 PM, Rob Herring wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
>     On Fri, Oct 26, 2012 at 02:57:50PM -0500, Rob Herring wrote:
> 
>         Like I said previously, I think we first need guidelines on what
>         is and
>         isn't acceptable use of C preprocessor in dts files.
> 
> 
>     Didn't we already say that it was just the same rules as for things tht
>     get included in .S files?  Besides for plain .dts files (as opposed to
>     .dtsi files) it seems like if people break things they get to keep all
>     the pieces without disrupting other people too much.
> 
> 
> Yes, but can we document that. Also, I'd like others with more DT
> historical knowledge to weigh in.

OK. What's the appropriate file to document that in? I assume you're not
just looking for an explanation in the commit description?
