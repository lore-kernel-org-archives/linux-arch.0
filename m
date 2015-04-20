From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 01/11] linux/time64.h:Introduce the 'struct itimerspec64'
 for 64bit
Date: Mon, 20 Apr 2015 12:49:17 +0300
Message-ID: <5534CB9D.1080600@cogentembedded.com>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org> <1429509459-17068-2-git-send-email-baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34516 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbbDTJtV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Apr 2015 05:49:21 -0400
Received: by lbcga7 with SMTP id ga7so126299494lbc.1
        for <linux-arch@vger.kernel.org>; Mon, 20 Apr 2015 02:49:20 -0700 (PDT)
In-Reply-To: <1429509459-17068-2-git-send-email-baolin.wang@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>, tglx@linutronix.de
Cc: arnd@arndb.de, john.stultz@linaro.org, heenasirwani@gmail.com, pang.xunlei@linaro.org, peterz@infradead.org, rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org, richardcochran@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com, tj@kernel.org, fweisbec@gmail.com, ahh@google.com, pjt@google.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, y2038@lists.linaro.org

Hello.

On 4/20/2015 8:57 AM, Baolin Wang wrote:

> This patch introduces the 'struct itimerspec64' for 64bit to replace itimerspec,
> and also introduces the conversion methods: itimerspec64_to_itimerspec() and
> itimerspec_to_itimerspec64(), that makes itimerspec to ready for 2038 year.

    "To" not needed here.

> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

[...]

WBR, Sergei
