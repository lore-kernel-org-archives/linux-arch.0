Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53162 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaAXCVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2014 21:21:40 -0500
Date: Thu, 23 Jan 2014 21:21:55 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 59/73] drivers/gpio: delete non-required instances of
 include <linux/init.h>
Message-ID: <20140124022154.GA13428@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-60-git-send-email-paul.gortmaker@windriver.com>
 <CACRpkdYk6cOO-JZbe887ihJaWE5JMjuXm3EVcZmE1jCeL2BODQ@mail.gmail.com>
 <20140124095827.1ee8ddcfed8d1c8e0a6d3dbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20140124095827.1ee8ddcfed8d1c8e0a6d3dbd@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Message-ID: <20140124022155.Noo5gSOVCayREGZXY6vcZG3NDDWUuepovsjleeMr9xA@z>

[Re: [PATCH 59/73] drivers/gpio: delete non-required instances of include <linux/init.h>] On 24/01/2014 (Fri 09:58) Stephen Rothwell wrote:

> Hi Linus,
> 
> On Thu, 23 Jan 2014 09:12:43 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Tue, Jan 21, 2014 at 10:23 PM, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > 
> > > None of these files are actually using any __init type directives
> > > and hence don't need to include <linux/init.h>.  Most are just a
> > > left over from __devinit and __cpuinit removal, or simply due to
> > > code getting copied from one driver to the next.
> > >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Alexandre Courbot <gnurou@gmail.com>
> > > Cc: linux-gpio@vger.kernel.org
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> > Patch applied for v3.15.
> 
> Yet that patch is in linux-next today.  And just 2 days ago I mailed out this request (as I do during each merge window):
> 
> "Please do not add any code intended for v3.15 to your linux-next included
> trees until after v3.14-rc1 has been released."
> 
> I have no problem with that particular patch being sent to Linus during
> this merge window (in fact Paul intends to send whatever is left of the
> series at the end of the merge window), but it makes me wonder about the
> other commits that you have added to the gpio tree (and the pinctrl tree)
> today.  Are they intended for this merge window or v3.15?

For what it is worth, I'm not removing any patches from my series file
until they explicitly conflict and/or become redundant.  If a maintainer
says they are adding the patch, I add a comment in the series file, but
I don't remove them until I see them come into next via another branch,
and/or sfr reports a conflict/redundancy.

Thanks,
Paul.
--

> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au


