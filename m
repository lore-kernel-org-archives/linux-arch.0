Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11227 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdLKCWG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Dec 2017 21:22:06 -0500
Subject: Re: [PATCH v4] mmap.2: MAP_FIXED updated documentation
References: <20171206031434.29087-1-jhubbard@nvidia.com>
 <20171210103147.GC20234@dhcp22.suse.cz>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <fba147b0-06b6-fbf9-8194-171a3e146a63@nvidia.com>
Date: Sun, 10 Dec 2017 18:22:05 -0800
MIME-Version: 1.0
In-Reply-To: <20171210103147.GC20234@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-man <linux-man@vger.kernel.org>, linux-api@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20171211022205.6M5sv2ONroaTgzMosHVglh_KbAHsUZp-G2sF6nHZIDQ@z>

On 12/10/2017 02:31 AM, Michal Hocko wrote:
> On Tue 05-12-17 19:14:34, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Previously, MAP_FIXED was "discouraged", due to portability
>> issues with the fixed address. In fact, there are other, more
>> serious issues. Also, alignment requirements were a bit vague.
>> So:
>>
>>     -- Expand the documentation to discuss the hazards in
>>        enough detail to allow avoiding them.
>>
>>     -- Mention the upcoming MAP_FIXED_SAFE flag.
>>
>>     -- Enhance the alignment requirement slightly.
>>
>> Some of the wording is lifted from Matthew Wilcox's review
>> (the "Portability issues" section). The alignment requirements
>> section uses Cyril Hrubis' wording, with light editing applied.
>>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Would you mind if I take this patch and resubmit it along with my
> MAP_FIXED_SAFE (or whatever name I will end up with) next week?
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Sure, that works for me. A tiny complication: I see that Michael
Kerrisk has already applied the much smaller v2 of this patch (the
one that "no longer discourages" the option, but that's all), as:

   ffa518803e14 mmap.2: MAP_FIXED is no longer discouraged

so this one here will need to be adjusted slightly to merge
gracefully. Let me know if you want me to respin, or if you
want to handle the merge.

thanks,
-- 
John Hubbard
NVIDIA
