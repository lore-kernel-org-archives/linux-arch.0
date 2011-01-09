From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv1 02/12] unicore32 core architecture: generic headers stuff
Date: Sun, 9 Jan 2011 01:36:35 +0100
Message-ID: <201101090136.35793.arnd@arndb.de>
References: <00c801cba463$b0f3db00$12db9100$@mprc.pku.edu.cn> <201101070055.53996.arnd@arndb.de> <023a01cbaf1b$3022b5b0$90682110$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63559 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1AIAgm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2011 19:36:42 -0500
In-Reply-To: <023a01cbaf1b$3022b5b0$90682110$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 08 January 2011, Guan Xuetao wrote:
> > I think we discussed this particular header before. There should be no reason
> > to have your own version instead of using the generic file like you do for the
> > rest of the API headers.
>
> The generic-version stat.h can't work for existing binary file systems in unicore32.
> I will submit a patch for generic-version stat.h for discussion.

But the generic version of stat.h goes together with the generic version of unistd.h,
which the code you submitted is now using.

I understand that you are using a patch to use the traditional system call table
right now, on top of the generalized code. Can't you use the same patch for the
stat.h file?

	Arnd
