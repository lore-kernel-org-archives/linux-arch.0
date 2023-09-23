Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667ACE7A88
	for <linux-arch@archiver.kernel.org>; Sat, 23 Sep 2023 07:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjIWH4W (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 23 Sep 2023 03:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIWH4V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Sep 2023 03:56:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5D180;
        Sat, 23 Sep 2023 00:56:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E146C433C7;
        Sat, 23 Sep 2023 07:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695455775;
        bh=LqG3KPeWI7ENhJ299tmnxeWZpLoJ9oK5WScmGb/OaoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KsEwi/WPhH2PeWr5n3kqJVm61b2bAT6V/rKTA97CCsqNvmhjQGgIXgW5l0Dys5kmG
         dSN7bG6Ont1BZjdbOo9tyYbTedXAP9LufpoacZBjjVyXFTt8be8rg0idiiej5rAiK4
         mfgwaPPOz3epU4y4HTGgvSUA+hzUA8DuCEYXAheE=
Date:   Sat, 23 Sep 2023 09:56:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023092318-starter-pointing-9388@gregkh>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 22, 2023 at 11:38:35AM -0700, Nuno Das Neves wrote:
> +static int __init mshv_vtl_init(void)
> +{
> +	int ret;
> +
> +	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
> +	init_waitqueue_head(&fd_wait_queue);
> +
> +	if (mshv_vtl_get_vsm_regs()) {
> +		pr_emerg("%s: Unable to get VSM capabilities !!\n", __func__);
> +		BUG();
> +	}


So you crash the whole kernel if someone loads this module on a non-mshv
system?

That seems quite excessive and hostile :(

Or am I somehow reading this incorrectly?

thanks,

greg k-h
