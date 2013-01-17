From: Steven King <sfking@fdwdc.com>
Subject: Re: [PATCH 0/4] gpio: introduce descriptor-based interface
Date: Thu, 17 Jan 2013 08:50:43 -0800
Message-ID: <201301170850.43655.sfking@fdwdc.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
 <50F7E83E.8000105@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50F7E83E.8000105@uclinux.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Ungerer <gerg@uclinux.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Alex Courbot <acourbot@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-arch.vger.kernel.org

On Thursday 17 January 2013 4:02:06 am Greg Ungerer wrote:
> Hi Linus,
>
> (My gerg@snapgear.com email no longer gets to me, gerg@uclinux.org is
> the best direct email for me now).
>
> On 01/17/2013 09:15 PM, Linus Walleij wrote:
> > On Thu, Jan 10, 2013 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> I've tried to find platforms that don't yet use GPIOLIB and fortunately
> >> there are very few left:
> >>
> >> I found two that provide the generic gpio interfaces when gpiolib
> >> is disabled, but use gpiolib otherwise for the same hardware,
> >> arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
> >> I would assume that we can simply remove the non-gpiolib shortcut
> >> here at cost of a small overhead.
> >
> > Geert/Greg: interested in looking into this issue?
> >
> > The GPIO maintainers want to get rid of non-gpiolib platforms.
>
> Steven King did most of the ColdFire GPIO work (CC'ed on this).
> Steven: are you happy to drop the non-gpiolib support?
>
> Regards
> Greg

Well, my concern is the small, single chip platforms with limited ram and 
speeds measured in MHz.  My goal was that these platforms that had very basic 
gpio needs, no offboard gpio, just toggling a few pins for spi or whatever, 
could do that without pulling in a bunch of code they dont need.  I realize 
that for x86 or arm people with their giga Hz cpus with gigabytes of ram, its 
no big deal, but my little 60 MHz coldfire v2s with only 16 megs of ram (and 
even more constraining, 2 megs of flash) need all the help they can get.

I haven't been keeping up with the kernel list of late, can someone point me 
to what''s being discussed so I can see what were talking about here?
