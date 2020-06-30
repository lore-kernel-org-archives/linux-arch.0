From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is
 needed
Date: Tue, 30 Jun 2020 10:45:22 +0200
Message-ID: <20200630084522.GB637565@kroah.com>
References: <20200617092614.7897ccb2@canb.auug.org.au>
 <20200617092747.0cadb2de@canb.auug.org.au>
 <20200617055843.GB25631@kroah.com>
 <20200630091203.55cdd5d9@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbgF3Ip0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jun 2020 04:45:26 -0400
Content-Disposition: inline
In-Reply-To: <20200630091203.55cdd5d9@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, Jun 30, 2020 at 09:12:03AM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Wed, 17 Jun 2020 07:58:43 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote:
> > > This is in preparation for removing the include of major.h where it is
> > > not needed.
> > > 
> > > These files were found using
> > > 
> > > 	grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> > > 
> > > where /tmp/xx contains all the symbols defined in major.h.  There were
> > > a couple of files in that list that did not need the include since the
> > > references are in comments.
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>  
> > 
> > Any reason this had an RFC, but patch 2/2 did not?
> > 
> > They look good to me, I will be glad to take these, but do you still
> > want reviews from others for this?  It seems simple enough to me...
> 
> I am going to do another round of this patchset splitting out most of
> the "safe" removals that can be done anytime so other maintainers can
> take them.  Then there will be the left over order dependent changes at
> the end.

Ok, I'll wait for the next round of patches, thanks.

greg k-h
