Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4428 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030249AbWHYQGn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Aug 2006 12:06:43 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Date: Fri, 25 Aug 2006 09:06:41 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A6E9D2D@scsmsx411.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>, Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> choice
>         prompt "Kernel Page Size"
>         depends on IA64 || SPARC64 || PARISC || MIPS
>         default PAGE_SIZE_4KB if MIPS
>         default PAGE_SIZE_8KB if IA64 || SPARC64 || PARISC
> config PAGE_SIZE_4KB

Default for IA64 should be 16K.

Thanks

-Tony
