Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:55168 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbfJNO1v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Oct 2019 10:27:51 -0400
Date: Mon, 14 Oct 2019 16:27:42 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v9 07/28] x86/boot: Annotate local functions
Message-ID: <20191014142742.GD4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-8-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-8-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191014142742.M2_ogz8Zc67IAXTsKj4zTeN0zdZrELu0kghZK_LFolo@z>

On Fri, Oct 11, 2019 at 01:50:47PM +0200, Jiri Slaby wrote:
> .Lrelocated, .Lpaging_enabled, .Lno_longmode, and .Lin_pm32 are
> self-standing local functions, annotate them as such and preserve "no
> alignment".
> 
> The annotations do not generate anything yet.

So the annotation is only documentational, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
