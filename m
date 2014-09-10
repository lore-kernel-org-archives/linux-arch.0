Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:39600 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaIJH3b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Sep 2014 03:29:31 -0400
Message-ID: <540FFDD5.8000403@mentor.com>
Date: Wed, 10 Sep 2014 15:29:25 +0800
From: Chung-Lin Tang <chunglin_tang@mentor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 25/29] nios2: Module support
References: <1410168160-3624-1-git-send-email-lftan@altera.com>            <1410168160-3624-26-git-send-email-lftan@altera.com> <75377.1410297958@turing-police.cc.vt.edu>
In-Reply-To: <75377.1410297958@turing-police.cc.vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis.Kletnieks@vt.edu, Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140910072925.YF3JBWizs6DaATY4hOwjIGhdRJ-vOoV-gZpEciKTvv4@z>

On 14/9/10 5:25 AM, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 08 Sep 2014 17:22:36 +0800, Ley Foon Tan said:
>> This patch adds support for loadable modules.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> 
>> +/*
>> + * Modules should NOT be allocated with kmalloc for (obvious) reasons.
>> + * But we do it for now to avoid relocation issues. CALL26/PCREL26 cannot reach
>> + * from 0x80000000 (vmalloc area) to 0xc00000000 (kernel) (kmalloc returns
>> + * addresses in 0xc0000000)
>> + */
> 
> That's a nice scary comment to see. :)
> 
> What's the long-term plan here?
> 

We would probably need to add the ability to add trampolines in some
way, though this of course impairs a little performance. Or if the
default region of vmalloc can be configured to use the same 256MB region
as the kernel.

I wonder how MIPS (which has similar same-region call/jump instructions)
deals with this?

Chung-Lin

