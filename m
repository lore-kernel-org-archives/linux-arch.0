Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.orcon.net.nz ([219.88.242.51]:42363 "EHLO mx1.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab0ISDIo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 18 Sep 2010 23:08:44 -0400
Received: from Debian-exim by mx1.orcon.net.nz with local (Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1Ox9vn-0000EK-M8
	for linux-arch@vger.kernel.org; Sun, 19 Sep 2010 14:47:07 +1200
Message-ID: <4C9579A1.5030009@orcon.net.nz>
Date: Sun, 19 Sep 2010 14:46:57 +1200
From: Michael Cree <mcree@orcon.net.nz>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] alpha: belated ERESTART_RESTARTBLOCK race fix
References: <20100918083846.GA31363@ZenIV.linux.org.uk>
In-Reply-To: <20100918083846.GA31363@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, mattst88@gmail.com
Message-ID: <20100919024657.dc5JFWYYDroenRSc4nTqNQYDttNXZQfTyuBD2lvT8Q8@z>

On 18/09/10 20:38, Al Viro wrote:
> same thing as had been done on other targets back in 2003 -
> move setting ->restart_block.fn into {rt_,}sigreturn().
>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>

For the patch series:

Tested-by: Michael Cree <mcree@orcon.net.nz>

Cheers
Michael.
