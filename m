From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LMB bits
Date: Tue, 13 Jul 2010 08:11:57 -0700
Message-ID: <AANLkTikkqL9ppLDaLP6ISkuAawgGF-4ly28sAhdLW3AM@mail.gmail.com>
References: <4C38DDE3.9010303@kernel.org>
	<1278905081.28659.157.camel@pasglop>
	<1278920286.28659.194.camel@pasglop>
	<20100712.153455.108790468.davem@davemloft.net>
	<1279005164.28659.407.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52940 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756855Ab0GMPMU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Jul 2010 11:12:20 -0400
Received: from mail-gw0-f46.google.com (mail-gw0-f46.google.com [74.125.83.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o6DFC49n011521
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Tue, 13 Jul 2010 08:12:19 -0700
Received: by gwj18 with SMTP id 18so2758538gwj.19
        for <linux-arch@vger.kernel.org>; Tue, 13 Jul 2010 08:11:58 -0700 (PDT)
In-Reply-To: <1279005164.28659.407.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, yinghai@kernel.org, mingo@elte.hu, hpa@zytor.com, tglx@linutronix.de, linux-arch@vger.kernel.org

On Tue, Jul 13, 2010 at 12:12 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Ingo, Linus, how to you want to proceed ? We could get the rename patch
> in now, that would make things easier for the ARM folks who have started
> using LMB as well and are currently clashing in linux-next, and keep the
> rest of the rework for the merge window ? Or keep the whole thing for
> the merge window ?

If it's just a rename, and the accidental lmb renames have been all
sorted out, then I'm ok with taking a pure rename that changes nothing
else now, just to make things easier to merge later.

                        Linus
