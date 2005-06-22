Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 23:00:24 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: sparsemem patches in -mm
Message-Id: <20050621230024.4cd8d2fd.akpm@osdl.org>
In-Reply-To: <20050621.224645.78710941.davem@davemloft.net>
References: <20050621021352.46fc3b81.akpm@osdl.org>
	<20050621.224645.78710941.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, apw@shadowen.org, haveblue@us.ibm.com, matthew.e.tolentino@intel.com, bob.picco@hp.com
List-ID: <linux-arch.vger.kernel.org>

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: Andrew Morton <akpm@osdl.org>
> Date: Tue, 21 Jun 2005 02:13:52 -0700
> 
> > http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/
> 
> The only thing that sticks out to me in this patch is that
> sparc64 uses a field starting at bit 24 in page->flags to
> determine the cpu which needs a D-cache flush for a page.

<looks>

That's a bit hacky.  Doesn't it conflict with the way in which we stuff the
page's zone index into the top of page->flags?  I guess with a small number
of zones and a smallish number of CPUs you got lucky.

It'd be safer to use bit 32.

> I don't think the page->flags rework makes things any different
> than before, but it's something to keep in mind.

Think so.
