Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:49688 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756826AbaDVPcS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 11:32:18 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so5557679qgd.27
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2014 08:32:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUtPucUNXDt=o_avzSCMvL9bwn-A6WH5dY4ZazGPj2QnA@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<1397211951-20549-7-git-send-email-miklos@szeredi.hu>
	<CAMuHMdUtPucUNXDt=o_avzSCMvL9bwn-A6WH5dY4ZazGPj2QnA@mail.gmail.com>
Date: Tue, 22 Apr 2014 17:32:16 +0200
Message-ID: <CAJfpeguxmjzW93x-RzT0GahwhkchTMe2OdyfBtnBLCbB6zsc5Q@mail.gmail.com>
Subject: Re: [PATCH 06/15] m68k: add renameat2 syscall
From: Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>
Message-ID: <20140422153216.h3gnvptbC-QVioBm70arBr7dwWO8yjIiP_3MH5HgUA8@z>

On Mon, Apr 21, 2014 at 10:10 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Miklos,
>
> On Fri, Apr 11, 2014 at 12:25 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> --- a/arch/m68k/kernel/syscalltable.S
>> +++ b/arch/m68k/kernel/syscalltable.S
>> @@ -371,4 +371,5 @@ ENTRY(sys_call_table)
>>         .long sys_finit_module
>>         .long sys_sched_setattr
>>         .long sys_sched_getattr         /* 350 */
>> +       .long sys_sched_renameat2
>
> "sys_renameat2", please.
>
> Sorry for not noticing before I threw it at the compiler.


Fixed.  Thanks!

Miklos
