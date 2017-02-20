Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35010 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdBTKOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2017 05:14:39 -0500
MIME-Version: 1.0
In-Reply-To: <fc363060-f00d-e9e6-c548-6bfe73665e93@6wind.com>
References: <201702022242.toNVsxyq%fengguang.wu@intel.com> <1486724338-5389-1-git-send-email-nicolas.dichtel@6wind.com>
 <1486724338-5389-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170213074931.GA19927@infradead.org> <fc363060-f00d-e9e6-c548-6bfe73665e93@6wind.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Feb 2017 11:14:38 +0100
Message-ID: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] uapi: export all headers under uapi directories
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Christoph Hellwig <hch@infradead.org>, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, bp@alien8.de, Mason <slash.tmp@free.fr>, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, Michael Ellerman <mpe@ellerman.id.au>, mingo@kernel.org
Message-ID: <20170220101438.6ayTbaqH81AbilTUvQuAuAiKnpSb6IbRSnLtKxleM90@z>

On Mon, Feb 20, 2017 at 10:32 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> Le 13/02/2017 =C3=A0 08:49, Christoph Hellwig a =C3=A9crit :
>>> linux/genwqe/..install.cmd
>>> linux/genwqe/.install
>>
>> Third time:  NAK on exporting internal kbuild metadata.
>>
> And for the third time: this is not related to this series. Those files a=
re
> there before my series and the goal of the series has nothing to do with =
that.
>
> Feel free to send a patch.

Your description literally says "After this patch, the following files, whi=
ch
were not exported, are now exported (with make headers_install_all)"
for the files that Christoph quoted. It that is not true, then you need to
update the patch description to say what your patch actually does.

    Arnd
