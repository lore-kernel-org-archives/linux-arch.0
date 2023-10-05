Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF197E92707
	for <linux-arch@archiver.kernel.org>; Thu,  5 Oct 2023 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjJEOnO (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjJEOhn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2023 10:37:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6894E358;
        Thu,  5 Oct 2023 07:03:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFFCC2BCFE;
        Thu,  5 Oct 2023 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696501633;
        bh=4fxCXTLyJSEnYgLs6b+JCuhTnShTf/CIKp0OZexQrj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHqX91JuhSpBSMK2o5ESJ0CBb18LLzCffYRKge9Capj2sJtPUdKCWOaxUiEofWFwy
         YXYbGFcxtC72+SdtbwVaoy04zAaGLRi5fcM2EwOsKJDm8EESrPXXCLBrKNo9yC3Sf6
         J/H2XeTyxw7J+SIcHLdbKmLBsKxTOxNeiNxlLrWI=
Date:   Thu, 5 Oct 2023 12:27:10 +0200
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
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023100517-rogue-gopher-e70f@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> +/* Define connection identifier type. */
> +union hv_connection_id {
> +	__u32 asu32;
> +	struct {
> +		__u32 id:24;
> +		__u32 reserved:8;

Meta-commment, I don't see anywhere you are properly checking that all
of the "reserved" areas of these structures are actually set to 0 when
they are sent to you.  If you don't do that, then they are not really
reserved at all and can never be used in the future, so properly check
them please.

thanks,

greg k-h
