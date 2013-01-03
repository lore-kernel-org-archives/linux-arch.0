From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: uapi __NR_syscalls for microblaze
Date: Thu, 3 Jan 2013 16:01:00 +0000
Message-ID: <201301031601.00594.arnd@arndb.de>
References: <CAHTX3d+bwTNEhzB78mqoz6prk0nw0U_-1YFR3Tje_-uQLyTMBQ@mail.gmail.com> <26599.1357221783@warthog.procyon.org.uk> <CAHTX3d+C6_Vr-Q-UH8y9F_7=8GwBxzd8eECPN6tNBpxwr10=cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61333 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab3ACQBJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jan 2013 11:01:09 -0500
In-Reply-To: <CAHTX3d+C6_Vr-Q-UH8y9F_7=8GwBxzd8eECPN6tNBpxwr10=cQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: David Howells <dhowells@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org

On Thursday 03 January 2013, Michal Simek wrote:
> 2013/1/3 David Howells <dhowells@redhat.com>:
> > Michal Simek <monstr@monstr.eu> wrote:
> >
> >> just want to check with you if __NR_syscalls is necessary for user space. I
> >> see that powerpc and arm have this macro in asm not in uapi like Microblaze.
> >> If is not needed by user space, I should move it to asm/unistd.h
> >
> > It isn't as far as I know...  I recommend putting your question on the
> > linux-arch mailing list.
> 
> I have add linux-arch to CC.

Right, I'm pretty sure it's not needed, but it has traditionally been
exported on a lot of platforms, so you can keep it in UAPI to be
on the safe side.

	Arnd
