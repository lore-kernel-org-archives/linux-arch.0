From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH v7 7/8] uapi: export all headers under uapi directories
Date: Tue, 28 Feb 2017 16:47:40 +0100
Message-ID: <485a42ed-d3d2-f60c-a6ad-21c491fd88dd@6wind.com>
References: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
 <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com>
 <1487954956-23318-8-git-send-email-nicolas.dichtel@6wind.com>
 <56b1003e-1ac9-9ed3-f204-01e609427b98@6wind.com>
 <20170228024844.GA28691@altlinux.org>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228024844.GA28691@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

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
