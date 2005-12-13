Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 08:58:35 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213075835.GZ15804@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213075441.GB6765@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> - i introduced a 'type-sensitive' macro wrapper that switches down() 
>   (and the other APIs) to either to the assembly variant (if the 
>   variable's type is struct compat_semaphore), or switches it to the new 
>   generic mutex (if the type is struct semaphore), at build-time. There 
>   is no runtime overhead due to this build-time-switching.

Didn't that drop compatibility with 2.95?  The necessary builtins
are only in 3.x. 

Not that I'm not in favour - I would like to use C99 everywhere 
and it would get of the ugly spinlock workaround for i386
and x86-64 doesn't support earlier compilers anyways - 
but others might not agree.

-Andi
