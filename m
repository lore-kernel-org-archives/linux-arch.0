From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 0/4] remove GENERIC_GPIO
Date: Tue, 16 Apr 2013 10:45:52 +0100
Message-ID: <CACxGe6ukQ7eys9-m_hgpscy9tTncPd1CL0O+n0sBZA-o0AbwdA@mail.gmail.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <20130416093259.BEB0E3E14C0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57482 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab3DPJqN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:46:13 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so259170ied.5
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2013 02:46:12 -0700 (PDT)
In-Reply-To: <20130416093259.BEB0E3E14C0@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>

On Tue, Apr 16, 2013 at 10:32 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Mon,  8 Apr 2013 11:32:26 -0700, Alexandre Courbot <gnurou@gmail.com> wrote:
>> From: Alexandre Courbot <acourbot@nvidia.com>
>>
>> Second version, based on -next this time, of the GENERIC_GPIO removal patches.
>> Considering there is only a short amount of time before 3.10 merge window opens,
>> I hope this version will be considered for inclusion, otherwise we'd end up
>> with an half-baked removal or I will have to rebase everything for 3.11. :(
>>
>> Grant, if this is ok with you, how shall we have this integrated into your
>> branch? Half of this has been tested in my -next branch, and the present patches
>> make the next half, should I resend you the whole series based on -next and
>> withdraw my branch? This is a fast moving target, so we should try and shoot
>> that duck as soon as we can! :)
>
> Most of your patches are already in linux-next in a separate branch, so
> the first thing to do is get these remaining patches into that same
> branch. As we discussed on IRC, you need to move yor current
> "remove_generic_gpio" branch into your for_next branch so that it is
> picked up by Stephen. There isn't any functional change there, but it
> means that your series will be based on a defined point of Linus' tree
> (v3.9-rc6) instead of an arbitrary commit point between -rc3 and -rc4.

On second thought, no don't do this. Just leave it as is. It is more
important to retain the test coverage you've already had in linux-next
on these commits. Just apply the patches I've acked onto your existing
for_next branch.

g.
