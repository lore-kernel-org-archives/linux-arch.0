Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:45381 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933863Ab3AIVDw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2013 16:03:52 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <50ED7B4B.7080603@synopsys.com>
	<1357742188-8941-1-git-send-email-vgupta@synopsys.com>
	<CA+8MBbJNrJYeZoGXt37ki_YCpb7kqiE1toFoBBHrtmnY8a75VA@mail.gmail.com>
Date: Wed, 09 Jan 2013 13:03:42 -0800
In-Reply-To: <CA+8MBbJNrJYeZoGXt37ki_YCpb7kqiE1toFoBBHrtmnY8a75VA@mail.gmail.com>
	(Tony Luck's message of "Wed, 9 Jan 2013 10:55:27 -0800")
Message-ID: <876236ul01.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2] sysctl: Enable IA64 "ignore-unaligned-usertrap" to be used cross-arch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@gmail.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Fenghua Yu <fenghua.yu@intel.com>, Serge Hallyn <serge.hallyn@canonical.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20130109210342.w-9H6jzCPTVEKZ-A2pkomw837Ng0h920R5W77VT7JS8@z>

Tony Luck <tony.luck@gmail.com> writes:

> Ok. Queued for 3.9 merge window.  It should show up in linux-next in
> the next day or two.  We'll see if anyone complains about the name
> SYSCTL_ARCH_UNALIGN_NO_WARN (every time I touch the Kconfig
> bits it seems that there is some other, better way that we do this
> now).

The other semi-sane way I could see to do this would be to break the
code out of kernel/sysctl.c into it's own sysctl table and have the
arches that want this sysctl just register it themselves.

Shrug.  It probably isn't worth the effor right now.

Eric
