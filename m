From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] sysctl: Enable IA64 "ignore-unaligned-usertrap" to
 be used cross-arch
Date: Thu, 10 Jan 2013 09:43:07 +0530
Message-ID: <50EE3FD3.7020105@synopsys.com>
References: <50ED7B4B.7080603@synopsys.com> <1357742188-8941-1-git-send-email-vgupta@synopsys.com> <CA+8MBbJNrJYeZoGXt37ki_YCpb7kqiE1toFoBBHrtmnY8a75VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:42039 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443Ab3AJEOp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2013 23:14:45 -0500
In-Reply-To: <CA+8MBbJNrJYeZoGXt37ki_YCpb7kqiE1toFoBBHrtmnY8a75VA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 10 January 2013 12:25 AM, Tony Luck wrote:
> Ok. Queued for 3.9 merge window.  It should show up in linux-next in
> the next day or two.  We'll see if anyone complains about the name
> SYSCTL_ARCH_UNALIGN_NO_WARN (every time I touch the Kconfig
> bits it seems that there is some other, better way that we do this now).
>
> -Tony

Thanks a bunch.
-Vineet
