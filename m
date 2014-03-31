From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] asm-generic: allow generic unaligned access if the arch
 supports it
Date: Mon, 31 Mar 2014 20:22:43 +0200
Message-ID: <CAKv+Gu9RATUkhya0zytS8FbSM8=49xwNg0m24Xp1LtCWoarDRQ@mail.gmail.com>
References: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org>
	<201403281914.20201.arnd@arndb.de>
	<CAKv+Gu_9yD1jWhxkPxSUbwjJk4QxPNXBR=EXfmfCgzD1Pdig2g@mail.gmail.com>
	<20140331095941.GA29871@arm.com>
	<CAKv+Gu_05nmZrQxwELXae4tiK=-MpjUjmEKrULdg+6YuC-DW8Q@mail.gmail.com>
	<20140331172436.GL29871@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:34640 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbaCaSWp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Mar 2014 14:22:45 -0400
Received: by mail-la0-f42.google.com with SMTP id ec20so6216983lab.29
        for <linux-arch@vger.kernel.org>; Mon, 31 Mar 2014 11:22:44 -0700 (PDT)
In-Reply-To: <20140331172436.GL29871@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 31 March 2014 19:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Mar 31, 2014 at 11:07:54AM +0100, Ard Biesheuvel wrote:
>> On 31 March 2014 11:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Fri, Mar 28, 2014 at 06:24:04PM +0000, Ard Biesheuvel wrote:
>> >> On 28 March 2014 19:14, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> > On Thursday 27 March 2014, Ard Biesheuvel wrote:
>> >> >> Switch the default unaligned access method to 'hardware implemented'
>> >> >> if HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
>> >> >>
>> >> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> >
>> >> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>> >> >
>> >> > Is this part of a longer series of patches? If so, please keep
>> >> > the patch with the others and merge it through an appropriate
>> >> > tree.
>> >> >
>> >>
>> >> No, not really. I ran into the alignment issue while working on the
>> >> arm64 crypto stuff, but it is unclear when that will be going in.
>> >>
>> >> > If not, I guess I'll have to send it myself, but it will be
>> >> > the only asm-generic patch for the merge window ;-)
>> >>
>> >> Perhaps Catalin is interested in taking it, as arm64 is the only arch
>> >> that defines HAVE_EFFICIENT_UNALIGNED_ACCESS /and/ uses the
>> >> asm-generic version of unaligned.h.
>> >>
>> >> @Catalin?
>> >>
>> >> http://marc.info/?l=linux-arch&m=139594237116121&w=2
>> >
>> > I can take this, providing it doesn't break anything else. I'll push it
>> > to -next but won't send it with the first arm64 pull request.
>>
>> Yes, please.
>>
>> As I said, it can only affect arm64, and only users of
>> get_unaligned_xx/put_unaligned_xx so it should be safe as far as I can
>> tell.
>
> It actually affects arch/arm as well which selects
> HAVE_EFFICIENT_UNALIGNED_ACCESS for v6/v7 and uses the generic
> unaligned.h
>

Oops, my bad. I did a quick 'find -name unaligned.h' but misread 'arc'
for 'arm'.

@Russell: ARM is a user of asm-generic/unaligned.h, and I proposed a
patch to asm-generic that switches to unaligned accesses if
HAVE_EFFICIENT_UNALIGNED_ACCESS is set by the arch. This should affect
a fair amount of code living under net/ and drivers/ that don't test
for the Kconfig symbol but expect get_unaligned_xx/put_unaligned_xx to
turn into something suitable depending on the arch. Any objections?

@Arnd: anyone else you feel should be cc'ed on this?

Regards,
Ard.
