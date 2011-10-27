From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
Date: Thu, 27 Oct 2011 15:29:40 +0200
Message-ID: <CAJaTeTp_jv-b1GUEswfFzn=joj=jkMHE91zK1wnDksH60GT6Dg@mail.gmail.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1319720503-3183-1-git-send-email-vapier@gentoo.org>
	<20111027131124.GK19187@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111027131124.GK19187@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux@lists.openrisc.net, Grant Likely <grant.likely@secretlab.ca>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au, linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 27, 2011 at 15:11, Russell King - ARM Linux wrote:
> On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
>> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
>> index d494001..622851c 100644
>> --- a/include/asm-generic/gpio.h
>> +++ b/include/asm-generic/gpio.h
>> @@ -170,6 +170,29 @@ extern int __gpio_cansleep(unsigned gpio);
>>
>> =A0extern int __gpio_to_irq(unsigned gpio);
>>
>> +#ifndef gpio_get_value
>> +#define gpio_get_value(gpio) __gpio_get_value(gpio)
>> +#endif
>> +
>> +#ifndef gpio_set_value
>> +#define gpio_set_value(gpio, value) __gpio_set_value(gpio, value)
>> +#endif
>> +
>> +#ifndef gpio_cansleep
>> +#define gpio_cansleep(gpio) __gpio_cansleep(gpio)
>> +#endif
>> +
>> +#ifndef gpio_to_irq
>> +#define gpio_to_irq(gpio) __gpio_to_irq(gpio)
>> +#endif
>> +
>> +#ifndef irq_to_gpio
>> +static inline int irq_to_gpio(unsigned int irq)
>> +{
>> + =A0 =A0 return -EINVAL;
>> +}
>> +#endif
>> +
>
> This is extremely dangerous. =A0Consider for example this code
> (see ARM mach-davinci's gpio.h):
> ...
> This is why I didn't solve this using the preprocessor method in ARM, but
> instead used __ARM_GPIOLIB_COMPLEX to control whether these definitions
> are required.

i thought the arm mach were defining things already, but i guess i
missed some in my review

easy enough to glue the arm-specific world to the asm-generic world
... a bit ugly, but should work i think:
#ifndef __ARM_GPIOLIB_COMPLEX
/* assume the mach has defined this */
#ifndef gpio_get_value
#define gpio_get_value gpio_get_value
#endif
#ifndef gpio_set_value
#define gpio_set_value gpio_set_value
#endif
#ifndef gpio_cansleep
#define gpio_cansleep gpio_cansleep
#endif
#ifndef gpio_to_irq
#define gpio_to_irq gpio_to_irq
#endif
#ifndef irq_to_gpio
#define irq_to_gpio irq_to_gpio
#endif
...

the next step might be to drill down into the arm mach's and sprinkle
the defines into the parts that need it ...
-mike
