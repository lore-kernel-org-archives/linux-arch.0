From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 06/44] of/vendor-prefixes: add Imagination Technologies
Date: Thu, 6 Dec 2012 09:24:38 +0000
Message-ID: <50C06456.7090504@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <1354723742-6195-7-git-send-email-james.hogan@imgtec.com> <20121205222824.005C53E0E22@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55590 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab2LFJYn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Dec 2012 04:24:43 -0500
In-Reply-To: <20121205222824.005C53E0E22@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org

On 05/12/12 22:28, Grant Likely wrote:
> On Wed, 5 Dec 2012 16:08:24 +0000, James Hogan <james.hogan@imgtec.com> wrote:
>> The "powervr" prefix which is currently described as "Imagination
>> Technologies" isn't really appropriate for non-PowerVR hardware, so
>> deprecate it, changing the description of "powervr" to "PowerVR
>> (deprecated, use img)", and add a separate "img" prefix for "Imagination
>> Technologies Ltd.".
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Rob Landley <rob@landley.net>
>> Cc: devicetree-discuss@lists.ozlabs.org
> 
> Applied, thanks.
> 
> g.

Thanks Grant, I'll drop this patch from the metag patchset.

Cheers
James
