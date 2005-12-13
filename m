Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 11:11:53 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213101152.GU23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213010233.50fce969.akpm@osdl.org> <20051213100715.GH31785@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213100715.GH31785@devserv.devel.redhat.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Guess
> 
> #if __GNUC__ == 3 && __GNUC_MINOR__ < 3
> #error Your compiler is too buggy; it is known to miscompile kernels.
> #error    Known good compilers: 3.3, 3.4, 4.0
> #endif
> 
> would be better.  __GNUC__ < 2 will certainly be errored about in other
> places and it is bad to suggest compilers that are no longer supported
> as known good ones.

Are there really any known serious miscompilation with 3.1/3.2?  
(I knew it used to miscompile some loops on x86-64, but I think I worked
around all that) 

Preventing SLES9 and RHEL3 users from easily compiling new kernels
isn't good.

-Andi
