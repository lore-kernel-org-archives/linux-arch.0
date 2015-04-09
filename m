Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932689AbbDIIgb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Apr 2015 04:36:31 -0400
Message-ID: <55263A07.6040508@nod.at>
Date: Thu, 09 Apr 2015 10:36:23 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/11] an introduction of library operating system
 for Linux (LibOS)
References: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp>	<551164ED.5000907@nod.at>	<m2twxacw13.wl@sfc.wide.ad.jp>	<55117565.6080002@nod.at>	<m2sicuctb2.wl@sfc.wide.ad.jp>	<55118277.5070909@nod.at>	<m2bnjhcevt.wl@sfc.wide.ad.jp>	<55133BAF.30301@nod.at>	<m2h9t7bubh.wl@wide.ad.jp>	<5514560A.7040707@nod.at>	<m28uejaqyn.wl@wide.ad.jp>	<55152137.20405@nod.at>	<m2sicnalnh.wl@sfc.wide.ad.jp>	<5518F030.4040003@nod.at> <m2y4md7gmb.wl@wide.ad.jp>
In-Reply-To: <m2y4md7gmb.wl@wide.ad.jp>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <tazaki@wide.ad.jp>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, jdike@addtoit.com, rusty@rustcorp.com.au, mathieu.lacage@gmail.com
Message-ID: <20150409083623.UfI88H3GTZbooGhHyeKodHRe-nruiYqgxjmNgdWQWmo@z>

Am 31.03.2015 um 09:47 schrieb Hajime Tazaki:
> right now arch/lib/Makefile isn't fully on the Kbuild
> system: build file dependency is not tracked at all.
> 
> while I should learn more about Kbuild, I'd be happy if you
> would suggest how the Makefile should be.

You definitely have to use Kbuild.
Please bite the bullet and dig into it. Maybe we
need also new functions in Kbuild to support a library mode.
Who knows? ;)

Thanks,
//richard
