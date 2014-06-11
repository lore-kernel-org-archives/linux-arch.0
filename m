Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:53292 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbaFKWSn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jun 2014 18:18:43 -0400
Message-ID: <5398D59A.3030900@zytor.com>
Date: Wed, 11 Jun 2014 15:18:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
References: <cover.1402517933.git.luto@amacapital.net> <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net> <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com> <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
In-Reply-To: <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Message-ID: <20140611221802.k6kpprrNj89RVlTXz9m5fh8_D6ZMd6YcSbc5IzBYbqw@z>

On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
> 
> 13ns is with the simplest nonempty filter.  I hope that empty filters
> don't work.
> 

Why wouldn't they?

	-hpa


