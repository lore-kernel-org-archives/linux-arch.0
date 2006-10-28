Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:57801 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932117AbWJ1XKA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Oct 2006 19:10:00 -0400
Date: Sat, 28 Oct 2006 17:09:59 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Message-ID: <20061028230959.GU5591@parisc-linux.org>
References: <20061028223730.GC3243@athena.road.mcmartin.ca> <20061028224738.GT5591@parisc-linux.org> <20061028225314.GD3243@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028225314.GD3243@athena.road.mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Oct 28, 2006 at 06:53:14PM -0400, Kyle McMartin wrote:
> On Sat, Oct 28, 2006 at 04:47:38PM -0600, Matthew Wilcox wrote:
> > Why can't we have a compat_copy_siginfo_from_user() (and
> > compat_copy_siginfo_to_user() for that matter) defined in
> > kernel/compat.c for all architectures?  The user32 convention really
> > grates for some reason ;-)
> > 
> 
> Coming in a later patch... This is just fixing one of the places where
> compat signals changed generic code in signal.c

OK.  It just doesn't make too much sense to me to add this copy_compat
code to a half-dozen architectures, only to take it out again in a later
patch.
