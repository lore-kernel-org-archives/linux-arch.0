Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:52958 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeDDPy7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Apr 2018 11:54:59 -0400
References: <20180327230834.5931-1-logang@deltatee.com>
 <87r2nvmf3b.fsf@concordia.ellerman.id.au>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <515f5c92-ac02-6e09-830e-46ea4d462652@deltatee.com>
Date: Wed, 4 Apr 2018 09:54:41 -0600
MIME-Version: 1.0
In-Reply-To: <87r2nvmf3b.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v15 0/9] Add io{read|write}64 to io-64-atomic headers
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <20180404155441.oJsDAiVf4KCCKUOlE44k4OkQcWI_cpoM0RCQ6Fcnw_Y@z>

On 4/4/2018 4:38 AM, Michael Ellerman wrote:
> What's the plan for getting it merged? Seems we don't have one?

Yeah, so far there is no plan. I'm not really sure who's attention I 
need to get or how to get it.

> Given it touches two arches and generic stuff and drivers and crypto,
> it's a bit of a mess to merge. It's not really something I want to merge
> via the powerpc tree.

Understood.

> Is there any way to split it? I couldn't immediately see what the hard
> dependencies were between the patches.

Yes, a couple of patches have already been taken by their maintainers 
over the last few cycles.

> eg. It looks like I could take the two powerpc patches on their own for
> 4.17, and then the rest could go via other trees?

Yup! If you can take the powerpc patches I can keep trying to get the 
rest in. They are largely independent and shouldn't really change 
anything without the following patches.

> Is patch 1 stand alone?

Essentially, yes, but patch 5 depends on it seeing it's changing the 
same area and is trying to avoid creating the same kbuild warnings that 
patch 1 suppresses.

> The other option is to ask Andrew Morton to take it, as he often carries
> these cross-tree type series.

Thanks for the tip! I'll copy him when I repost it after the merge window.

Logan
