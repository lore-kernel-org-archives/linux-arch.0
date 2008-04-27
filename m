From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: microblaze syscall list
Date: Sun, 27 Apr 2008 17:50:49 +0100
Message-ID: <20080427175049.765766c8@core>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	<200804221515.28075.arnd@arndb.de>
	<480FA729.3000406@seznam.cz>
	<200804241311.09881.arnd@arndb.de>
	<4810D4A4.7050900@seznam.cz>
	<4811A623.80104@itee.uq.edu.au>
	<20080425100614.GB14990@parisc-linux.org>
	<4813DF3E.6080800@itee.uq.edu.au>
	<4814A153.3040600@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4814A153.3040600-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, John Williams <john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>, Stephen Neuendorffer <stephen.neuendorffer-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

> There is two opinions:
> * One is take syscall table with old syscalls for backward compatibility.
> As John W wrote. Microblaze has history around 4 years and 2.6 kernel almost 2
> years.

I would keep the old syscall table. Otherwise you end up with two
differing microblaze setups and people will get binaries, libraries and
compilers muddled up for years to come which will be nothing but pain for
eveyone.

Alan
