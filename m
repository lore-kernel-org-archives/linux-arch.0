From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V6 2/2] kbuild: run the pre-processor on *.dts files
Date: Wed, 14 Nov 2012 22:25:45 +0000
Message-ID: <20121114222545.7E3943E0E2B@localhost>
References: <1352753907-3316-1-git-send-email-swarren@wwwdotorg.org> <1352753907-3316-2-git-send-email-swarren@wwwdotorg.org> <20121114192548.59F093E0B7C@localhost> <50A3FC90.7030105@wwwdotorg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50A3FC90.7030105@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, David Gibson <david@gibson.dropbear.id.au>, Jon Loeliger <jdl@jdl.com>, Rob Herring <rob.herring@calxeda.com>, Scott Wood <scottwood@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 14 Nov 2012 13:18:24 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/14/2012 12:25 PM, Grant Likely wrote:
> > On Mon, 12 Nov 2012 13:58:27 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> From: Stephen Warren <swarren@nvidia.com>
> >>
> >> Modify cmd_dtc to run the C pre-processor on the input .dts file before
> >> passing it to dtc for final compilation. This allows the use of #define
> >> and #include within the .dts file.
> 
> > Ugh, I'm definitely nervous about turning this on because of the long
> > term implications so I'm going to punt on actually making a decision
> > about it for the momemnt. However, I do have a question...
> 
> Hmmm. So how do we get to a decision on this then?

I'm punting for the evening just because I'm mentally exhausted. I'll
make a decision in the next couple of days.

g.
