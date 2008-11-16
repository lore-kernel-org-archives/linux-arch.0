From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/2] Add dev.mem.restricted sysctl
Date: Sun, 16 Nov 2008 01:11:04 +0100
Message-ID: <20081116011104.10114522@kopernikus.site>
References: <1226793823-32360-1-git-send-email-bwalle@suse.de>
	<1226793823-32360-3-git-send-email-bwalle@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55281 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbYKPALG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 15 Nov 2008 19:11:06 -0500
In-Reply-To: <1226793823-32360-3-git-send-email-bwalle@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

* Bernhard Walle [2008-11-16 01:03]:
>
> +
> +static const struct trans_ctl_table trans_mem_table[] = {
> +	{ DEV_MEM_RESTRICTED,	"restricted" },
> +	{}
> +};

Noticed that we either need to put everything into CONFIG_STRICT_DEVMEM
or nothing. But I want to head opinions if the concept can be accepted
before I repost.



Regards,
Bernhard
