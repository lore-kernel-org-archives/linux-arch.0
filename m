Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53321
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753532AbXDLUvq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Apr 2007 16:51:46 -0400
Date: Thu, 12 Apr 2007 13:51:47 -0700 (PDT)
Message-Id: <20070412.135147.35685465.davem@davemloft.net>
Subject: Re: missing syscalls
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070401160123.GA9178@uranus.ravnborg.org>
References: <20070401160123.GA9178@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: sam@ravnborg.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 1 Apr 2007 18:01:23 +0200

> ============== sparc ================
>   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> <stdin>:752:2: warning: #warning syscall setresuid not implemented
> <stdin>:756:2: warning: #warning syscall getresuid not implemented
> <stdin>:776:2: warning: #warning syscall setresgid not implemented
> <stdin>:780:2: warning: #warning syscall getresgid not implemented

I figured out what was going on here.

Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
it never had the plain ones and there is no value to adding those
old versions into the syscall table.
