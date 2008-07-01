From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [PATCH 00/20] mm: generic show_mem() v4
Date: Tue, 01 Jul 2008 09:54:11 +0200
Message-ID: <87iqvq59b0.fsf@skyscraper.fehenstaub.lan>
References: <20080627115349.743368154@saeurebad.de>
	<8763rq6qlc.fsf@skyscraper.fehenstaub.lan>
	<20080701002518.7918fdaf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:51269 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbYGAHys (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Jul 2008 03:54:48 -0400
In-Reply-To: <20080701002518.7918fdaf.akpm@linux-foundation.org> (Andrew
	Morton's message of "Tue, 1 Jul 2008 00:25:18 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi,

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 01 Jul 2008 08:55:27 +0200 Johannes Weiner <hannes@saeurebad.de> wrote:
>
>> Hi,
>> 
>> Johannes Weiner <hannes@saeurebad.de> writes:
>> 
>> > Every arch implements its own show_mem() function.  Most of them share
>> > quite some code, some of them are completely identical.
>> >
>> > This series implements a generic version of this function and migrates
>> > almost all architectures to it.
>> >
>> > version 4:
>> > 	- rebased against -mmotm
>> 
>> Oh, btw, do you even want them, Andrew?
>
> These are only a few hundred patches ahead of my current backlog cursor
> :( I should be caught up mid-weekish.
>
>>  Or should I base this set on
>> Linus' tree directly?
>
> That would be a bad step.  Linus's tree is 2.6.26 whereas we're all
> developing 2.6.27.  There's a ~30MB diff between the two.

Alright, I will keep them against -mmotm and resend them soon without
the Kconfig stuff as suggested by Paul Mundt.

	Hannes
