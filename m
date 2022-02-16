Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B23C433FE
	for <linux-arch@archiver.kernel.org>; Wed, 16 Feb 2022 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiBPM3D (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:29:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBPM3D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 07:29:03 -0500
X-Greylist: delayed 208 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 04:28:51 PST
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384672A39F6;
        Wed, 16 Feb 2022 04:28:51 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nKJMq-001i9z-E2; Wed, 16 Feb 2022 13:25:08 +0100
Received: from p5b13a545.dip0.t-ipconnect.de ([91.19.165.69] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nKJMq-003dqC-70; Wed, 16 Feb 2022 13:25:08 +0100
Message-ID: <9cac37da-f719-13f8-1a21-2aac7a574479@physik.fu-berlin.de>
Date:   Wed, 16 Feb 2022 13:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 00/13] Fix LKDTM for PPC64/IA64/PARISC v4
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <cover.1644928018.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.165.69
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On 2/15/22 13:40, Christophe Leroy wrote:
> PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
> on those three architectures because LKDTM messes up function
> descriptors with functions.
> 
> This series does some cleanup in the three architectures and
> refactors function descriptors so that it can then easily use it
> in a generic way in LKDTM.

I'll test the series on ia64 later this week. I have an Itanium box at
home for testing kernel patches.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

