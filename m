From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/20] mm: generic show_mem() v4
Date: Tue, 1 Jul 2008 00:25:18 -0700
Message-ID: <20080701002518.7918fdaf.akpm@linux-foundation.org>
References: <20080627115349.743368154@saeurebad.de>
	<8763rq6qlc.fsf@skyscraper.fehenstaub.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51285 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299AbYGAHZx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 03:25:53 -0400
In-Reply-To: <8763rq6qlc.fsf@skyscraper.fehenstaub.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@saeurebad.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 01 Jul 2008 08:55:27 +0200 Johannes Weiner <hannes@saeurebad.de> wrote:

> Hi,
> 
> Johannes Weiner <hannes@saeurebad.de> writes:
> 
> > Every arch implements its own show_mem() function.  Most of them share
> > quite some code, some of them are completely identical.
> >
> > This series implements a generic version of this function and migrates
> > almost all architectures to it.
> >
> > version 4:
> > 	- rebased against -mmotm
> 
> Oh, btw, do you even want them, Andrew?

These are only a few hundred patches ahead of my current backlog cursor
:( I should be caught up mid-weekish.

>  Or should I base this set on
> Linus' tree directly?

That would be a bad step.  Linus's tree is 2.6.26 whereas we're all
developing 2.6.27.  There's a ~30MB diff between the two.
