Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:21456 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1030538AbWJ3PrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Oct 2006 10:47:00 -0500
Date: Mon, 30 Oct 2006 10:46:57 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Message-ID: <20061030154657.GB13625@athena.road.mcmartin.ca>
References: <20061028223730.GC3243@athena.road.mcmartin.ca> <200610290109.08844.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610290109.08844.arnd.bergmann@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Kyle McMartin <kyle@parisc-linux.org>, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Oct 29, 2006 at 01:09:08AM +0200, Arnd Bergmann wrote:
> Since sys_rt_sigqueueinfo() is so simple, I think it would be much
> better to define the common version as 
> 
> <snip>

Agreed, that seems to be the convention in compat.c for `simple'
syscalls.

> 	Arnd <><
> 

Cheers,
	Kyle M.
