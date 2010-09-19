Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58063 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab0ISEu4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2010 00:50:56 -0400
MIME-Version: 1.0
In-Reply-To: <4C9579A1.5030009@orcon.net.nz>
References: <20100918083846.GA31363@ZenIV.linux.org.uk> <4C9579A1.5030009@orcon.net.nz>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 19 Sep 2010 00:50:34 -0400
Message-ID: <AANLkTimPZ5=FBdffeeDVB0_=no-rQcdEOdZ0OqLXkpss@mail.gmail.com>
Subject: Re: [PATCH 1/4] alpha: belated ERESTART_RESTARTBLOCK race fix
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Cree <mcree@orcon.net.nz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org
Message-ID: <20100919045034.UGa3yPulz-lkdsnJXvlxe_C0Ajb8jOPSWl-PW7z3gEI@z>

On Sat, Sep 18, 2010 at 10:46 PM, Michael Cree <mcree@orcon.net.nz> wrote:
> On 18/09/10 20:38, Al Viro wrote:
>>
>> same thing as had been done on other targets back in 2003 -
>> move setting ->restart_block.fn into {rt_,}sigreturn().
>>
>> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>
>
> For the patch series:
>
> Tested-by: Michael Cree <mcree@orcon.net.nz>
>
> Cheers
> Michael.
>

Thanks for the test.

Al, I've vacuumed your patches and sent them with others in a pull
request to Linus.

Thanks a ton. Anyone who finds and fixes a 14 year-old bug, well, I
owe you a beer.

Thanks!
Matt
