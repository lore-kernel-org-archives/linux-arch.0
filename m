Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63480 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbbD0JLk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2015 05:11:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 00/17] Re-introduce h8300 architecture
Date: Mon, 27 Apr 2015 11:11:28 +0200
Message-ID: <4238542.6HRp7rHay7@wuerfel>
In-Reply-To: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20150427091128.1C_R_5h7qejck6L_xZWPg87oBqE0uMxme2Yx8Z0chwg@z>

On Monday 27 April 2015 14:35:07 Yoshinori Sato wrote:
> Hello.
> I will re-introducing h8300.
> 

I've done one more pass through all of your code. Generally I think you
should at this point ask Stephen Rothwell to add your git tree to linux-next,
and not rewrite the patches any more but instead add patches on top to fix
the remaining issues.

My comments are in several areas:

- device initialization. This should be updated to use a more modern version
  and replace the use of early_platform and static platform_device definitions.

- asm/io.h needs should be rethought

- header files that are functionally identical to the asm-generic variant
  and could be replaced with a 'generic-y' Makefile statement

I think all of these should be addressed, but they are not big issues that
would stop you from merging the code in linux-4.2.

	Arnd
