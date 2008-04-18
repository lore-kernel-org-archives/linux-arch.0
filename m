Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42123 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbYDRISb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2008 04:18:31 -0400
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel stack allocation alignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <20080418000618.0c46c78f.akpm@linux-foundation.org>
References: <20080418065727.5FE1CDE247@ozlabs.org>
	 <20080418000618.0c46c78f.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 18:18:18 +1000
Message-ID: <1208506698.6958.400.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20080418081818.lX-EbCPbD5xWzcAtd93zQig-FVnHAS5z116akrdq_7o@z>


> so...  the "0" defeats all of SLAB_DEBUG_FREE, SLAB_RED_ZONE, SLAB_POISON
> and SLAB_STORE_USER, if the comment in slab.h is to be believed.
> 
> Was that overkill?

Well, I copied over from something else, looks like there's a -lot- of 0
users here... 

Shouldn't there be some kind of SLAB_DEFAULT that contain those things ?

Ben.


