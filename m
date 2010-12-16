From: Nick Piggin <npiggin@kernel.dk>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Thu, 16 Dec 2010 13:34:38 +1100
Message-ID: <20101216023438.GA3216@amd>
References: <20101209070938.GA3949@amd>
 <AANLkTim=Hd_xhk4egrTq96rk0eCQRWOxEjcfxM53HwXq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:46750 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754953Ab0LPCeo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Dec 2010 21:34:44 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim=Hd_xhk4egrTq96rk0eCQRWOxEjcfxM53HwXq@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Nick Piggin <npiggin@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, Dec 15, 2010 at 03:09:26PM -0800, Tony Luck wrote:
> On Wed, Dec 8, 2010 at 11:09 PM, Nick Piggin <npiggin@kernel.dk> wrot=
e:
> > +static inline int dentry_memcmp(const unsigned char *cs,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const=
 unsigned char *ct, size_t count)
> > +{
> > + =A0 =A0 =A0 while (count) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D (*cs !=3D *ct);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ct++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 return 0;
> > +}
>=20
> Since you are proposing a routine that only compares file
> names - I wonder whether it would be faster to start at the
> end and work backwards? If the filenames are the same,
> it makes no difference - you have to look at all the bytes.
> But if they are different you might bail out earlier. There
> are many applications that stick a common prefix onto
> the start of filenames (just look in "/lib" !), but I think it is
> less common to add a suffix (longer than "." single letter).

That's true, and an interesting point. However I have managed to fit
the first 8 bytes of the name (in the case of shortnames) into the
same single dentry cacheline that is used for path walking. So that
might negate some of the benefits of walking backwards.

I would encourage anybody to grab the branch and try out any tweaks,
though...
