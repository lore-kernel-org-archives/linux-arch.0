From: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] All Arch: remove linkage for sys_nfsservctl system call
Date: Wed, 31 Aug 2011 09:46:52 -0400
Message-ID: <20110831134652.GA16897@fieldses.org>
References: <1312810169.2591.1153.camel@deadeye>
 <20110808155538.GB904@fieldses.org>
 <20110808180658.GC29924@decadent.org.uk>
 <20110826220311.GA18140@fieldses.org>
 <20110830085752.6db1ffa600f4c82135b3f3eb@canb.auug.org.au>
 <20110830091150.176cd08c@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110830091150.176cd08c-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 30, 2011 at 09:11:50AM +1000, NeilBrown wrote:
> On Tue, 30 Aug 2011 08:57:52 +1000 Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
> wrote:
> 
> > Hi Bruce,
> > 
> > On Fri, 26 Aug 2011 18:03:11 -0400 "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org> wrote:
> > >
> > > From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> > > 
> > > The nfsservctl system call is now gone, so we should remove all
> > > linkage for it.
> > > 
> > > Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> > > Signed-off-by: J. Bruce Fields <bfields-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > ---
> > > 
> > > I don't normally have to deal with this kind of cross-architecture
> > > patch; is this the right etiquette for it?
> > 
> > It turns out (with hindsight) that my reaction to this patch should have
> > been:
> > 
> > If you haven't built this on all architectures (an noone expects you to
> > actually do that), then it should spend a day or two in linux-next before
> > being sent to Linus.
> > 
> 
> Hi Stephen,
>  Thanks for your help in sorting this out.  I have no idea how I missed those
>  few nfsservctl references but I clearly did and you and -next have proved
>  valuable yet again.
> 
>  And really *everything* should spend a few days in linux-next before going
>  to Linus.  We all know that but it sometimes seem hard to *do* that ....
>  until we have learnt the hard way a couple of times :-(

Yes, sorry, I'll know not to skip -next, next time....

(My excuse: I've been advertising to -next only stuff that I've done
with and committed, and this was something I wasn't even sure I should
take.

But I could have either mailed it out labelled as [RFC], or stuck it in
a throwaway branch to merge into my -next branch.)

Apologies again, and thanks for dealing with it so promptly.

--b.
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
