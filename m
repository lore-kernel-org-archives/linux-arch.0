From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 50/76] ARC: SMP support
Date: Fri, 18 Jan 2013 14:53:29 +0000
Message-ID: <201301181453.29243.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-51-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58235 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab3AROxd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:53:33 -0500
In-Reply-To: <1358511930-7424-51-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Rajeshwar Ranga <rajeshwar.ranga@gmail.com>, Noam Camus <noamc@ezchip.com>, Gilad Ben-Yossef <gilad@benyossef.com>

On Friday 18 January 2013, Vineet Gupta wrote:
> +# If a plat can do IPI, same core(s) can do minimal SMP
> +config ARC_HAS_IPI
> +       bool
> +

I think it would be better to turn the logic around here,
otherwise you get into trouble when enabling multiple
platforms, out of which some have IPI support and others
don't.

Instead, you can mark the platforms that lack IPI support
(or multiple CPUs) as 'depends on !SMP'.

	Arnd
