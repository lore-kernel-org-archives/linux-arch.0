Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:51797 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbXACVdP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2007 16:33:15 -0500
Date: Wed, 3 Jan 2007 14:33:13 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: + use-cycle_t-instead-of-u64-in-struct-time_interpolator.patch added to -mm tree
Message-ID: <20070103213313.GC24620@parisc-linux.org>
References: <200701032100.l03L0REl031061@shell0.pdx.osdl.net> <20070103210551.GB24620@parisc-linux.org> <20070103132537.7743b0bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103132537.7743b0bd.akpm@osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: deller@gmx.de, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jan 03, 2007 at 01:25:37PM -0800, Andrew Morton wrote:
> Well yeah, but I think he did that because of some unrelated parisc borkage.

It's simply impossible to implement cmpxchg() in the general case on
parisc.  This was hashed out in great detail recently ...
