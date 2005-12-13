Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 11:54:59 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213105459.GA9879@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* David Howells <dhowells@redhat.com> wrote:

>      	init_MUTEX_LOCKED()
> 	DECLARE_MUTEX_LOCKED()

please kill these two in the simple mutex implementation - they are a 
sign of mutexes used as completions.

>  (7) Provides a debugging config option CONFIG_DEBUG_MUTEX_OWNER by which the
>      mutex owner can be tracked and by which over-upping can be detected.

another simplification: also enforce that only the owner can unlock the 
mutex. This is what we are doing in the -rt patch. (This rule also 
ensures that such mutexes can be used for priority inheritance.)

	Ingo
