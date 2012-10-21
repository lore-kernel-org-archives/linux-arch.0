Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail01.westnet.com.au ([203.10.1.242]:16103 "EHLO
	outbound-mail01.westnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753383Ab2JUMiz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 Oct 2012 08:38:55 -0400
Message-ID: <5083ECD8.80205@westnet.com.au>
Date: Sun, 21 Oct 2012 22:38:48 +1000
From: Greg Ungerer <gregungerer@westnet.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 00/11] m68k: use asm-generic headers when possible
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com> <CAMuHMdU_=3-_UcWMT2yBif5dX30963sqNz4CV+_KjTSAZwBS9w@mail.gmail.com>
In-Reply-To: <CAMuHMdU_=3-_UcWMT2yBif5dX30963sqNz4CV+_KjTSAZwBS9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gerg@snapgear.com, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20121021123848.IhI6qBPch2mF24QJ4I5Td__tFXPGsy_kYHSVmDwdFz4@z>

Hi Geert,

On 10/21/2012 12:46 AM, Geert Uytterhoeven wrote:
> On Mon, Oct 15, 2012 at 8:49 AM,  <gerg@snapgear.com> wrote:
>> On Arnd's suggestion I have gone through the m68k asm headers and weeded
>> out a bunch that are identical (or near enough) to the asm-generic versions
>> of these files.
>
> Thanks, looks great!
>
> (my first thought a few days ago was "Oh no, we're changing to the correct
> padding for e.g. time_t", but apparently the asm-generic versions do it wrong
> on big endian platforms, too ;-)

Yes, it is rather nice of the asm-generic versions , just what
we needed :-)

> Do you plan to resubmit for the uapi header changes I have already queued?

I am happy to do that. No hurry on my part, so whatever makes it
easiest for everyone. Will you be pushing those to Linus in this
rc series?

> Or shall I try to rebase it myself, using Stephen's fix?
> Note that termios.h now needs 2 changes, as it's split in uapi and normal
> (kernel use only).

Thanks for the heads up.

Regards
Greg

>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

