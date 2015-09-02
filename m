Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56186 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102AbbIBUQq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 2 Sep 2015 16:16:46 -0400
Message-ID: <55E75913.5050605@zytor.com>
Date: Wed, 02 Sep 2015 13:16:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: Wire up 32-bit direct socket calls
References: <cb5138299d37d5800e2d135b01a7667fa6115854.1436912629.git.luto@kernel.org> <CAMuHMdXKA_+JY2ryf-yoJxQnbW=jsOjj_w2-Nsybpx0310neDA@mail.gmail.com>
In-Reply-To: <CAMuHMdXKA_+JY2ryf-yoJxQnbW=jsOjj_w2-Nsybpx0310neDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, Network Development <netdev@vger.kernel.org>, Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Larsson <alexl@redhat.com>, Cosimo Cecchi <cosimo@endlessm.com>, Dan Nicholson <nicholson@endlessm.com>, libc-alpha <libc-alpha@sourceware.org>, Rajalakshmi Srinivasaraghavan <raji@linux.vnet.ibm.com>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20150902201619.Ki0IDv8w8sGojKl5-kCCijMu6P2pap6yAI4UzvnnY40@z>

On 09/02/2015 02:48 AM, Geert Uytterhoeven wrote:
> 
> Should all other architectures follow suit?
> Or should we follow the s390 approach:
> 

It is up to the maintainer(s), largely dependent on how likely you are
going to want to support this in your libc, but in general, socketcall
is an abomination which there is no reason not to bypass.

So follow suit unless you have a strong reason not to.

	-hpa


