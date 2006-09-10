Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:42718 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750820AbWIJKrC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 06:47:02 -0400
Subject: Re: [PATCH RFC]: New termios take 2
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1157472883.9018.79.camel@localhost.localdomain>
References: <1157472883.9018.79.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 11:46:20 +0100
Message-Id: <1157885180.2977.133.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-05 at 17:14 +0100, Alan Cox wrote:
> +
> +#define TCGETS2                _IOR('T',0x2A, struct termios)
> +#define TCSETS2                _IOW('T',0x2B, struct termios)
> +#define TCSETSW2       _IOW('T',0x2C, struct termios)
> +#define TCSETSF2       _IOW('T',0x2D, struct termios)

So existing code compiled against this will be using the new 'struct
termios' but the old TCGETS. Should we rename the existing ioctl to 
TCGETS_OLD, and have TCGETS be the new one?

I suppose to a large extent it doesn't really matter as long as existing
C libraries happen to get it right -- and since the new structure only
has the new field added, the discrepancy shouldn't matter _too_ much.
But still...

-- 
dwmw2

