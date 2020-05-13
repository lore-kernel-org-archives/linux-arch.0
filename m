Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgEMLDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:03:30 -0400
Subject: Re: [PATCH 04/14] prctl.2: srcfix add comments for navigation
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-5-git-send-email-Dave.Martin@arm.com>
 <8b882b6e-376b-111d-3c3c-7a042b0e91b5@gmail.com>
 <20200513105620.GE21779@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <9770249d-0d5a-1b02-4de1-bbb6343b5829@gmail.com>
Date: Wed, 13 May 2020 13:03:27 +0200
MIME-Version: 1.0
In-Reply-To: <20200513105620.GE21779@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200513110327.cHYlOw6ex4OgJ8BswR-6cgon5ASNFZijZQ1DKLV6VPs@z>

Hi Dave,

On 5/13/20 12:56 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:09:27PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> The prctl.2 source is unnecessarily hard to navigate, not least
>>> because prctl option flags are traditionally named PR_* and so look
>>> just like prctl names.
>>>
>>> For each actual prctl, add a comment of the form
>>>
>>> 	.\" prctl PR_FOO
>>>
>>> to make it move obvious where each top-level prctl starts.
>>>
>>> Of course, we could add some clever macros, but let's not confuse
>>> dumb parsers.
>>
>> A patch like this, which makes sweeping changes across the page,
>> should be best placed at the end of a series, I think.
>> The reason is that if I fail to apply this patch (and I am a
>> little dubious about it), then probably the rest of the patches
>> in the series won't apply. (Furthermore, it also forced me to
>> apply patch 02 already, which I wanted to reflect on a little.)
> 
> Agreed, I'll try to do that in future.
> 
>> That said, I'll apply it, so that the remaining patches
>> apply cleanly. I'll consider later whether to keep this
>> change. For example, I wonder if a visually distinctive 
>> source line that is always the same would be better than
>> these comments that repeat the PR_* names. For example, 
>> something like
>>
>> .\" ==========================
>>
>> I'll circle back to this later.
> 
> I'd prefer to keep the name if we can, since navigating by search is
> otherwise bothersome due to false hits.
> 
> Could we do both, say:
> 
> .\" === PR_FOO ===

Okay -- I'll give that some thought.

> If you prefer to reject this patch, I'm happy to rebase and repost the
> series as appropriate.
> 
> In any case, this one is nice to have rather than essential.

For now, the patch is already committed and pushed.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
