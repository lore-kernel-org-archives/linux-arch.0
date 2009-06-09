From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/27] score arch files for linux
Date: Tue, 9 Jun 2009 19:00:31 +0200
Message-ID: <200906091900.32379.arnd@arndb.de>
References: <OF54D30DF0.6974DE98-ON482575D0.0021670B-482575D0.00234606@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:54661 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186AbZFIRCE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:02:04 -0400
In-Reply-To: <OF54D30DF0.6974DE98-ON482575D0.0021670B-482575D0.00234606@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> Hi Arnd, Andrew Morton and linus,
> 
> According to your comment on score arch code, 
> we update score code base on asm-generic#next repository.
> use arch microblaze and blackfin as reference.
>

Some general notes about the patch submission, not the contents:
Your mail client still has a 'wordwrap' problem, which breaks
importing the patches into a repository. The easiest workaround
for this is to use 'git send-email', which handles it correctly.
Play around with the '--dry-run' and '--suppress-cc=all' options
at first to send the patches to yourself, so you know how it
works.

For 'git format-patch', please use the '-M -B --thread=shallow'
options so that all your mails end up nicely in a single mail
thread and renames are detected (the latter would not change
anything for your current set of patches, but may some day).

	Arnd <><
