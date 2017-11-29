From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v2 25/35] nds32: Build infrastructure
Date: Wed, 29 Nov 2017 16:39:51 +0800
Message-ID: <CAEbi=3c=hTCcUOPs+Fc10srzTFsB4MnVxgcFydz12-jH0ZXjog@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
 <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

2017-11-27 22:21 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
>> new file mode 100644
>> index 0000000..6b4013f
>> --- /dev/null
>> +++ b/arch/nds32/Kconfig.cpu
>> @@ -0,0 +1,131 @@
>> +comment "Processor Features"
>> +
>> +config CPU_BIG_ENDIAN
>> +       bool "Big endian"
>> +       def_bool n
>> +
>> +config CPU_LITTLE_ENDIAN
>> +       bool "Little endian"
>> +       def_bool y
>
> These must be mutually exclusive, you surely get some build error if you try to
> set both here.
>
> You can either make it a 'choice' statement to pick between the two, or you
> can make CPU_LITTLE_ENDIAN a silent option like
>
> config CPU_BIG_ENDIAN
>        bool "Big endian"
>
> config CPU_LITTLE_ENDIAN
>        def_bool !CPU_BIG_ENDIAN
>

Thanks. I will fix it in the next version patch.

>> +config CPU_CACHE_NONALIASING
>> +       bool "Non-aliasing cache"
>> +       help
>> +         If this CPU is using VIPT data cache and its cache way size is larger
>> +         than page size, say N. If it is using PIPT data cache, say Y.
>> +
>> +         If unsure, say Y.
>
> Can you determine this from the CPU type?

There is no cpu register to determine it. It also depeneds on page
size and way size however page size is configurable by software.
These codes are determined at compile time will be benefit to code
size and performance.
IMHO, I think it would be better to be determined here.

>> +choice
>> +       prompt "Memory split"
>> +       depends on MMU
>> +       default VMSPLIT_3G
>> +       help
>> +         Select the desired split between kernel and user memory.
>> +
>> +         If you are not absolutely sure what you are doing, leave this
>> +         option alone!
>> +
>> +       config VMSPLIT_3G
>> +               bool "3G/1G user/kernel split"
>> +       config VMSPLIT_3G_OPT
>> +               bool "3G/1G user/kernel split (for full 1G low memory)"
>> +       config VMSPLIT_2G
>> +               bool "2G/2G user/kernel split"
>> +       config VMSPLIT_1G
>> +               bool "1G/3G user/kernel split"
>> +endchoice
>
> I think you mentioned that the 1GB configuration is quite common, how
> about making VMSPLIT_3G_OPT the default here?

We use 1GB in our fpga platform, but I am not sure our customer's
config and their user space program may use bigger memory space.
Anyway, we will discuss it to decide the default value.
Thanks for your suggestion.
