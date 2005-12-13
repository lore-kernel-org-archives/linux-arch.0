Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20051213075441.GB6765@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org>  <20051213075441.GB6765@elte.hu>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 09:00:04 +0100
Message-Id: <1134460804.2866.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-12-13 at 08:54 +0100, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > I'd have thought that the way to do this is to simply reimplement 
> > down(), up(), down_trylock(), etc using the new xchg-based code and to 
> > then hunt down those few parts of the kernel which actually use the 
> > old semaphore's counting feature and convert them to use down_sem(), 
> > up_sem(), etc.  And rename all the old semaphore code: 
> > s/down/down_sem/etc.
> 
> even better than that, why not use the solution that we've implemented 
> for the -rt patchset, more than a year ago?
> 
> the solution i took was this:
> 
> - i did not touch the 'struct semaphore' namespace, but introduced a
>   'struct compat_semaphore'.

which I think is wrong. THis naming sucks. Sure doing a full sed on the
tree is not pretty but it's also not THAT painful. And the pain of wrong
names is something the kernel needs to carry around for years.
> 
> - i introduced a 'type-sensitive' macro wrapper that switches down() 
>   (and the other APIs) to either to the assembly variant (if the 
>   variable's type is struct compat_semaphore), or switches it to the new 
>   generic mutex (if the type is struct semaphore), at build-time. There 
>   is no runtime overhead due to this build-time-switching.

while this is a smart trick, I rather prefer seperate functions, just so
that people are "aware" which they use. Since 99% of the users is a
mutex anyway, the new names are only used in a few special cases.
