From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: introduce arch/$ARCH/Kbuild ?
Date: Tue, 21 Apr 2009 15:14:30 +0200
Message-ID: <20090421131430.GA25098@linux-mips.org>
References: <20090416183701.GA5810@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([213.58.128.207]:52399 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbZDUPPc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2009 11:15:32 -0400
Received: from localhost.localdomain ([127.0.0.1]:29101 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20025219AbZDUNOf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Apr 2009 14:14:35 +0100
Content-Disposition: inline
In-Reply-To: <20090416183701.GA5810@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org

On Thu, Apr 16, 2009 at 08:37:01PM +0200, Sam Ravnborg wrote:

> We have discussed privately the possiblity to cover
> all of arch/x86/* with -Werror and I came up with some
> suggestions so we could cover all subdirectories
> with a simple:
> 
>     subdir-ccflags-y := -Werror
> 
> I will sent a separate post on this when I have a patch ready..
> 
> But doing so required us to modify a lot of Makefiles
> in arch/x86 - too much for my taste.
> 
> Looking futher I realised that we could move all the core-y
> stuff to a separate Kbuild file as done by the appended patch.
> We would then cover all the directories with a single:
> 
>     subdir-ccflags-y := -Werror
> 
> 
> This has the added benefit that you can now do:
> 
>     make arch/x86/
> 
> And you will build most (but not all) of the x86 files.
> That alone was enough rationale for Ingo to apply it (and I agree).
> 
> What remains are the libs-y and driver-y parts.
> There is no way to specify these today.
> 
> If you think this looks wortwhile for your architecture I
> will be glad to help cook up a patch - albeit it is trivial
> to do so yourself.

Most of arch/mips uses -Werror these days and while painful at times it
keeps everybody on their toes hopefully cleaner, less buggy code.  So if
your solution allows adding -Werror to all subdirs automatically with
a mechanism to remove -Werror from a few selected dirs then I'm interested.

  Ralf
