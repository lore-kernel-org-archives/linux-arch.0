Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36859 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdAWQDI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2017 11:03:08 -0500
Received: by mail-wm0-f52.google.com with SMTP id c85so139500165wmi.1
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2017 08:03:08 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v4 6/7] uapi: export all headers under uapi directories
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-7-git-send-email-nicolas.dichtel@6wind.com>
 <20170123152508.GA12899@infradead.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <ab8be0a4-a89a-e2d9-2a55-0901e792f8a5@6wind.com>
Date: Mon, 23 Jan 2017 17:03:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170123152508.GA12899@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, mpe@ellerman.id.au
Message-ID: <20170123160304.6e2DPHOD8nH9I0oKHT_s7lomtAPaeMm_KiC0LVMTNZE@z>

Le 23/01/2017 à 16:25, Christoph Hellwig a écrit :
>> .install
> 
>> linux/genwqe/.install
>> linux/genwqe/..install.cmd
> 
> ...
> 
> If these aren't just a mistake in your list the patches need to be
> fixed not to install this build system internal file.
> 
> And I'm pretty sure I already pointed this out last time.
> 
Yes, it was already pointed out. But, as I said, this is done for *every*
exported directory. My patch just follows how it is done currently:
$ find . -name '.install' | wc -l
105
$ find . -name '..install.cmd' | wc -l
105
$ find . -type d | wc -l
105

I'm not against removing these files, but this should be done in another patch,
it's not related to this series.
Fell free to send a patch.


Regards,
Nicolas
