Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:38988 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfBEIHY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Feb 2019 03:07:24 -0500
Date: Tue, 5 Feb 2019 09:07:12 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 03/28] x86/asm/suspend: use SYM_DATA for data
Message-ID: <20190205080712.GF21801@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-4-jslaby@suse.cz>
 <20190204201831.GK29639@zn.tnic>
 <975ba79b-5a3d-b244-7d00-869b1da246b9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <975ba79b-5a3d-b244-7d00-869b1da246b9@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
Message-ID: <20190205080712.aqbM-eYO7ZCjgAjq91X1VGq-ndbGmvpEPHfA5OvRfYA@z>

On Tue, Feb 05, 2019 at 08:34:09AM +0100, Jiri Slaby wrote:
> I also suggest noticing the size 0 -> 8 change ;).

Ha!

And one would think that binutils would've seen the ".quad 0" in the
previous definition and do a proper size but that wouldn't have worked
most likely, because before it was a simple label with alignment:

.globl saved_magic ; .p2align 4, 0x90 ; saved_magic: .quad 0

which didn't have a size probably because it didn't have an associated
type (or an implicit default type or so, no clue how binutils handles
labels).

VS now:

.globl saved_magic ; ; saved_magic: ; .quad 0 ; .type saved_magic STT_OBJECT ; .size saved_magic, .-saved_magic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
