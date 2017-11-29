From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v2 31/35] earlycon: add reg-offset to physical address
 before mapping
Date: Wed, 29 Nov 2017 13:40:16 +0800
Message-ID: <CAEbi=3enx6tyuBmOygo3=gGa0HC+uit+gm3D=Thbyuv2hV=F0g@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5b5f07ffd75d509a661398d02d6f1336156554ae.1511785528.git.green.hu@gmail.com>
 <20171128142507.GA17797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171128142507.GA17797@kroah.com>
Sender: netdev-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

2017-11-28 22:25 GMT+08:00 Greg KH <greg@kroah.com>:
> On Mon, Nov 27, 2017 at 08:28:18PM +0800, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> It will get the wrong virtual address because port->mapbase is not added
>> the correct reg-offset yet. We have to update it before earlycon_map()
>> is called
>> ---
>>  drivers/tty/serial/earlycon.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> No signed-off-by line?

Sorry I forget it.
Signed-off-by: Greentime Hu <greentime@andestech.com>

I will add it in the next version patch.
