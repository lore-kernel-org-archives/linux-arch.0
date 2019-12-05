From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing crash)
Date: Thu, 5 Dec 2019 12:02:13 +0100
Message-ID: <CAK8P3a1krE=nOi6Dy=QaWiE9VTgNpUVbrHUVm_3Cq+JGJyuwKQ@mail.gmail.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com> <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com> <20191204161641.GA28130@roeck-us.net>
 <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com> <CAAdtpL71ED3zbkHMqtd1XFQwToOctWJpy2WPqahxHR81fKdTkg@mail.gmail.com>
 <a391048e-f57c-159e-7174-d9d38d8f3825@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a391048e-f57c-159e-7174-d9d38d8f3825@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Guenter Roeck <linux@roeck-us.net>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 5, 2019 at 11:00 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Philippe,
>
> On 05/12/2019 09:42, Philippe Mathieu-Daudé wrote:
> > There are only 2 "Investigated-by" vs 7k+ "Suggested-by"... Is there a
> > real difference?
>
> Not sure about that. My take is that Suggested-by is used when someone suggests
> you how to possibly implement a feature and you go and do that. Investigated-by
> is when there is a fix to make and someone comes to you with the exact solution
> like in this case Arnd did.

It's not a standard tag, but I suggested it because it does explain
better what I did.

You could also just explain in clear text that I did the analysis and then add
the more normal Suggested-by tag, I don't care either way.

      Arnd
