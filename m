Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20051214115159.GG15804@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
	 <1134558188.25663.5.camel@localhost.localdomain>
	 <1134558507.2894.22.camel@laptopd505.fenrus.org>
	 <1134559470.25663.22.camel@localhost.localdomain>
	 <20051214033536.05183668.akpm@osdl.org>
	 <1134560671.2894.30.camel@laptopd505.fenrus.org>
	 <20051214115159.GG15804@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:55:08 +0100
Message-Id: <1134561309.2894.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, dhowells@redhat.com, cfriesen@nortel.com, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-12-14 at 12:52 +0100, Andi Kleen wrote:
> > * mutex use is a candidate for a "spinaphore" treatment (unlike counting
> > semaphores)
> 
> I think that would be interesting experiment for page faults.
> But they actually use rwsems, not normal semaphores.

at least rwsems are only used as mutexes afaik... so those would just
end up being mutexes.. .and could thus do this too...

(I don't think anyone ever thought of doing a counting rwsem... at least
I sure hope so; the page fault one sure is a mutex)
