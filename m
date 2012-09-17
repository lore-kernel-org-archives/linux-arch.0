Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35101 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab2IQJ3N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Sep 2012 05:29:13 -0400
Received: by bkwj10 with SMTP id j10so2353820bkw.19
        for <linux-arch@vger.kernel.org>; Mon, 17 Sep 2012 02:29:12 -0700 (PDT)
Message-ID: <5056ED66.30203@monstr.eu>
Date: Mon, 17 Sep 2012 11:29:10 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
Subject: Re: [RFC] status of execve() work - per-architecture patches solicited
References: <20120907182004.GE13973@ZenIV.linux.org.uk>
In-Reply-To: <20120907182004.GE13973@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20120917092910.kxLnE4g24pyjQYYo1WJV1vBAWZZJ6jnQNWA4yfV4otY@z>

Hi Al,

On 09/07/2012 08:20 PM, Al Viro wrote:
> 	To architecture maintainers: please, review the current
> situation in git.kernel.org/pub/scm/linux/kernel/git/viro/signal #execve2
> and consider sending the corresponding patches for missing architectures.

I have sent two patches. Please apply them to your tree.

Michal Simek (2):
       microblaze: Move restart allowed out of block
       microblaze: Remove compilation failure

  arch/microblaze/kernel/entry.S |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)

I have seen the compilation problem in June on linux-next but
have never got any response from you.
http://www.spinics.net/lists/linux-next/msg20848.html

Can you please apply these two patches to your tree?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
