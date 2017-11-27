From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 34/35] clocksource/drivers/Kconfig: Support andestech
 atcpit100 timer
Date: Mon, 27 Nov 2017 15:11:31 +0100
Message-ID: <CAK8P3a2ovDuwWCq2HABZaCVGO04TX0VdgnQbK65RvHhsMEzsiw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Rick Chen <rickchen36@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Rick Chen <rickchen36@gmail.com>
>
> Add CLKSRC_ATCPIT100 for Andestech atcpit100 timer selection.
> It often be used in Andestech AE3XX platform.
>
> Signed-off-by: Rick Chen <rickchen36@gmail.com>
> Signed-off-by: Greentime Hu <green.hu@gmail.com>

No need to split out the Makefile patch from the actual driver, they
clearly belong together.
The binding change should be a separate patch, as you did.

It's probably best to separate the driver patches from the
architecture submission
in the future, they can simply get merged by the respective subsystem
maintainers,
with a smaller Cc list.

      Arnd
