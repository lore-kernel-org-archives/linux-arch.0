Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:40776 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbXI1TgM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2007 15:36:12 -0400
Date: Fri, 28 Sep 2007 15:36:11 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] Generic compat_sys_fallocate
Message-ID: <20070928193610.GC24047@fattire.cabal.ca>
References: <20070928181111.GF22182@fattire.cabal.ca> <20070929050610.GA8880@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070929050610.GA8880@osiris.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Sep 29, 2007 at 07:06:10AM +0200, Heiko Carstens wrote:
> 
> These are not identical... the least and most significant parts seem to get
> passed in a different way on little and big endian machines.
> Maybe it would be worth to have something like compat_merge_64() which does
> the right thing?
> 

yeah, that's what i've just done.

cheers,
	Kyle
