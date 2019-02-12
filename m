Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:43178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBLLrB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Feb 2019 06:47:01 -0500
Date: Tue, 12 Feb 2019 12:46:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190212114654.GC30028@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
 <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
 <20190212110501.GB30028@zn.tnic>
 <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190212114654.bUGZeeIuQXDrI6YCCGL8aKv15eQSHfRxftW_B6Jm_bc@z>

On Tue, Feb 12, 2019 at 12:38:09PM +0100, Jiri Slaby wrote:
> OK, so I will switch all the *LOCAL* to .L prefix (perhaps as a separate
> patch prior the series/post the series)?

Sure.

I have been doing that off and on but apparently this undertaking
resembles the whack-a-mole game. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
