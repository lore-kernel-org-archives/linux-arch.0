Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:37401 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbXCISyn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Mar 2007 13:54:43 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Complain about missing system calls.
Date: Fri, 9 Mar 2007 19:54:13 +0100
References: <1173394873.3461.510.camel@pmac.infradead.org> <p737itqbdnl.fsf@bingen.suse.de> <1173458854.24454.27.camel@localhost.localdomain>
In-Reply-To: <1173458854.24454.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703091954.13982.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sam@ravnborg.org, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>


> We need additional gunk for syscalls that can be called from SPEs on
> cell

Can that gunk not be auto generated?

I know s390 does in some cases, but it looks quite auto generatable to me.

-Andi

>
