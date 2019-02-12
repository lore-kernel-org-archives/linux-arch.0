Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54413 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLLvN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 06:51:13 -0500
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz> <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
 <20190212110501.GB30028@zn.tnic>
 <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
 <20190212114654.GC30028@zn.tnic>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
Date: Tue, 12 Feb 2019 12:51:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190212114654.GC30028@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190212115108.DDWb2PFLbpEGexJ5Hl2Q3A4Go5yIm4o0Beb2vTHLAJA@z>

On 12. 02. 19, 12:46, Borislav Petkov wrote:
> On Tue, Feb 12, 2019 at 12:38:09PM +0100, Jiri Slaby wrote:
>> OK, so I will switch all the *LOCAL* to .L prefix (perhaps as a separate
>> patch prior the series/post the series)?
> 
> Sure.
> 
> I have been doing that off and on but apparently this undertaking
> resembles the whack-a-mole game. :-)

And what if the LOCAL macros prepend .L automatically? The references
would need to be via macro or by manually adding .L. I mean:

SYM_CODE_START_LOCAL(function)
  ret
SYM_CODE_END(function)

And then used as:
call .Lfunction
or
call SYM_LOCAL(function)

Is that too ugly?

thanks,
-- 
js
suse labs
