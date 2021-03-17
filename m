Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5281C433E0
	for <linux-arch@archiver.kernel.org>; Wed, 17 Mar 2021 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832EC64F67
	for <linux-arch@archiver.kernel.org>; Wed, 17 Mar 2021 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCQO2x (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhCQO2S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 10:28:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5CEC06174A
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 07:28:17 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMX9f-00HNv6-7e; Wed, 17 Mar 2021 15:28:11 +0100
Message-ID: <3d3e446409d00dfbe62320832799d0a3b34b2b9c.camel@sipsolutions.net>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Octavian Purdila <tavi.purdila@gmail.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Date:   Wed, 17 Mar 2021 15:28:10 +0100
In-Reply-To: <CAMoF9u2phDz5nmFFSW-9VKs2gTK0exHaPxrOf4nM5gAQnQhcRQ@mail.gmail.com> (sfid-20210317_152001_277313_6713C6E5)
References: <cover.1611103406.git.thehajime@gmail.com>
         <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
         <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
         <m25z1rc2ux.wl-thehajime@gmail.com>
         <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
         <CAMoF9u2phDz5nmFFSW-9VKs2gTK0exHaPxrOf4nM5gAQnQhcRQ@mail.gmail.com>
         (sfid-20210317_152001_277313_6713C6E5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-03-17 at 16:19 +0200, Octavian Purdila wrote:
> > I can understand that your sample code wants btrfs just to show what it
> > can do, but IMHO it doesn't make sense to *always* enable it.

Btw, what I said there also didn't distinguish between "always enable
it" and "always force it enabled".

Right now this patch did the latter, but the former might sort of make
sense, but would take the form of a defconfig rather than a Kconfig code
change.

> 
> I agree. I think these can stay in defconfigs but here is where a
> library introduces complications which I don't know how is best to
> handle. Should we have the defconfig in arch/um or should we have it
> in tools/testing/selftests/um? Or perhaps both places, one being a
> generic config that would be used by most applications and one
> customized?

Yeah, that's a question - and in that sense LKL will never be a general-
purpose "library" since then you'd have to basically build it with
"allyesconfig" instead of other things.

Maybe just put a note there with the tools, and maybe a defconfig, and
then have some kind of detection at example/tool build or even runtime
that the necessary options are selected?

johannes

