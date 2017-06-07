From: Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH 03/17] base: fix order of OF initialization
Date: Wed, 7 Jun 2017 11:39:50 -0700
Message-ID: <CAMgXwTiE48KLCJe6TD6VCd5rYASyw0L+pYh8yfvGjhohAfo2dg@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-4-palmer@dabbelt.com> <CAMuHMdXWH5fU8YKfR37D5SMi1GpSk75Bq-OcYmm5ZuHe+XK0PQ@mail.gmail.com>
 <20170607093523.GB29370@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607093523.GB29370@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

It was a while ago that I debugged this. I already reported this bug
to Benjamin Herrenschmidt (now in CC), and I believe he has a patch of
his own to fix the same issue.

As I understand it, of_core_init sets up the OF entries in
/sys/firmware/devicetree. During platform bringup, when the system
describes the cpu + cache hierarchy, it also makes an of_node symlink
into that directory. However, if it doesn't exist yet, you get the
warning.

# ls -l /sys/devices/system/cpu/cpu3/of_node
lrwxrwxrwx    1 root     root             0 Jan  1 00:00
/sys/devices/system/cpu/cpu3/of_node ->
../../../../firmware/devicetree/base/cpus/cpu@3

On Wed, Jun 7, 2017 at 2:35 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jun 07, 2017 at 09:07:20AM +0200, Geert Uytterhoeven wrote:
>> CC devicetree folks
>>
>> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > From: "Wesley W. Terpstra" <wesley@sifive.com>
>> >
>> > This fixes: [    0.010000] cpu cpu0: Error -2 creating of_node link
>> > ... which you get for every CPU on all architectures with a OF cpu/ node.
>
> I take it this means a /cpus node? Or the /cpus/cpu@* nodes?
>
> I'm not seeing this on arm64 when booting v4.12-rc4 with DT, so clearly
> this doesn't affect all such architectures.
>
> What path are these errors happening in?
>
> Thanks,
> Mark.
>
>> >
>> > This affects riscv, nios, etc.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> > ---
>> >  drivers/base/init.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/base/init.c b/drivers/base/init.c
>> > index 48c0e220acc0..0dcd17e561d0 100644
>> > --- a/drivers/base/init.c
>> > +++ b/drivers/base/init.c
>> > @@ -31,9 +31,9 @@ void __init driver_init(void)
>> >         /* These are also core pieces, but must come after the
>> >          * core core pieces.
>> >          */
>> > +       of_core_init();
>> >         platform_bus_init();
>> >         cpu_dev_init();
>> >         memory_dev_init();
>> >         container_dev_init();
>> > -       of_core_init();
>> >  }
>> > --
>> > 2.13.0
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
