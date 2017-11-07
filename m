From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] asm-generic/io.h: remove unnecessary include of
 linux/vmalloc.h
Date: Tue, 7 Nov 2017 11:24:19 +0100
Message-ID: <20171107102418.GI1370@distanz.ch>
References: <20170905112727.13668-1-tklauser@distanz.ch>
 <CAK8P3a3R_12CdsL85tW+Y9cWMuQ0E-CMU9TyseLjj9GczbwnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3R_12CdsL85tW+Y9cWMuQ0E-CMU9TyseLjj9GczbwnhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd

On 2017-09-05 at 17:11:50 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 5, 2017 at 1:27 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> > Including linux/vmalloc.h in asm-generic/io.h isn't necessary since none
> > of the definitions are used in the header itself. Remove the include in
> > order to avoid potential header dependency problems if other headers
> > rely on implict inclusion of linux/vmalloc.h which means that changes
> > there could break unrelated parts.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  include/asm-generic/io.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index b4531e3b2120..d2d3bd163f5f 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -764,7 +764,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
> >
> >  #ifdef __KERNEL__
> >
> > -#include <linux/vmalloc.h>
> >  #define __io_virt(x) ((void __force *)(x))
> >
> >  #ifndef CONFIG_GENERIC_IOMAP
> 
> This seems like a good idea in principle, but I think it needs to be tested
> well before we apply it, to avoid breaking random drivers that forgot to
> add their own includes of that header.
> 
> I've added your patch to my testing queue, but not to the asm-generic
> tree now. We should see if it leads to any randconfig build regressions
> on the architectures I normally test.

Did you see any other breakages caused by this patch in your testing
queue besides the ones you alredy reported/fixed? Would this be
something appropriate to submit during the next merge window? Or at
least to be included in linux-next so it gets some more coverage?

Thanks
Tobias
