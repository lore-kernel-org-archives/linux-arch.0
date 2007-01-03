Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:51784 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbXACVZ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Jan 2007 16:25:58 -0500
Date: Wed, 3 Jan 2007 13:25:37 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: + use-cycle_t-instead-of-u64-in-struct-time_interpolator.patch
 added to -mm tree
Message-Id: <20070103132537.7743b0bd.akpm@osdl.org>
In-Reply-To: <20070103210551.GB24620@parisc-linux.org>
References: <200701032100.l03L0REl031061@shell0.pdx.osdl.net>
	<20070103210551.GB24620@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: deller@gmx.de, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

On Wed, 3 Jan 2007 14:05:52 -0700
Matthew Wilcox <matthew@wil.cx> wrote:

> On Wed, Jan 03, 2007 at 01:00:27PM -0800, akpm@osdl.org wrote:
> > The patch titled
> >      use cycle_t instead of u64 in struct time_interpolator
> > has been added to the -mm tree.  Its filename is
> >      use-cycle_t-instead-of-u64-in-struct-time_interpolator.patch
> 
> Helge withdrew this patch.

Well yeah, but I think he did that because of some unrelated parisc borkage.

The reason I hung onto the change is because I suspect that cycle_t is the
appropriate type to be using in this code.  If someone wants to disagree
with that, I'm all ears.


