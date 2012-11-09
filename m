From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 31/40] char: don't build rtc or genrtc on METAG
Date: Fri, 9 Nov 2012 14:38:41 +0000
Message-ID: <201211091438.41231.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <20121101153949.GA8529@kroah.com> <5092B277.7080805@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61085 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab2KIOin (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 09:38:43 -0500
In-Reply-To: <5092B277.7080805@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org

On Thursday 01 November 2012, James Hogan wrote:
> On 01/11/12 15:39, Greg KH wrote:
> > On Wed, Oct 31, 2012 at 04:14:12PM +0000, James Hogan wrote:
> >> The metag architecture doesn't have a PC RTC or implement the RTC
> >> interface that genrtc expects, so add METAG to the list of architectures
> >> not to build RTC or GEN_RTC on.
> >>
> >> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> >> ---
> >>  drivers/char/Kconfig |    5 +++--
> >>  1 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> >> index ea6f632..09b64a8 100644
> >> --- a/drivers/char/Kconfig
> >> +++ b/drivers/char/Kconfig
> >> @@ -283,7 +283,8 @@ if RTC_LIB=n
> >>  config RTC
> >>      tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
> >>      depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> >> -                    && !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> >> +                    && !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN \
> >> +                    && !UML && !METAG
> > 
> > This is getting huge, would it be easier to reverse it and just list the
> > arches that it does work for?
> 
> Hi Greg,
> 
> Yes, I think I agree.
> 
> I'll probably also squash together all these similar !METAG patches into
> one for v2.

Since I made a similar comment for another patch, and I now saw that you
have more of these, let's start to rethink this from teh beginning.

We have a bunch of "PC-style" I/O drivers: parport_pc, vga, i8042,
legacy-rtc, floppy and maybe some more. these usually come together
or not at all, so I think it would be good to have a CONFIG_LEGACY_PC_IO
symbol that all architectures select if they have the majority of the
above, and then we can use variants of the other symbols for the
exceptions.

	Arnd
