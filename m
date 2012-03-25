Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63402 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab2CYKPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 25 Mar 2012 06:15:44 -0400
Received: by yenl12 with SMTP id l12so3411055yen.19
        for <linux-arch@vger.kernel.org>; Sun, 25 Mar 2012 03:15:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVdhKANw2T0wQd_BXpWXWyUt-ozKoEP5GPH1zaQi6Y-dg@mail.gmail.com>
References: <1332259546-2037-1-git-send-email-consul.kautuk@gmail.com>
	<CAFPAmTTWtZGprAxfAd_k17Bip-cwpamLjAaQWRGfxgv+dwzK8w@mail.gmail.com>
	<CAMuHMdVdhKANw2T0wQd_BXpWXWyUt-ozKoEP5GPH1zaQi6Y-dg@mail.gmail.com>
Date: Sun, 25 Mar 2012 06:15:43 -0400
Message-ID: <CAFPAmTTYTfBB-PZ7t0fUNp-56bFa0AZyLpSx=KwdyaQ6hUx9BA@mail.gmail.com>
Subject: Re: [PATCH 08/20 v2] m68k/mm/fault.c: Port OOM changes to do_page_fault
From: Kautuk Consul <consul.kautuk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org
Message-ID: <20120325101543.TW2CJY6cS0WDQPy0O7jMscyaeF5fFrdpr6iafdUNm08@z>

On Sun, Mar 25, 2012 at 5:13 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Kautuk,
>
> On Sun, Mar 25, 2012 at 10:44, Kautuk Consul <consul.kautuk@gmail.com> wrote:
>> did you get a chance to review this patch ?
>
> Yes, I've just did. Sorry it took that long.

No problem.

> Looks good, so
> Acked-by: <Geert Uytterhoeven <geert@linux-m68k.org>
>
> BTW, what's the plan with this series? Will you take care of it, or should
> all arch maintainers take their parts?
>

Uh .. I didn't really think much about that as I'm quite new to this.      :)
It would be nice if everyone(including you) could just include their
respective patches in their trees/branches.

>> can I improve this patch in any way ?
>
> There are a few more or less minor things:
>  - You can remove "write" completely, as it's now superseded by
>    FAULT_FLAG_WRITE in "flags",
>  - Please also port the comments that were added to x86. They make
>    life easier for the casual reader.
>

should I send another patch for this ?
or do you want me to make a v2 of this patch and send it you today ?

> Thanks!
>
