Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60403 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbbEHSzA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2015 14:55:00 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YqnQJ-000ere-Tg
	for linux-arch@vger.kernel.org; Fri, 08 May 2015 18:54:59 +0000
Date: Fri, 8 May 2015 11:54:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v11 00/19] Re-introduce h8300 architecture
Message-ID: <20150508185449.GA1970@roeck-us.net>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150508185449.uwur0CXAPQKT4VHHT4FzODxcyXpvnvpsuhsd_W30Ln0@z>

On Sat, May 09, 2015 at 12:04:20AM +0900, Yoshinori Sato wrote:
> Hello.
> I will re-introducing h8300.
> 
[ ... ]
> 
> git repository
> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git h8300
> 
All three available configurations build fine for me this time.
The allmodconfig build has a couple of failures, but I am not sure
if those are due to upstream failures (the spi build failure is a known
upstream problem). Overall, build looks good.

Compile-tested-by: Guenter Roeck <linux@roeck-us.net>
