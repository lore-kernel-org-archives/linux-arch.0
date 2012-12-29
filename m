From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V7 2/7] ARM: dt: change .dtb build rules to build in dts
 directory
Date: Fri, 28 Dec 2012 17:43:37 -0700
Message-ID: <50DE3CB9.10409@wwwdotorg.org>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org> <1354058956-7199-2-git-send-email-swarren@wwwdotorg.org> <20121226142739.GA28980@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121226142739.GA28980@S2101-09.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Michal Marek <mmarek@suse.cz>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On 12/26/2012 07:27 AM, Shawn Guo wrote:
> On Tue, Nov 27, 2012 at 04:29:11PM -0700, Stephen Warren wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> The current rules have the .dtb files build in a different directory
>> from the .dts files. The only reason for this is that it was what
>> PowerPC has done historically. This patch changes ARM to use the generic
>> dtb rule which builds .dtb files in the same directory as the source .dts.
>
> It's a pity that after merging the patch, all the enabled dts files
> will be rebuilt anyway no matter whether they are actually changed
> or not.

Oops. I thought I'd tested that quite extensively, but I somehow missed
something. I've sent patches to fix this.
