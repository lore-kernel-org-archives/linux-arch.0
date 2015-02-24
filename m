From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: nios2: is the ptrace ABI correct?
Date: Tue, 24 Feb 2015 09:54:10 +0100
Message-ID: <5636312.0WGrbVlVgB@wuerfel>
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:64139 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbBXIyW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Feb 2015 03:54:22 -0500
In-Reply-To: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Tobias Klauser <tklauser@distanz.ch>, Chung-Ling Tang <cltang@codesourcery.com>, Walter Goossens <waltergoossens@home.nl>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tuesday 24 February 2015 00:04:21 Ezequiel Garcia wrote:
> So, tried a different approach and removed pt_regs from the UAPI ptrace.h,
> replacing it with a new user_regs that describes how registers are passed
> to user. This however is also problematic, as pt_regs is already used
> by glibc (not really sure what for).
> 

I've looked at glibc and could not find a use for pt_regs there. Where
did you find it? It's quite possible that it's incorrect as well
if the structures don't match.

	Arnd
