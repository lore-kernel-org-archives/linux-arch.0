Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Daniel Walker <dwalker@mvista.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 16:57:38 -0800
Message-Id: <1134435458.22269.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2005-12-12 at 23:45 +0000, David Howells wrote:

>  (1) Provides a simple xchg() based semaphore as a default for all
>      architectures that don't wish to override it and provide their own.
> 
>      Overriding is possible by setting CONFIG_ARCH_IMPLEMENTS_MUTEX and
>      supplying asm/mutex.h
> 
>      Partial overriding is possible by #defining mutex_grab(), mutex_release()
>      and is_mutex_locked() to perform the appropriate optimised functions.

Your code is really similar to the RT mutex, which does everything that
your mutex does at least ? Assuming you've reviewed the RT mutex, why
would we want to use yours over it?

Daniel
