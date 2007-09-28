Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:57522 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbXI1Ta1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2007 15:30:27 -0400
Date: Fri, 28 Sep 2007 15:30:24 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] Generic compat_sys_fallocate
Message-ID: <20070928193024.GB24047@fattire.cabal.ca>
References: <20070928181111.GF22182@fattire.cabal.ca> <200709282101.39020.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709282101.39020.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Sep 28, 2007 at 09:01:37PM +0200, Arnd Bergmann wrote:
> 
> This code assumes little-endian register ordering for 64 bit
> arguments. AFAICS, this is wrong at aleast on mipseb and powerpc.
> 

Yeah, you're right. I've an idea for how to fix this, will update patch
soon.

Cheers,
	Kyle
