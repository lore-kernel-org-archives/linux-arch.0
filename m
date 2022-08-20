Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AB9C25B08
	for <linux-arch@archiver.kernel.org>; Sat, 20 Aug 2022 09:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbiHTJha (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 20 Aug 2022 05:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbiHTJh0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 05:37:26 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFD201B4;
        Sat, 20 Aug 2022 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1660988244;
        bh=NbS47qUpS5b3B94luHG1GnOEBxFKcFZNFyfnGjSxWwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ghGjnt7GlseJs/DuNwSCDVrTcnlKG4vJ9xgTQAk9sv2pBoVdBUTcOic0y1dOOSJH8
         b0VFVSruf2uzUS62RNw3yxgvzjAxHueBPqJDB7ut953GRdeF00IGq9pHHX2zrNbsyE
         nELEYKwRUYLpwStXmjmP4Qv8GnaTZzjWbg5KzhDo=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A41F6669F1;
        Sat, 20 Aug 2022 05:37:20 -0400 (EDT)
Message-ID: <27081961433ca26e01af8709fa04e4a6ee755690.camel@xry111.site>
Subject: Re: [PATCH V2 1/2] LoongArch: Add CPU HWMon platform driver
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sat, 20 Aug 2022 17:37:18 +0800
In-Reply-To: <CAAhV-H6OaMOnhddiY2WSjiag5sFwAG6gab2m22nZonjnUbCN9w@mail.gmail.com>
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
         <98d716a4-04de-ff32-1bbc-cac576989a87@loongson.cn>
         <ce96bcc9bf0aa24d1be5a91d07e6e7515c4d0c33.camel@xry111.site>
         <5d338fcd-d225-6fe1-1b94-0fce94a3fb0f@loongson.cn>
         <CAAhV-H6OaMOnhddiY2WSjiag5sFwAG6gab2m22nZonjnUbCN9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-08-19 at 18:12 +0800, Huacai Chen wrote:
> Hi, all,
>=20
> If ACPI TZ is widely configured, this patch can be dropped, but I
> found most users don't have ACPI TZ in their machines.

I know almost nothing about ACPI.  Can ACPI TZ be provided by a firmware
update, or it needs a hardware modification (rewire the PCB or replace
some chip)?  If only a firmware change is needed we can inform the
firmware team to implement it (currently UEFI-compliant firmware is
still at beta stage anyway).


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
