Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 21 Jul 2005 01:05:13 -0700 (PDT)
Message-Id: <20050721.010513.74747631.davem@davemloft.net>
Subject: Re: [PATCH, for review 1/3] compat_sys_{read,write}
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050721170552.6ef403fb.sfr@canb.auug.org.au>
References: <20050630154904.GQ13890@bragg.suse.de>
	<20050701145642.6a3d6542.sfr@canb.auug.org.au>
	<20050721170552.6ef403fb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: linux-arch@vger.kernel.org, ak@suse.de, matthew@wil.cx, hch@lst.de, akpm@osdl.org, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH, for review 1/3] compat_sys_{read,write}
Date: Thu, 21 Jul 2005 17:05:52 +1000

> On Fri, 1 Jul 2005 14:56:42 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > This patch introduces compatibility syscalls for read and write and the
> > equivalent hooks in struct file_operations.  These are neede to support
> > the badly designed (i.e. broken) input layer evdev read and write
> > interfaces.
> 
> Have you all come to some consensus on this issue?  Do I submit the
> patches for compat_sys_read/write to Linus/Andrew?

Most people are likely in Ottawa and don't have the time to
review your changes at the moment.
