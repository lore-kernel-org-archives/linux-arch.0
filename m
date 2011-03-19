From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Sat, 19 Mar 2011 21:14:04 +0100
Message-ID: <201103192114.05164.arnd@arndb.de>
References: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com> <AANLkTimPoEi+XLUJgza-b_gXbd4kCGpF93MySAR0ZRvT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63814 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757451Ab1CSUOQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2011 16:14:16 -0400
In-Reply-To: <AANLkTimPoEi+XLUJgza-b_gXbd4kCGpF93MySAR0ZRvT@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org
Cc: Madhavi Manchala <madhavi.linux@gmail.com>, linux-arch@vger.kernel.org, gregkh@suse.de, prasadjoshi124@gmail.com, uClinux development list <uclinux-dev@uclinux.org>

On Saturday 19 March 2011, Geert Uytterhoeven wrote:
> On Sat, Mar 19, 2011 at 10:53, Madhavi Manchala <madhavi.linux@gmail.com> wrote:
> > I have one basic question about the architecture files in Linux
> > kernels. We have a board with Samsung S3C2510A MCU (ARM940T core)
> > which is a no-mmu based CPU. I heard that "there was not a lot of ARM
> > no-mmu support at the moment" from Ben Dooks.
> >
> > So, I started developing the architecture files for my Samsung
> > S3C2510A MCU (ARM940T core) by looking at the existing S3C2410A
> > (ARM920 core) architecture files. Is this my porting (developing the
> > architecture files) correct?
> >
> > How can I port the Linux on to my board which has a Samsung S3C2510A
> > MCU (ARM940T core) which is a NO-MMU based CPU?
> >
> > Please suggest me. It would be appreciated your help / suggestions.
> 
> I think the uClinux mailing list (CCed) is a more appropriate mailing list for
> your questions.

It depends. Any questions regarding the ARM kernel should be on the
arm-linux-kernel (also CCed now), since the nommu support is merged
with the mainline kernel.

uClinux seems to be rather focused on m68knommu (coldfire) these days,
and contains both a kernel and user space. The last uClinux release
containst some changes for Samsung platforms (s3c24a0, s3c3410,
s3c44b0x and s5c7375). It's probably a good idea to look at that
code for reference, but I would suggest integrating the code for
your platform in the upstream  tree directly.

I could not find a git tree for uClinux that contains any recent
kernel. Does that exist?

	Arnd
