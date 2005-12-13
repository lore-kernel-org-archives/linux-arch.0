Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 10:49:33 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213094933.GT23384@wotan.suse.de>
References: <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213090517.GQ23384@wotan.suse.de> <20051213011540.3070176f.akpm@osdl.org> <20051213092437.GS23384@wotan.suse.de> <20051213014437.6954d26c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213014437.6954d26c.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 01:44:37AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > > There are a few places in the tree which refuse to compile with 3.1 and 3.2.
> > 
> >  Really? Which ones? 
> 
> grep for __GNUC_MINOR__

I reviewed them and I didn't find any that refused 3.2 or 3.3.

Some architectures have special code for old gccs, but nothing
generic.

-Andi
