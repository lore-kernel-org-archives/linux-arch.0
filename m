Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:57052 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbXAHHYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2007 02:24:25 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Common compat_sys_sysinfo (v2)
Date: Mon, 8 Jan 2007 06:54:26 +0100
References: <20070107144850.GB3207@athena.road.mcmartin.ca> <20070107154045.GD3207@athena.road.mcmartin.ca> <20070108104347.83a004aa.sfr@canb.auug.org.au>
In-Reply-To: <20070108104347.83a004aa.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701080654.27100.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kyle McMartin <kyle@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parisc-linux@lists.parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 08 January 2007 00:43, Stephen Rothwell wrote:
> > +asmlinkage long sys_sysinfo(struct sysinfo __user *info)
> > +{
> > +     struct sysinfo val;
> > +
> > +     do_sysinfo(&val);
> >
> > - out:
> >       if (copy_to_user(info, &val, sizeof(struct sysinfo)))
> >               return -EFAULT;
> 
> People have complined before that this adds a whole stack frame to the
> "normal" syscall path.  Personally I don't care, but it has been
> mentioned.

It might be a concern for something like 'read' which is called frequently
and in strange ways, but for 'sysinfo' this really should not matter.

	Arnd <><
