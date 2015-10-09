Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56325 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbbJIKwX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2015 06:52:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
Date: Fri, 09 Oct 2015 12:52:17 +0200
Message-ID: <9458650.5ERT5vpZ3d@wuerfel>
In-Reply-To: <20151009103352.GK26278@arm.com>
References: <1444386580-10917-1-git-send-email-manjeet.p@samsung.com> <20151009103352.GK26278@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Manjeet Pawar <manjeet.p@samsung.com>, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, pankaj.m@samsung.com, Akhilesh Kumar <akhilesh.k@samsung.com>, Rohit Thapliyal <r.thapliyal@samsung.com>
Message-ID: <20151009105217.3IPHnWJDrBClOvp2dJyRDiekxuJssl8yEE1Ql22YV-w@z>

On Friday 09 October 2015 11:33:52 Will Deacon wrote:

> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Arnd: are you planning to take this via asm-generic, or shall I queue it
> on the arm64 fixes branch?
> 

Please merge it for arm64 with my

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
