From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 37/73] alpha: delete non-required instances of <linux/init.h>
Date: Tue, 21 Jan 2014 16:32:47 -0800
Message-ID: <52DF11AF.2000903@twiddle.net>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-38-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53664 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbaAVAcx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 19:32:53 -0500
In-Reply-To: <1390339396-3479-38-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org

On 01/21/2014 01:22 PM, Paul Gortmaker wrote:
> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.

Acked-by: Richard Henderson <rth@twiddle.net>


r~
