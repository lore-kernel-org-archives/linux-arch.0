Return-Path: <SRS0=26Yk=DW=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37235C43457
	for <linux-arch@archiver.kernel.org>; Thu, 15 Oct 2020 10:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8ED52224A
	for <linux-arch@archiver.kernel.org>; Thu, 15 Oct 2020 10:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F3WHwom+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgJOKkx (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:40:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgJOKkx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 06:40:53 -0400
Received: from zn.tnic (p200300ec2f0ed200d49a97be428f152e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:d49a:97be:428f:152e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0AC91EC0380;
        Thu, 15 Oct 2020 12:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602758451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Abf5zJCUocMG84tO1Pd+Xb6Qhr0rk+bSHfEj4Vlqxd4=;
        b=F3WHwom+f2AaCQnFVubyh6NXdgmTO8cBPfzN1CVoIwCgUutY6WNq8U99A80sZxKZuBsXfF
        2BGYherJ7zeV3DmaxFdR/ctcCjCf1EDr+5/7BK51je/nHraVR2/KHL9iWnH9jnMbN77iA+
        Q2cMrVCV0giQg0NYucq/KUbUIRSASeY=
Date:   Thu, 15 Oct 2020 12:40:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
Message-ID: <20201015104047.GD11838@zn.tnic>
References: <20201014195823.GC18196@zn.tnic>
 <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
 <50286c32-2869-cbd5-b178-0ad0c13584ea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50286c32-2869-cbd5-b178-0ad0c13584ea@oracle.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 08:21:57PM -0700, Ankur Arora wrote:
> Also, if we did extend clear_page() to take the page-size as parameter
> we still might not have enough information (ex. a 4K or a 2MB page that
> clear_page() sees could be part of a GUP of a much larger extent) to
> decide whether to go uncached or not.

clear_page* assumes 4K. All of the lowlevel asm variants do. So adding
the size there won't bring you a whole lot.

So you'd need to devise this whole thing differently. Perhaps have a
clear_pages() helper which decides based on size what to do: uncached
clearing or the clear_page() as is now in a loop.

Looking at the callsites would give you a better idea I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
