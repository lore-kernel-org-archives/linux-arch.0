From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC 07/12] sh, rwsem: provide __down_write_killable
Date: Wed, 3 Feb 2016 14:19:05 +0300
Message-ID: <56B1E229.3060605@cogentembedded.com>
References: <1454444369-2146-1-git-send-email-mhocko@kernel.org>
 <1454444369-2146-8-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36613 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbcBCLTJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2016 06:19:09 -0500
Received: by mail-lf0-f51.google.com with SMTP id 78so11406176lfy.3
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2016 03:19:08 -0800 (PST)
In-Reply-To: <1454444369-2146-8-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>

Hello.

On 2/2/2016 11:19 PM, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
>
> which is uses the same fast path as __down_write except it falls back to

    s/is//. Same typo (?) in the other patches...

> rwsem_down_write_failed_killable slow path and return -EINTR if killed.
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

[...]

MBR, Sergei
