Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33952 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbdBTM6V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2017 07:58:21 -0500
Received: by mail-wr0-f176.google.com with SMTP id z61so63479114wrc.1
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2017 04:58:20 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v6 7/8] uapi: export all headers under uapi directories
References: <201702022242.toNVsxyq%fengguang.wu@intel.com>
 <1486724338-5389-1-git-send-email-nicolas.dichtel@6wind.com>
 <1486724338-5389-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170213074931.GA19927@infradead.org>
 <fc363060-f00d-e9e6-c548-6bfe73665e93@6wind.com>
 <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <3539c228-2a1e-f9c3-953d-a755b7c35830@6wind.com>
Date: Mon, 20 Feb 2017 13:58:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, bp@alien8.de, Mason <slash.tmp@free.fr>, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, Michael Ellerman <mpe@ellerman.id.au>, mingo@kernel.org
Message-ID: <20170220125817.imfMc3-h_xguWeFH0fuZ591n-4PBUxc5edKJ0dkWrTo@z>

Le 20/02/2017 à 11:14, Arnd Bergmann a écrit :
> On Mon, Feb 20, 2017 at 10:32 AM, Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>> Le 13/02/2017 à 08:49, Christoph Hellwig a écrit :
>>>> linux/genwqe/..install.cmd
>>>> linux/genwqe/.install
>>>
>>> Third time:  NAK on exporting internal kbuild metadata.
>>>
>> And for the third time: this is not related to this series. Those files are
>> there before my series and the goal of the series has nothing to do with that.
>>
>> Feel free to send a patch.
> 
> Your description literally says "After this patch, the following files, which
> were not exported, are now exported (with make headers_install_all)"
> for the files that Christoph quoted. It that is not true, then you need to
> update the patch description to say what your patch actually does.
That is true. But as I explained when the comment was done the first time (and I
never got any answer), these files are generated in every exported directory.
Because the genwqe directory is now exported, the corresponding '..install.cmd'
and '.install' are generated.
See
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.headersinst#n32
and
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.headersinst#n130
for more details.

In other words, these files are there because some new directories are exported.
If those directories were added to the 'header-y' variable, the result would be
the same.

Regards,
Nicolas
