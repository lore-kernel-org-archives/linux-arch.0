Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 10:05:18 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213090517.GQ23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213010126.0832356d.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 01:01:26AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > Can you please apply the following patch then? 
> > 
> >  Remove -Wdeclaration-after-statement
> 
> OK.
> 
> Thus far I have this:

Would it be possible to drop support for gcc 3.0 too? 
AFAIK it has never been widely used. If we assume 3.1+ minimum it has the 
advantage that named assembly arguments work, which make
the inline assembly often a lot easier to read and maintain.

-Andi
