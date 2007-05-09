Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:50552 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524AbXEIB1a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 May 2007 21:27:30 -0400
Date: Wed, 9 May 2007 10:04:28 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: New slab allocator SLUB
Message-ID: <20070509010428.GA19267@linux-sh.org>
References: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, May 08, 2007 at 12:10:32PM -0700, Christoph Lameter wrote:
> I would appreciate if you could test SLUB on your platform and make sure 
> that everything works the right way. There is a slabinfo tool that allows 
> monitoring of SLUB slabs in Documentation/vm/slabinfo.c. If there are 
> problems then please boot specifying "slub_debug" which should give you a 
> detailed analysis of the issues encountered.
> 
It seems to hold up on SH as expected at least. I've been running
it for awhile with varying workloads and nothing out of the ordinary has
popped up yet.
