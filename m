Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:23205 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S932111AbWJ1WxS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Oct 2006 18:53:18 -0400
Date: Sat, 28 Oct 2006 18:53:14 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Message-ID: <20061028225314.GD3243@athena.road.mcmartin.ca>
References: <20061028223730.GC3243@athena.road.mcmartin.ca> <20061028224738.GT5591@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028224738.GT5591@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Kyle McMartin <kyle@parisc-linux.org>, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Oct 28, 2006 at 04:47:38PM -0600, Matthew Wilcox wrote:
> Why can't we have a compat_copy_siginfo_from_user() (and
> compat_copy_siginfo_to_user() for that matter) defined in
> kernel/compat.c for all architectures?  The user32 convention really
> grates for some reason ;-)
> 

Coming in a later patch... This is just fixing one of the places where
compat signals changed generic code in signal.c

Cheers,
	Kyle
