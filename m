Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:53286 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbZENH2L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2009 03:28:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/16] asm-generic headers, v4
Date: Thu, 14 May 2009 09:28:01 +0200
References: <1242255398-23779-1-git-send-email-arnd@arndb.de> <20090514164521.c2b61893.sfr@canb.auug.org.au>
In-Reply-To: <20090514164521.c2b61893.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200905140928.01861.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Chen Liqin <liqin.chen@sunplusct.com>
Message-ID: <20090514072801.KjrG9iHmktnc-HkecIvzdxxOM52XgNktIlze_XfP2zY@z>

On Thursday 14 May 2009, Stephen Rothwell wrote:
> Hi Arnd,
> 
> On Wed, 13 May 2009 22:56:23 +0000 Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Stephen, can you add
> > git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic next
> > to linux-next?
> 
> I will try this tomorrow.  It will be interesting to see just how many
> conflicts we get.

Thanks!

I've tried to make this patch set as non-invasive as possible, basically
just adding files and making single line changes to existing files
where necessary. I've never seen conflicts when I tried merging
with linux-next/master.

In the beginning, I was thinking about doing one series per file,
adding the asm-generic version in one patch and changing the per-arch
versions to use it in follow-on patches.
Hopefully, the way I'm doing it now turns out to be less time consuming,
as I can add all the generic headers once without impacting any of the
architectures, and the next patches can easily be done in the
arch maintainer tree for all files at once.

	Arnd <><
