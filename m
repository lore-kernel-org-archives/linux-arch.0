Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49185
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750819AbYC1EQd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Mar 2008 00:16:33 -0400
Date: Thu, 27 Mar 2008 21:16:32 -0700 (PDT)
Message-ID: <20080327.211632.02770342.davem@davemloft.net>
Subject: Re: [patch 1/2]: x86: implement pte_special
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080328041519.GF8083@wotan.suse.de>
References: <20080328040442.GE8083@wotan.suse.de>
	<20080327.210910.101408473.davem@davemloft.net>
	<20080328041519.GF8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: akpm@linux-foundation.org, shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328041632.fRWYy7G8UFEOEOT3nMP7klcwuS61M0E01e13Gpd1jyU@z>

From: Nick Piggin <npiggin@suse.de>
Date: Fri, 28 Mar 2008 05:15:20 +0100

> The other thing is that the "how do I know if I can refcount the page
> behind this (mm,vaddr,pte) tuple" can be quite arch specific as well.
> And it is also non-trivial to do because that information can be dynamic
> depending on what driver mapped in that given tuple.

Those are good points.
