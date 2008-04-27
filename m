From: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
Date: Sun, 27 Apr 2008 16:26:06 -0700
Message-ID: <20080427162606.3dd82c0c@laptopd505.fenrus.org>
References: <20080427105100.GA14795@uranus.ravnborg.org>
	<20080427113158.GY2252@cs181133002.pp.htv.fi>
	<alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org>
	<20080427172235.GA2252@cs181133002.pp.htv.fi>
	<alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
	<20080427174714.GB2252@cs181133002.pp.htv.fi>
	<20080427180007.GB28483@infradead.org>
	<20080427180957.GA25964@uranus.ravnborg.org>
	<20080427181411.GA31667@infradead.org>
	<alpine.LFD.1.10.0804271118500.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.1.10.0804271118500.2896-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, 27 Apr 2008 11:24:28 -0700 (PDT)
Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

> 
> 
> On Sun, 27 Apr 2008, Christoph Hellwig wrote:
> > 
> > As Linus mentioned the hint doesn't make any sense because gcc will
> > get it wrong anyway.  In fact when you look at kernel code it tends
> > to inline the everything and the kitchensink as long as there's just
> > one caller and this bloat the stack but doesn't inline where it
> > needs to.  Better don't try to mess with that and do it explicit.
> 
> The thing is, the "inline" vs "always_inline" thing _could_ make
> sense, but sadly doesn't much.
> 
> Part of it is that gcc imnsho inlines too aggressively anyway in the 
> absense of "inline",


yup.. but this patch doesn't change that... the "no inline keyword" case
is totally unaffected...


(actually, other than some obscure commandline options, the only sane way to
avoid gcc doing this too agressive is using -Os)

-- 
If you want to reach me at my work email, use arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
