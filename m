From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC PATCH 1/2] kbuild: centralize .dts->.dtb rule
Date: Sat, 29 Sep 2012 22:08:28 +0200
Message-ID: <20120929200828.GD31527@game.jcrosoft.org>
References: <1348860731-20868-1-git-send-email-swarren@wwwdotorg.org>
 <1348860731-20868-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348860731-20868-2-git-send-email-swarren@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Jon Loeliger <jdl@jdl.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Scott Wood <scottwood@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On 13:32 Fri 28 Sep     , Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> All architectures that use cmd_dtc do so in the same way. Move the build
> rule to a central location to avoid duplication.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Jean-Christophe,
> Moving the build rule to Makefile.lib rather than Makefile.build seems
> reasonable to me; the dtc-related logic is already in Makefile.lib, and
> for features where cmd_* is defined in Makefile.lib, the associated
> build rule is also defined there. I see no reason for this patch series
> to move all the dtc-related logic into Makefile.build.

build rules are in Makefile.build c to o , s to o etc...

so put it in Makefile.build is the correct place ditto fot the dtc cmd

Best Regards,
J.
