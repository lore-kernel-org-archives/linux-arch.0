From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 06/14] prctl.2: ffix quotation mark tweaks
Date: Wed, 13 May 2020 13:46:22 +0200
Message-ID: <f575e35d-cd5e-5808-bed4-91bdfb9c2905@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-7-git-send-email-Dave.Martin@arm.com>
 <7afe32a5-9675-74d4-7c39-f1271d475afd@gmail.com>
 <20200513113949.GI21779@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgEMLq0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:46:26 -0400
In-Reply-To: <20200513113949.GI21779@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 5/13/20 1:39 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:11:21PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> Convert quote marks used for information terms in prose to use
>>> \(oq .. \(cq, for better graphical rendering.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>
>> Again, this is a patch that I would prefer to see near the end 
>> of a series, rather than in the middle.
>>
>> I'm currently agnostic about this change. But, I do not
>> want to apply this patch, since no other pages in man-pages
>> use \(oq...\(cq.
>>
>> I haven't applied this patch. Luckily, that does not prevent
>> any of the later patches applying.
> 
> I'll be careful to move this sort of thing to the end of a series in
> future.
> 
> This was a provocative patch, so I'm happy for it to be dropped.
> 
> 
> The main motivation was that ' renders to PostScript etc. as a closing
> quote, which is fine for apostrophes but not fine for an opening quote
> mark.  Most of the current quotes in here are actually ", but I don't
> see an actual promise from groff that that renders as a neutral glyph
> either, so it seemed best to avoid.  For now " does seem to be rendered
> with a neutral glyph (i.e., neither opening or closing).

See my commit 11b0b31a14bd2c7dcb0cf7bc815b4c1887444a89, just pushed,
which addresses the ' issues.

>>> ---
>>>
>>> Note, this can lead to misrendering on badly-configured systems.
>>> However, many man pages do it.
>>
>> Can you say some more about this please?
> 
> Terminal character maps need to match LANG etc. in order for fancy
> characters coming out of nroff to display correctly.
> 
> ssh attempts to send LANG across, but terminal sessions between systems
> that have different locales installed can be a problem, as can dumb
> serial links that don't magically pass the locale and terminal type
> settings across.
> 
> The fact that I hit this problem a lot in some situations (particularly
> the serial link case) suggested to me that fancy characters are
> considered fine nowadays, but perhaps I'd need to dig into it some more
> to understand the situation fully.

Thanks for the clarification.

> (There are one or two ' that should really be \(aq anyway, but I'll
> try to address that separately.)

See above. I presume that patch is what you wanted?

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
