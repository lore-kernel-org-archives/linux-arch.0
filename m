Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44984 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422971AbbD2NYp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Apr 2015 09:24:45 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YnRym-003FTA-7s
	for linux-arch@vger.kernel.org; Wed, 29 Apr 2015 13:24:44 +0000
Message-ID: <5540DB99.1070800@roeck-us.net>
Date: Wed, 29 Apr 2015 06:24:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
Subject: Re: [PATCH v9 00/17] Re-introduce h8300 architecture
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>	<20150428132210.GA7499@roeck-us.net>	<87pp6oi2qy.wl-ysato@users.sourceforge.jp>	<55405F08.7020508@roeck-us.net> <87lhhbihcf.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87lhhbihcf.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150429132441.KdD0_eR2EQGbA3o2TzjdpWxcKdiOjJLxEkZTQWe_e80@z>

On 04/28/2015 11:22 PM, Yoshinori Sato wrote:

>
> OK.
> I made h8300-*-linux target patch for release version.
> Please apply and rebuild to "h8300-unknown-linux"
> http://sourceforge.jp/projects/uclinux-h8/releases/p14625
>
The binutils patch is similar to the one upstream, but I think
you might want to check if the latest upstream code is still
working as intended. The patch was later augmented with
'Fix recent h8300 configury changes' which, among other changes,
removed the GENSCRIPTS lines.

Thanks,
Guenter

