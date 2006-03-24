Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:23944 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422832AbWCXKJo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Mar 2006 05:09:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17443.50517.434114.900607@cargo.ozlabs.ibm.com>
Date: Fri, 24 Mar 2006 21:09:25 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
In-Reply-To: <20060323164623.699f569e.sfr@canb.auug.org.au>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Stephen Rothwell writes:

> We had a copy of the compatibility version of struct timex in each 64 bit
> architecture.  This patch just creates a global one and replaces all the
> usages of the old ones.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Paul Mackerras <paulus@samba.org>
