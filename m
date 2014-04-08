From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] asm-generic: allow generic unaligned access if the arch
 supports it
Date: Tue, 8 Apr 2014 08:48:44 +0200
Message-ID: <CAKv+Gu-rx8W05i=xHaoZCktj6YWH56Zn2yNaiEeenm0=NmcwUQ@mail.gmail.com>
References: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org>
	<201403281914.20201.arnd@arndb.de>
	<CAKv+Gu_9yD1jWhxkPxSUbwjJk4QxPNXBR=EXfmfCgzD1Pdig2g@mail.gmail.com>
	<20140331095941.GA29871@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:62824 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaDHGsp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Apr 2014 02:48:45 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so446545lbj.17
        for <linux-arch@vger.kernel.org>; Mon, 07 Apr 2014 23:48:44 -0700 (PDT)
In-Reply-To: <20140331095941.GA29871@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 31 March 2014 11:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Mar 28, 2014 at 06:24:04PM +0000, Ard Biesheuvel wrote:
>> On 28 March 2014 19:14, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 27 March 2014, Ard Biesheuvel wrote:
>> >> Switch the default unaligned access method to 'hardware implemented'
>> >> if HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
>> >>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >
>> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>> >
>> > Is this part of a longer series of patches? If so, please keep
>> > the patch with the others and merge it through an appropriate
>> > tree.
>> >
>>
>> No, not really. I ran into the alignment issue while working on the
>> arm64 crypto stuff, but it is unclear when that will be going in.
>>
>> > If not, I guess I'll have to send it myself, but it will be
>> > the only asm-generic patch for the merge window ;-)
>>
>> Perhaps Catalin is interested in taking it, as arm64 is the only arch
>> that defines HAVE_EFFICIENT_UNALIGNED_ACCESS /and/ uses the
>> asm-generic version of unaligned.h.
>>
>> @Catalin?
>>
>> http://marc.info/?l=linux-arch&m=139594237116121&w=2
>
> I can take this, providing it doesn't break anything else. I'll push it
> to -next but won't send it with the first arm64 pull request.
>

Are you still interested in taking this? Russell doesn't appear
particularly unhappy with it, so I guess it should sit in -next for a
bit before getting it merged.

-- 
Ard.
