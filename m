From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 00/15] wire up renameat2 syscall for various archs
Date: Mon, 14 Apr 2014 22:11:28 +0200
Message-ID: <CAJfpeguwO_vkqHzk-UDooDdanGZoB3sr0pmJD5hGh2VAW1S5Dw@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<CAMuHMdVRUyo+PAQ8XUXuhZn1jk7T645aC=E274OjUOgNktBEJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:49037 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaDNUL3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Apr 2014 16:11:29 -0400
Received: by mail-qa0-f41.google.com with SMTP id j5so8561593qaq.14
        for <linux-arch@vger.kernel.org>; Mon, 14 Apr 2014 13:11:28 -0700 (PDT)
In-Reply-To: <CAMuHMdVRUyo+PAQ8XUXuhZn1jk7T645aC=E274OjUOgNktBEJw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 14, 2014 at 6:32 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Miklos,
>
> On Fri, Apr 11, 2014 at 12:25 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> This series wires up the recently added renameat2 syscall for archs that are
>> up-to-date in the sense that they appear to support the latest syscalls.  I
>> haven't touched the rest of them..
>>
>> Plus three NR_syscalls miscalculation fixes.
>
> Do you plan to collect acks, and ask Linus to pull this series later, or
> do you want each arch maintainer to take the patches for his/her pet
> architecture?

Whichever works best for you.

>
> Note that I don't plan to send another pull request for 3.15 for m68k,
> unless Something Really Bad happens.

So, if that's okay, I'll send it off to Linus sometime later.

Thanks,
Miklos
