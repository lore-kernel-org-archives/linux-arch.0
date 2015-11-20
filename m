Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35475 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935105AbbKTNYQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2015 08:24:16 -0500
Received: by qkao63 with SMTP id o63so36131844qka.2
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2015 05:24:15 -0800 (PST)
Date: Fri, 20 Nov 2015 08:24:13 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
In-Reply-To: <4208584.1csaaiK5v3@wuerfel>
Message-ID: <alpine.LFD.2.20.1511200821570.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <3830931.6tMHPeiNRU@wuerfel> <alpine.LFD.2.20.1511191920470.22569@knanqh.ubzr> <4208584.1csaaiK5v3@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1378987080-1448025854=:22569"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151120132413.oDVtO4-uTPEnKdLLIhPvv3YuJDv97DuMell9BD_Z87k@z>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1378987080-1448025854=:22569
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 20 Nov 2015, Arnd Bergmann wrote:

> On Thursday 19 November 2015 19:29:33 Nicolas Pitre wrote:
> > On Thu, 19 Nov 2015, Arnd Bergmann wrote:
> > 
> > > On Monday 16 November 2015 20:20:38 Nicolas Pitre wrote:
> > > > Arnd,
> > > > 
> > > > Please pull the following branch:
> > > > 
> > > >     git://git.linaro.org/people/nicolas.pitre/linux div64
> > > 
> > > Pulled into my asm-generic tree now, it should show up in linux-next
> > > tomorrow.
> > 
> > Thanks.
> > 
> > I removed a small optimization from the top commit that was included by 
> > mistake into a patch that was supposed to produce identical code 
> > (noticed by Måns). It's not urgent but it would be good if you could 
> > repull at some point.
> 
> I already applied another patch on top, could you send a relative
> patch instead? If that ends up being ugly, I can redo the branch,
> but I generally prefer to not rebase things I have on kernel.org that I
> plan to send to Linus.

Alternately we can leave things as they are.  There is no bugs here, 
just that the changelog doesn't exactly describe the change.


Nicolas
--8323328-1378987080-1448025854=:22569--
