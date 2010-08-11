From: Dave Airlie <airlied@redhat.com>
Subject: Re: asm/vga.h (was: Re: drm: Add support for platform devices to
	register as DRM devices)
Date: Thu, 12 Aug 2010 09:17:58 +1000
Message-ID: <1281568678.4765.10.camel@clockmaker-el6>
References: <AANLkTik44qbia+7w9=83cboTMLbvQDcH-60dHuAnd9ax@mail.gmail.com>
	<1281477066.17843.3015.camel@atropine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1281477066.17843.3015.camel@atropine>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Adam Jackson <ajax@redhat.com>
Cc: linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2010-08-10 at 17:51 -0400, Adam Jackson wrote:
> On Tue, 2010-08-10 at 22:35 +0200, Geert Uytterhoeven wrote:
> 
> > Now, do we really need <asm/vga.h>? It seems I can make it build and boot using:
> > 

I think we can drop asm/vga.h on all platforms, I'll queue a patch up
for drm-next to see if we hit any problems, it works on x86 at least.

Dave.

> > --- a/include/linux/vgaarb.h
> > +++ b/include/linux/vgaarb.h
> > @@ -31,7 +31,9 @@
> >  #ifndef LINUX_VGA_H
> >  #define LINUX_VGA_H
> > 
> > +#ifdef CONFIG_VGA_ARB
> >  #include <asm/vga.h>
> > +#endif
> > 
> >  /* Legacy VGA regions */
> >  #define VGA_RSRC_NONE         0x00
> 
> That seems fine.
> 
> - ajax
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
