Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964794AbbC0JWI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Mar 2015 05:22:08 -0400
Message-ID: <55152137.20405@nod.at>
Date: Fri, 27 Mar 2015 10:21:59 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/11] an introduction of library operating system
 for Linux (LibOS)
References: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp>	<551164ED.5000907@nod.at>	<m2twxacw13.wl@sfc.wide.ad.jp>	<55117565.6080002@nod.at>	<m2sicuctb2.wl@sfc.wide.ad.jp>	<55118277.5070909@nod.at>	<m2bnjhcevt.wl@sfc.wide.ad.jp>	<55133BAF.30301@nod.at>	<m2h9t7bubh.wl@wide.ad.jp>	<5514560A.7040707@nod.at> <m28uejaqyn.wl@wide.ad.jp>
In-Reply-To: <m28uejaqyn.wl@wide.ad.jp>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <tazaki@wide.ad.jp>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, jdike@addtoit.com, rusty@rustcorp.com.au, mathieu.lacage@gmail.com
Message-ID: <20150327092159.XgiC7y2AotBT8vT59pfwl8T3ZfhPUv7xCoX3Ukz8-kA@z>

Am 27.03.2015 um 07:34 schrieb Hajime Tazaki:
>>> it (arch/lib) is a hardware-independent architecture which
>>> provides necessary features to the remainder of kernel code,
>>> isn't it ?
>>
>> The stuff in arch/ is the code to glue the kernel to
>> a specific piece of hardware.
>> Your code does something between. You duplicate kernel core features
>> to make a specific piece of code work in userland.
> 
> indeed, 'something between' would be an appropriate word.

Just an idea popping out of my head...

What about putting libos into tools/testing/ and make it much more generic and framework alike.
With more generic I mean that libos could be a stubbing framework for the kernel.
i.e. you specify the subsystem you want to test/stub and the framework helps you doing so.
A lot of the stubs you're placing in arch/lib could be auto-generated as the
vast majority of all kernel methods you stub are no-ops which call only lib_assert(false).

Using that approach only very few kernel core components have to be duplicated and
actually implemented by hand.
Hence, less maintenance overhead and libos is not broken all the time.

What do you think?

Thanks,
//richard
