Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:50576 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbaG1Xfd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jul 2014 19:35:33 -0400
Message-ID: <53D6DE1E.1060501@zytor.com>
Date: Mon, 28 Jul 2014 16:34:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
References: <cover.1405992946.git.luto@amacapital.net>	<CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>	<CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>	<53D68F91.4000106@zytor.com> <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-arch <linux-arch@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Will Drewry <wad@chromium.org>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@plumgrid.com>
Message-ID: <20140728233454.UXhOJcB_8KG0jyrI1DUGwe3NUqxffaotfihD3qihAGw@z>

On 07/28/2014 04:29 PM, Kees Cook wrote:
> On Mon, Jul 28, 2014 at 10:59 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
>>>
>>> It looks like patches 1-4 have landed here:
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>>
>>> hpa, what's the route forward for the x86 part?
>>>
>>
>> I guess I should discuss this with Kees to figure out what makes most
>> sense.  In the meantime, could you address Oleg's question?
> 
> Since the x86 parts depend on the seccomp parts, I'm happy if you
> carry them instead of having them land from my tree. Otherwise I'm
> open to how to coordinate timing.
> 

You mean for me to carry the seccomp part as well?

	-hpa


