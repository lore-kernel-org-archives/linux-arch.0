From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Date: Thu, 19 Nov 2015 19:29:33 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511191920470.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <3830931.6tMHPeiNRU@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-650366564-1447979374=:22569"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34978 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759371AbbKTA3g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 19:29:36 -0500
Received: by qkao63 with SMTP id o63so31682613qka.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2015 16:29:35 -0800 (PST)
In-Reply-To: <3830931.6tMHPeiNRU@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-650366564-1447979374=:22569
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 19 Nov 2015, Arnd Bergmann wrote:

> On Monday 16 November 2015 20:20:38 Nicolas Pitre wrote:
> > Arnd,
> > 
> > Please pull the following branch:
> > 
> > 	git://git.linaro.org/people/nicolas.pitre/linux div64
> 
> Pulled into my asm-generic tree now, it should show up in linux-next
> tomorrow.

Thanks.

I removed a small optimization from the top commit that was included by 
mistake into a patch that was supposed to produce identical code 
(noticed by Måns). It's not urgent but it would be good if you could 
repull at some point.


Nicolas
--8323328-650366564-1447979374=:22569--
