Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:59076 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S935138AbWKYEAs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Nov 2006 23:00:48 -0500
Date: Fri, 24 Nov 2006 21:00:48 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Generic compat_sys_sysinfo
Message-ID: <20061125040047.GG14076@parisc-linux.org>
References: <20061125014313.GD11643@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125014313.GD11643@athena.road.mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, parisc-linux@lists.parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Nov 24, 2006 at 08:43:13PM -0500, Kyle McMartin wrote:
> Some architectures were missing the u16 pad, however, I'm going to
> guess that a u16 is aligned on a u32 boundary and thus the padding is
> implied there...

It's more that a u32 gets aligned to a u32 boundary rather than a u16.
This is true except for m68k, which doesn't have compat.

Acked-by: Matthew Wilcox <matthew@wil.cx>
