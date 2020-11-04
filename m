Return-Path: <SRS0=RprN=EK=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E13C4741F
	for <linux-arch@archiver.kernel.org>; Wed,  4 Nov 2020 12:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B63223AB
	for <linux-arch@archiver.kernel.org>; Wed,  4 Nov 2020 12:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDMKz (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 4 Nov 2020 07:10:55 -0500
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:46204 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgKDMKz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Nov 2020 07:10:55 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 07:10:54 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id D8635180188D5
        for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2020 12:04:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 66BDE180A7FE2;
        Wed,  4 Nov 2020 12:04:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: turn90_630e8ab272c1
X-Filterd-Recvd-Size: 2099
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Nov 2020 12:04:01 +0000 (UTC)
Message-ID: <92d39ff1408078a656c43bee24e7e9b3e3815e72.camel@perches.com>
Subject: Re: get_maintainer.pl bug? (was: Re: [PATCH 0/8] linker-section
 array fix and clean ups)
From:   Joe Perches <joe@perches.com>
To:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Wed, 04 Nov 2020 04:04:00 -0800
In-Reply-To: <20201104091625.GP4085@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
         <20201104091625.GP4085@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-11-04 at 10:16 +0100, Johan Hovold wrote:
> Running scrips/get_maintainer.pl on this series [1] gave the wrong
> address for Nick Desaulniers:
> 
> 	Nick Desaulniers <ndesaulniers@gooogle.com> (commit_signer:1/2=50%,commit_signer:1/8=12%)
> 
> It seems he recently misspelled his address in a reviewed-by tag to
> commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
> to __section("foo")") and that is now being picked up by the script.
> 
> I guess that's to be considered a bug?

No, that's a feature.  If it's _really_ a problem, (and I don't
think it really is), that's what .mailmap is for.


