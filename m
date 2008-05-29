From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: [PATCH 2/2] on_each_cpu(): kill unused 'retry' parameter
Date: Thu, 29 May 2008 09:51:51 -0300
Message-ID: <20080529125151.GA25124@Pilar.ictp.trieste.it>
References: <1212051661-12733-1-git-send-email-jens.axboe@oracle.com> <1212051661-12733-3-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:58270 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbYE2Msq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 08:48:46 -0400
Received: by ug-out-1314.google.com with SMTP id h2so83699ugf.16
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 05:48:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1212051661-12733-3-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com

Hi,

Just a naive comment/question:

> -	if (on_each_cpu(ipi_imb, NULL, 1, 1))
> +	if (on_each_cpu(ipi_imb, NULL, 1))

A few weeks ago I though about removing the second argument
from on_each_cpu, which is NULL more or less 70% of the time.

Do you think it is possible?
Have you already thought about it? 
