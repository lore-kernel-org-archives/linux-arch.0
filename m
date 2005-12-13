Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <439EDC3D.5040808@nortel.com>
References: <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <439EDC3D.5040808@nortel.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 15:44:22 +0100
Message-Id: <1134485062.9814.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Christopher Friesen <cfriesen@nortel.com>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-12-13 at 08:35 -0600, Christopher Friesen wrote:
> David Howells wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> >>It seems to me it would be far far saner to define something like
> >>
> >>	sleep_lock(&foo)
> >>	sleep_unlock(&foo)
> >>	sleep_trylock(&foo)
> > 
> > Which would be a _lot_ more work. It would involve about ten times as many
> > changes, I think, and thus be more prone to errors.
> 
> "lots of work" has never been a valid reason for not doing a kernel 
> change...
> 
> In this case, introducing a new API means the changes can be made over time.

in this case, doing this change gradual I think is a mistake. We should
do all of the in-kernel code at least... 
