Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42433
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752961AbXKABAI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2007 21:00:08 -0400
Date: Wed, 31 Oct 2007 18:00:07 -0700 (PDT)
Message-Id: <20071031.180007.86834938.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0710311752380.25515@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0710311730280.25414@schroedinger.engr.sgi.com>
	<20071031.175124.84905325.davem@davemloft.net>
	<Pine.LNX.4.64.0710311752380.25515@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Wed, 31 Oct 2007 17:53:23 -0700 (PDT)

> > This patch fixes build failures with DEBUG_VM disabled.
> 
> Well there is more there. Last minute mods sigh. With DEBUG_VM you likely 
> need this patch.

Without DEBUG_VM I get a loop of crashes shortly after SSHD
is started, I'll try to track it down.
