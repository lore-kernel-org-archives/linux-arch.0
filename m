From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
Date: Fri, 02 Nov 2012 09:00:37 -0600
Message-ID: <5093E015.1070504@wwwdotorg.org>
References: <1351721431-26220-1-git-send-email-swarren@wwwdotorg.org> <20121102095801.GC17860@linux-mips.org> <20121102102335.GF2905@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45516 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2KBPAn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2012 11:00:43 -0400
In-Reply-To: <20121102102335.GF2905@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Michal Marek <mmarek@suse.cz>, David Gibson <david@gibson.dropbear.id.au>, Jon Loeliger <jdl@jdl.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Scott Wood <scottwood@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-mips@linux-mips.org

On 11/02/2012 04:23 AM, Ralf Baechle wrote:
> On Fri, Nov 02, 2012 at 10:58:01AM +0100, Ralf Baechle wrote:
> 
>> Can you fold these MIPS bits into your patch?
> 
> I missed Lantiq.

Thanks, I've squashed that in, and with a quick grep noticed that
arch/{arm64,microblaze} also need updating.
