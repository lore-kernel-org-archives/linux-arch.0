From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Unicore architecture patch review, part 2
Date: Wed, 8 Dec 2010 13:53:44 +0100
Message-ID: <201012081353.44927.arnd@arndb.de>
References: <201011301754.17829.arnd@arndb.de> <011401cb96c0$b7dca8d0$2795fa70$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:49626 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab0LHMxz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2010 07:53:55 -0500
In-Reply-To: <011401cb96c0$b7dca8d0$2795fa70$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 08 December 2010, Guan Xuetao wrote:

> > > @@ -0,0 +1,390 @@
> > > +/* 0 */		CALL(sys_restart_syscall)
> > > +		CALL(sys_exit)
> > > +		CALL(sys_fork_wrapper)
> > > +		CALL(sys_read)
> > > +		CALL(sys_write)
> > > +/* 5 */		CALL(sys_open)
> > > +		CALL(sys_close)
> > 
> > When you start using the generic unistd.h file, you can also replace this table
> > with something like arch/tile/kernel/sys.c.
> Well. I will use the generic unistd.h in UniCore-64 version.

I thought you had agreed to break ABI compatibility with your existing
code base and use the generic ABI everywhere.

Did I misunderstand you or did you make up your mind since then?

> > Hmm, when the architecture was being defined, why didn't you ask for a
> > cycle counter? It really improves the delay code a lot.
> No software readable cycle counter in UniCore32.
> 
> > If you have a good time base by now, you should use it. Is the OST_OSCR
> > something you could use here?
> OST_OSCR is much coarse in here, which is 14.318M Hz.

Ok, I see.

	Arnd
