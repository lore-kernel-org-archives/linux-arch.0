From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 25/31] nds32: defconfig
Date: Thu, 9 Nov 2017 16:00:30 +0800
Message-ID: <CAEbi=3dvkAs8=gpjtaKKBOa2MkQb1bh87q4nEsWxNuWn_1SxUw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <805f8432979e2707fbc9bf62dc52b8abfbd2cb14.1510118606.git.green.hu@gmail.com>
 <CAK8P3a0XciTazM7OewyRV+92J0JgfbpvXJ5jizNcoL3LV=XOOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0XciTazM7OewyRV+92J0JgfbpvXJ5jizNcoL3LV=XOOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com
List-Id: linux-arch.vger.kernel.org

2017-11-08 18:03 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  arch/nds32/configs/ae3xx_defconfig  |  110 +++++++++++++++++++++++++++++++++++
>>  arch/nds32/configs/ag101p_defconfig |  109 ++++++++++++++++++++++++++++++++++
>
> Are those two incompatible? I would recommend starting without board
> specific defconfig
> files, it just gets messy once you get more than a few machines you
> want to support.

Thanks.
These 2 are incompatible.
They use different drivers. I may still keep these 2 defconfigs.

>> diff --git a/arch/nds32/configs/ae3xx_defconfig b/arch/nds32/configs/ae3xx_defconfig
>> new file mode 100644
>> index 0000000..14d49a3
>> --- /dev/null
>> +++ b/arch/nds32/configs/ae3xx_defconfig
>> @@ -0,0 +1,110 @@
>> +CONFIG_CROSS_COMPILE="nds32le-linux-"
>> +CONFIG_SYSVIPC=y
>> +CONFIG_POSIX_MQUEUE=y
>> +CONFIG_HIGH_RES_TIMERS=y
>> +CONFIG_BSD_PROCESS_ACCT=y
>> +CONFIG_BSD_PROCESS_ACCT_V3=y
>> +CONFIG_IKCONFIG=y
>> +CONFIG_IKCONFIG_PROC=y
>> +CONFIG_LOG_BUF_SHIFT=14
>> +CONFIG_NAMESPACES=y
>> +CONFIG_USER_NS=y
>> +CONFIG_RELAY=y
>> +CONFIG_BLK_DEV_INITRD=y
>> +CONFIG_SYSCTL_SYSCALL=y
>> +CONFIG_KALLSYMS_ALL=y
>> +CONFIG_EMBEDDED=y
>
> You usually don't want to select 'CONFIG_EMBEDDED' for regular
> builds, it's should only be needed to disable options that are
> usually considered essential.

Thanks.
I will remove this config in the next version patch.

>> +CONFIG_FB=y
>> +# CONFIG_VGA_CONSOLE is not set
>> +CONFIG_FRAMEBUFFER_CONSOLE=y
>
> You have a framebuffer console here, but no framebuffer driver?

Thanks.
I shall enable it when I push our framebuffer in the next time.
I will disable it in the next version patch.

>> +CONFIG_MMC=y
>> +CONFIG_RTC_CLASS=y
>> +# CONFIG_RTC_HCTOSYS is not set
>> +CONFIG_CLKSRC_ATCPIT100=y
>> +CONFIG_EXT2_FS=y
>
> Maybe use EXT4, not EXT2, in the defconfig?
>

Thanks.
I will enable EXT4 instead of EXT2 in the defconfig.
