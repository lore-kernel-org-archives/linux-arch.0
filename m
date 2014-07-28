Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47703 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaG1SAc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jul 2014 14:00:32 -0400
Message-ID: <53D68F91.4000106@zytor.com>
Date: Mon, 28 Jul 2014 10:59:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
References: <cover.1405992946.git.luto@amacapital.net> <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com> <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
In-Reply-To: <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>
Message-ID: <20140728175945.u4DDXjUzNioEf_tJslDH4Cb2wOWZaPhyJRuazTeySVU@z>

On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
> 
> It looks like patches 1-4 have landed here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
> 
> hpa, what's the route forward for the x86 part?
> 

I guess I should discuss this with Kees to figure out what makes most
sense.  In the meantime, could you address Oleg's question?

	-hpa


