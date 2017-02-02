From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH v5 7/8] uapi: export all headers under uapi directories
Date: Thu, 2 Feb 2017 16:42:22 +0100
Message-ID: <a1b90223-6178-50e6-27ee-9e9a610c09e5@6wind.com>
References: <201702022242.toNVsxyq%fengguang.wu@intel.com>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36867 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdBBPm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2017 10:42:27 -0500
Received: by mail-wm0-f48.google.com with SMTP id v77so93223699wmv.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2017 07:42:26 -0800 (PST)
In-Reply-To: <201702022242.toNVsxyq%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org

Le 02/02/2017 à 15:47, kbuild test robot a écrit :
> Hi Nicolas,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.10-rc6]
> [cannot apply to next-20170202]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicolas-Dichtel/uapi-export-all-headers-under-uapi-directories/20170202-213944
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> Note: the linux-review/Nicolas-Dichtel/uapi-export-all-headers-under-uapi-directories/20170202-213944 HEAD fec8d2b493885de70b229c7ce5bf917dc92ddb9f builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>>> ./usr/include/asm/unistd.h:8: included file 'asm-x86/unistd_32.h' is not exported
>>> ./usr/include/asm/unistd.h:10: included file 'asm-x86/unistd_x32.h' is not exported
>>> ./usr/include/asm/unistd.h:12: included file 'asm-x86/unistd_64.h' is not exported
I don't reproduce this error, it compiles on my target (gcc 4.9.2).


Regards,
Nicolas
