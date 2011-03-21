From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Mon, 21 Mar 2011 13:20:38 +0100
Message-ID: <201103211320.38227.arnd@arndb.de>
References: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com> <201103192114.05164.arnd@arndb.de> <4D873890.5000302@snapgear.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52283 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab1CUMUq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2011 08:20:46 -0400
In-Reply-To: <4D873890.5000302@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, Madhavi Manchala <madhavi.linux@gmail.com>, linux-arch@vger.kernel.org, gregkh@suse.de, prasadjoshi124@gmail.com, uClinux development list <uclinux-dev@uclinux.org>

On Monday 21 March 2011, Greg Ungerer wrote:
> > I could not find a git tree for uClinux that contains any recent
> > kernel. Does that exist?
> 
> I used to keep one on git.kernel.org for promoting non-architectural
> but non-MMU specific changes to mainline.
> 
> http://git.kernel.org/?p=linux/kernel/git/gerg/uclinux.git;a=summary
> 
> But I have had so few changes that fit in that category that I
> haven't used it in quite a while.

Yes, I found that tree when I looked last week. I was wondering
if there is any git or other repo for the files that are in
http://sourceforge.net/projects/uclinux/files/uClinux%20Stable/

The kernel sources there are newer than the ones from uclinux.git,
but I could not find a pointer to who maintains them or how.

	Arnd
