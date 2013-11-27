From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
Date: Wed, 27 Nov 2013 15:32:45 +0000
Message-ID: <20131127153245.2B56EC404EC@trevor.secretlab.ca>
References: <5283A000.8090007@gmail.com> < CAMuHMdXfsB_Ewz9sUPZaAjFaQGTGeqMiD8mJ0tCoH1uFLYGoxw@mail.gmail.com> < 20131121155348.66751C406A3@trevor.secretlab.ca> < CAMuHMdXjROx-LqNkq_GhNp4M-iYvDXV6X4j7EkgQGdkUmAMvhg@mail.gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXjROx-LqNkq_GhNp4M-iYvDXV6X4j7EkgQGdkUmAMvhg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 21 Nov 2013 18:49:08 +0100, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, Nov 21, 2013 at 4:53 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> >> My changes don't change the current behavior much: currently
> >> early_init_dt_scan() is already called with &__dtb_start in several places.
> >> If this is broken, it's already broken.
> >
> > Yes, but it is called on platforms that already make that assumption
> > that __dtb_start must be copied and therefore call
> > unflatten_and_copy_devicetree(). This change makes *all* platforms do
> > that. That breaks arm, arm64, c6x, microblaze, some mips platforms, and
> > powerpc!
> 
> arm, arm64, and powerpc don't have builtin DTBs, hence no change.
> microblaze and c6x already did "early_init_devtree(&__dtb_start)" before.
> 
> That leaves mips, which has DT handling in too many variants, which I
> didn't all verify.
> 
> >> > memory. The dtb section can also potentially contain multiple .dtb
> >> > blobs. In the use case that you care about you are probably only
> >>
> >> Multiple dtb blobs are currently handled in platform-specific code, which
> >> passes the right dtb to early_init_dt_scan().
> >
> > The problem is that it makes the default dt completely random because
> > the generic code still deferrences __dtb_start.
> 
> Only if no DT was passed by the bootloader. And only if there really
> is something at __dtb_start. Before it would fail if no DTB was passed
> by the bootloader.
> 
> >> > thinking about one, but it is entirely possible for device drivers to
> >> > have a dtb linked in which may break this if it gets linked in a
> >> > different order. The specific example I'm thinking about is I want to
> >> > have the DT selftest code load an overlay to get testcase data from a
> >> > dtb blob.
> >> >
> >> > The other concern I have here is that I don't really want this to be the
> >> > default on a lot of platforms. ARM and PowerPC for instance should only
> >> > get the default dtb from the boot wrapper. It needs to be configurable
> >> > in some way.
> >>
> >> On ARM and PowerPC, the section is empty, hence &__dbt_start ==
> >> &__dtb_end.
> >
> > There is no guarantee that that will always be so. The patch makes some
> > poor assumtions, but they shouldn't be difficult to fix.
> 
> OK, how to proceed?

Add a global flag, bool __init of_dtb_needs_copy, and make it default to
false. On platforms that need it, change it to true. Make
unflatten_device_tree() check the flag and copy the tree if necessary.
Make early_init_dt_scan() set the flag if it choses to use a default
built-in tree. Then get rid of unflatten_and_copy_devicetree() because
it has become redundant.

Finally, make an explicit backup __dtb pointer.  Don't assume that
__dtb_start == __dtb_end is the correct test. We never want to have that
behavour on arm/powerpc/microblaze, but that doesn't mean there won't be
compiled in dtbs for other reasons. Create a __dtb_default symbol
require platforms to do something specific (ie. select a config symbol)
to set it to __dtb_start. It's not perfect, but at least it acknowledges
the problem and can be refined later.

g.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
