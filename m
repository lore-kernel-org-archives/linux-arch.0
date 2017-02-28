Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34290 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdB1Psb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2017 10:48:31 -0500
Received: by mail-wr0-f176.google.com with SMTP id l37so11604215wrc.1
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2017 07:47:44 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v7 7/8] uapi: export all headers under uapi directories
References: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
 <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com>
 <1487954956-23318-8-git-send-email-nicolas.dichtel@6wind.com>
 <56b1003e-1ac9-9ed3-f204-01e609427b98@6wind.com>
 <20170228024844.GA28691@altlinux.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <485a42ed-d3d2-f60c-a6ad-21c491fd88dd@6wind.com>
Date: Tue, 28 Feb 2017 16:47:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170228024844.GA28691@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de
Message-ID: <20170228154740.cylcjOyuAnLxF8cgzXgnoqSw_B6956UQwZgSnB0TB3w@z>

Le 28/02/2017 à 03:48, Dmitry V. Levin a écrit :
> On Mon, Feb 27, 2017 at 05:01:55PM +0100, Nicolas Dichtel wrote:
[snip]
>> Is there any chance to get this series in before the rc1?
> 
> Note that the following newly exported headers have userspace compilation
> errors:
> 
> /usr/include/drm/armada_drm.h:26:2: error: unknown type name 'uint32_t'
>   uint32_t handle;
> 
> /usr/include/linux/btrfs_tree.h:390:12: error: 'BTRFS_UUID_SIZE' undeclared here (not in a function)
>   __u8 uuid[BTRFS_UUID_SIZE];
> 
> /usr/include/linux/cryptouser.h:58:16: error: 'CRYPTO_MAX_ALG_NAME' undeclared here (not in a function)
>   char cru_name[CRYPTO_MAX_ALG_NAME];
> 
> /usr/include/linux/kfd_ioctl.h:33:2: error: unknown type name 'uint32_t'
>   uint32_t major_version; /* from KFD */
> 
> /usr/include/linux/smc_diag.h:6:27: fatal error: rdma/ib_verbs.h: No such file or directory
>  #include <rdma/ib_verbs.h>
> 
> /usr/include/linux/wil6210_uapi.h:73:2: error: unknown type name 'uint32_t'
>   uint32_t op; /* enum wil_memio_op */
> 
> I think they should be fixed first.
Sure. Thanks for pointing this out. I will send a v8.

I'm still wondering if Michal will take this series or if it will go through
another tree.


Regards,
Nicolas
