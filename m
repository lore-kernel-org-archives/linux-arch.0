Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42337
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964828AbXDAUQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Apr 2007 16:16:20 -0400
Date: Sun, 01 Apr 2007 13:16:19 -0700 (PDT)
Message-Id: <20070401.131619.94554745.davem@davemloft.net>
Subject: Re: missing syscalls
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070401200947.GB826@parisc-linux.org>
References: <20070401191511.GA24987@flint.arm.linux.org.uk>
	<20070401.122345.123969742.davem@davemloft.net>
	<20070401200947.GB826@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: matthew@wil.cx
Cc: rmk@arm.linux.org.uk, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Matthew Wilcox <matthew@wil.cx>
Date: Sun, 1 Apr 2007 14:09:47 -0600

> I haven't looked at the missing syscall check implementation, but it seems
> like it's poorly designed if we have to add ifdefs for each arch.  Why not
> allow arches a mechanism to state which syscalls they intentionally
> don't implement?

The whole idea is for the arch's to just find out that a new syscall
exists when someone adds a new one and some tries a build on that
platform the next time.  If the arch's still have to do work then the
whole exercise is pointless.
