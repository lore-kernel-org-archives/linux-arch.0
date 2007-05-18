Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60674
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755029AbXERGur (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2007 02:50:47 -0400
Date: Thu, 17 May 2007 23:50:49 -0700 (PDT)
Message-Id: <20070517.235049.45744179.davem@davemloft.net>
Subject: Re: [PATCH 01/14] kbuild: make modpost section warnings clearer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070518064918.GA12284@uranus.ravnborg.org>
References: <20070518064126.GA12193@uranus.ravnborg.org>
	<20070518064918.GA12284@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rmk+kernel@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 May 2007 08:49:18 +0200

> >From 4dba30ccfdb911b0810f6527de66b1515349d8c4 Mon Sep 17 00:00:00 2001
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Thu, 10 May 2007 23:03:25 +0100
> Subject: [PATCH 01/14] kbuild: make modpost section warnings clearer
> 
> Change modpost section mismatch warnings to be less confusing;
> model them on the binutils linker warnings which we all know how
> to interpret.
> 
> Also, fix the wrong ordering of arguments for the final case -
> fromsec and refsymname were reversed.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David S. Miller <davem@davemloft.net>
