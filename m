From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is needed
Date: Mon, 22 Jun 2020 09:22:51 +0200
Message-ID: <CAK8P3a2UVN_p0JFj6mCRR8oig2dyeBF1-WVo_hCdy879Oup9yQ@mail.gmail.com>
References: <20200617092614.7897ccb2@canb.auug.org.au> <20200617092747.0cadb2de@canb.auug.org.au>
 <20200617055843.GB25631@kroah.com> <20200617161810.256ff93f@canb.auug.org.au> <20200622142512.702bdc68@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:51895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731310AbgFVHXK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 03:23:10 -0400
In-Reply-To: <20200622142512.702bdc68@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux-kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Mon, Jun 22, 2020 at 6:25 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Wed, 17 Jun 2020 16:18:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Wed, 17 Jun 2020 07:58:43 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote:
> > > > This is in preparation for removing the include of major.h where it is
> > > > not needed.
> > > >
> > > > These files were found using
> > > >
> > > >   grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> > > >
> > > > where /tmp/xx contains all the symbols defined in major.h.  There were
> > > > a couple of files in that list that did not need the include since the
> > > > references are in comments.
> > > >
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > >
> > > Any reason this had an RFC, but patch 2/2 did not?
> >
> > I forgot :-)  I added RFC just to hopefully get some attention as this
> > is just the start of a long slow use of my "spare" time.
> >
> > > They look good to me, I will be glad to take these, but do you still
> > > want reviews from others for this?  It seems simple enough to me...
> >
> > Yeah, well, we all know the simplest patches usually cause the most pain :-)
> >
> > However, I have been fairly careful and it is an easy include file to
> > work with.  And I have done my usual build checks, so the linux-next
> > maintainer won't complain about build problems :-)
> >
> > I would like to hear from Arnd, at least, as I don't want to step on
> > his toes (he is having a larger look at our include files).
>
> Any comment?

I now have a set of regex/header file pairs and a script that automatically
adds the #include statements to any source file that needs them as a
preparation for a larger-scale cleanup. Your change is going in the
same direction, and linux/major.h is a header that was not on my list
yet, so I'm completely happy with this.

One thing that I did differently in my script is to insert the new #include
statement in a way that retains alphabetical ordering of the other inclusions
rather than adding it at the end.

If the headers were not sorted before, it just tries a trivial nearest match,
adding it somewhat randomly, but it would still avoid some clashes with
patches that add different headers at the end or that add the same header
using the same method.

      Arnd
